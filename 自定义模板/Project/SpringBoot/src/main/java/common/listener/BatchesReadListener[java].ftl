package ${jsonParam.packagePath}

import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

import org.apache.commons.collections4.CollectionUtils;
import lombok.extern.slf4j.Slf4j;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.exception.ExcelDataConvertException;
import com.alibaba.excel.metadata.data.ReadCellData;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.read.metadata.holder.ReadRowHolder;
import com.alibaba.excel.util.ListUtils;

import ${jsonParam.basePackagePath}.common.model.BaseExcel;

/**
 * Excel导入分批处理监听器，默认按1000条一批处理
 *
 * @see com.alibaba.excel.read.listener.PageReadListener
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
public class BatchesReadListener<T extends BaseExcel> implements ReadListener<T> {
    /**
     * Default single handle the amount of data
     */
    public static int BATCH_COUNT = 1000;

    /**
     * Temporary storage of data
     */
    private List<T> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);

    /**
     * consumer
     */
    private final Consumer<List<T>> consumer;

    /**
     * Single handle the amount of data
     */
    private final int batchCount;

    public BatchesReadListener(Consumer<List<T>> consumer) {
        this(consumer, BATCH_COUNT);
    }

    public BatchesReadListener(Consumer<List<T>> consumer, int batchCount) {
        this.consumer = consumer;
        this.batchCount = batchCount;
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
            throw new RuntimeException(msg, exception);
        } else {
            throw new RuntimeException("导入Excel解析失败，错误消息: " + exception.getMessage(), exception);
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
    }

    /**
     * 所有数据解析完成后调用
     */
    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        if (CollectionUtils.isNotEmpty(cachedDataList)) {
            consumer.accept(cachedDataList);
        }
    }
}
