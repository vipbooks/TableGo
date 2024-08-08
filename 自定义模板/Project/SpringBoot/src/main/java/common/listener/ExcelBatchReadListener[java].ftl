package ${jsonParam.packagePath}

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.exception.ExcelDataConvertException;
import com.alibaba.excel.metadata.CellExtra;
import com.alibaba.excel.metadata.data.ReadCellData;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.read.metadata.holder.ReadRowHolder;
import com.alibaba.excel.util.ListUtils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.ListUtil;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import ${jsonParam.basePackagePath}.common.exception.BizException;
import ${jsonParam.basePackagePath}.common.model.BaseExcel;

/**
 * EasyExcel导入分批读取监听器，默认按1000条一批处理，支持读取合并单元格的数据
 *
 * @see com.alibaba.excel.read.listener.PageReadListener
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Slf4j
public class ExcelBatchReadListener<T extends BaseExcel> implements ReadListener<T> {
    /**
     * Default single handle the amount of data
     */
    public static int BATCH_COUNT = 1000;

    /** 默认数据起始行，从零开始 */
    public static final int HEAD_ROW_NUMBER = 1;

    /**
     * Temporary storage of data
     */
    private List<T> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);

    /** 最终解析到的所有数据列表 */
    @Getter
    private List<T> dataList = ListUtil.toList();

    /**
     * Consumer
     */
    private final Consumer<List<T>> consumer;

    /**
     * Single handle the amount of data
     */
    private int batchCount;

    /** 数据起始行 */
    private int headRowNumber;

    public ExcelBatchReadListener(Consumer<List<T>> consumer, int batchCount, int headRowNumber) {
        this.consumer = consumer;
        this.batchCount = batchCount;
        this.headRowNumber = headRowNumber;
    }

    public ExcelBatchReadListener(Consumer<List<T>> consumer, int batchCount) {
        this.consumer = consumer;
        this.batchCount = batchCount;
        this.headRowNumber = HEAD_ROW_NUMBER;
    }

    public ExcelBatchReadListener(Consumer<List<T>> consumer) {
        this.consumer = consumer;
        this.batchCount = BATCH_COUNT;
        this.headRowNumber = HEAD_ROW_NUMBER;
    }

    /**
     * 捕获到异常会调用本接口，抛出异常则停止读取，如果这里不抛出异常则继续读取下一行
     */
    @Override
    public void onException(Exception exception, AnalysisContext context) {
        // 如果是某一个单元格的转换异常能获取到具体行号，如果要获取头的信息 配合invokeHeadMap使用
        if (exception instanceof ExcelDataConvertException) {
            ExcelDataConvertException excelDataConvertException = (ExcelDataConvertException) exception;
            Integer rowIndex = excelDataConvertException.getRowIndex();
            Integer columnIndex = excelDataConvertException.getColumnIndex();
            String value = excelDataConvertException.getCellData().getStringValue();

            String msg = String.format("导入Excel解析失败，第 %s 行，第 %s 列数据解析错误，数据为: %s，错误消息: %s", rowIndex, columnIndex, value, exception.getMessage());
            throw BizException.newInstance(msg, exception);
        } else {
            throw BizException.newInstance("导入Excel解析失败，错误消息: " + exception.getMessage(), exception);
        }
    }

    /**
     * 解析每列的表头
     */
    @Override
    public void invokeHead(Map<Integer, ReadCellData<?>> headMap, AnalysisContext context) {
        ReadListener.super.invokeHead(headMap, context);
    }

    /**
     * 解析每行数据时调用
     */
    @Override
    public void invoke(T data, AnalysisContext context) {
        // 获取数据行下标
        ReadRowHolder readRowHolder = context.readRowHolder();
        Integer rowIndex = readRowHolder.getRowIndex();
        // 第一行是表头
        data.setRowNumber(rowIndex + 1);

        cachedDataList.add(data);
        if (cachedDataList.size() >= batchCount) {
            consumer.accept(cachedDataList);
            cachedDataList = ListUtils.newArrayListWithExpectedSize(batchCount);
        }
        dataList.add(data);
    }

    /**
     * 所有数据解析完成后调用
     */
    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        if (CollUtil.isNotEmpty(cachedDataList)) {
            consumer.accept(cachedDataList);
        }
    }

    /**
     * 处理额外信息，通过 EasyExcel.read.extraRead(CellExtraTypeEnum.MERGE) 参数触发
     */
    @Override
    public void extra(CellExtra cellExtra, AnalysisContext context) {
        switch (cellExtra.getType()) {
            case MERGE: // 处理额外信息的合并单元格
                if (cellExtra.getRowIndex() >= headRowNumber) {
                    handleMergeData(dataList, cellExtra);
                }
                break;
            case COMMENT:
            case HYPERLINK:
            default:
        }
    }

    /**
     * 处理有合并单元格的数据
     *
     * @param list      解析的sheet数据
     * @param cellExtra 合并单元格信息
     */
    private void handleMergeData(List<T> list, CellExtra cellExtra) {
        // 初始化起始行
        Integer firstRowIndex = cellExtra.getFirstRowIndex() - headRowNumber;
        // 初始化结束行
        Integer lastRowIndex = cellExtra.getLastRowIndex() - headRowNumber;
        // 初始化起始列
        Integer firstColumnIndex = cellExtra.getFirstColumnIndex();
        // 初始化结束列
        Integer lastColumnIndex = cellExtra.getLastColumnIndex();
        // 获取合并单元格的初始值
        Object initValue = getInitValueFromList(firstRowIndex, firstColumnIndex, list);
        // 设置合并单元格的初始值
        for (int i = firstRowIndex; i <= lastRowIndex; i++) {
            for (int j = firstColumnIndex; j <= lastColumnIndex; j++) {
                setInitValueToList(initValue, i, j, list);
            }
        }
    }

    /**
     * 获取合并单元格的初始值，rowIndex对应list的索引，columnIndex对应实体内的字段
     *
     * @param firstRowIndex    数据列表起始行的下标索引
     * @param firstColumnIndex 数据列表起始列的下标索引
     * @param list             数据列表
     * @return 初始值
     */
    private Object getInitValueFromList(Integer firstRowIndex, Integer firstColumnIndex, List<T> list) {
        Object filedValue = null;
        // 获取指定行的数据对象
        T obj = list.get(firstRowIndex);
        for (Field field : obj.getClass().getDeclaredFields()) {
            // 通过ExcelProperty注解上的 index 属性定位数据列的位置
            ExcelProperty annotation = field.getAnnotation(ExcelProperty.class);
            if (annotation == null || annotation.index() != firstColumnIndex) {
                continue;
            }
            try {
                // 屏蔽Java语言的访问检查，使得对象的私有属性也可以被查询和修改
                field.setAccessible(true);
                filedValue = field.get(obj);
                break;
            } catch (Exception e) {
                log.error("获取合并单元格的初始值异常: " + e.getMessage(), e);
            }
        }
        return filedValue;
    }

    /**
     * 设置合并单元格的初始值，给指定行中相同 index 属性的单元格赋值
     *
     * @param filedValue  合并单元格的初始值
     * @param rowIndex    数据列表行的下标索引
     * @param columnIndex 数据列表列的下标索引
     * @param list        数据列表
     */
    private void setInitValueToList(Object filedValue, Integer rowIndex, Integer columnIndex, List<T> list) {
        // 获取指定行的数据对象
        T obj = list.get(rowIndex);
        for (Field field : obj.getClass().getDeclaredFields()) {
            // 通过ExcelProperty注解上的 index 属性定位数据列的位置
            ExcelProperty annotation = field.getAnnotation(ExcelProperty.class);
            if (annotation == null || annotation.index() != columnIndex) {
                continue;
            }
            try {
                // 屏蔽Java语言的访问检查，使得对象的私有属性也可以被查询和修改
                field.setAccessible(true);
                field.set(obj, filedValue);
                break;
            } catch (Exception e) {
                log.error("设置合并单元格的初始值异常: " + e.getMessage(), e);
            }
        }
    }
}
