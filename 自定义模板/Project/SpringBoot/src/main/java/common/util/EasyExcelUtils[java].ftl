package ${jsonParam.packagePath}

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.concurrent.ForkJoinPool;
import java.util.function.Consumer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.enums.CellExtraTypeEnum;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.text.StrPool;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.URLUtil;
import cn.hutool.json.JSONUtil;

import lombok.extern.slf4j.Slf4j;

import ${jsonParam.basePackagePath}.common.exception.BizException;
import ${jsonParam.basePackagePath}.common.listener.ExcelBatchReadListener;
import ${jsonParam.basePackagePath}.common.model.BaseExcel;
import ${jsonParam.basePackagePath}.common.model.Result;

/**
 * EasyExcel工具类
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Slf4j
public class EasyExcelUtils {
    /** XLSX的MIME类型 */
    public static final String XLSX_CONTENT_TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

    /** 二进制数据流的MIME类型 */
    public static final String OCTET_STREAM_CONTENT_TYPE = "application/octet-stream;charset=utf-8";

    /** 下载响应头的Content-Disposition */
    public static final String HEADER_CONTENT_DISPOSITION = "attachment;filename=\"{}\";filename*=utf-8''{}";

    /** Excel的xls扩展名 */
    public static final String EXCEL_XLS_EXT = ".xls";

    /** Excel的xlsx扩展名 */
    public static final String EXCEL_XLSX_EXT = ".xlsx";

    /** ZIP的扩展名 */
    public static final String ZIP_EXT = ".zip";

    /** Excel单次缓存处理的数据量 */
    public static final int EXCEL_BATCH_SIZE = 1000;

    /** Zip打包Excel，一个Excel保存多少条数据 */
    public static final int ZIP_BATCH_SIZE = 10000;

    /** 默认数据起始行，从零开始 */
    public static final int HEAD_ROW_NUMBER = 1;

    /** 创建默认线程池，避免使用公共线程池 */
    public static final ForkJoinPool DEFAULT_THREAD_POOL = new ForkJoinPool();

    /**
     * 导出Excel空数据文件
     *
     * @param name     名称
     * @param clazz    对象Class
     * @param response HttpServletResponse
     */
    public static <T> void exportEmptyExcel(String name, Class<T> clazz, HttpServletResponse response) {
        exportExcel(name, Collections.emptyList(), clazz, response);
    }

    /**
     * 导出Excel
     *
     * @param name     名称
     * @param data     数据列表
     * @param clazz    对象Class
     * @param response HttpServletResponse
     */
    public static <T> void exportExcel(String name, Collection<T> data, Class<T> clazz, HttpServletResponse response) {
        try {
            String fileName = getExcelFileName(name);
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            response.setContentType(XLSX_CONTENT_TYPE);
            response.setHeader("Content-Disposition", StrUtil.format(HEADER_CONTENT_DISPOSITION, fileName, fileName));
            EasyExcel.write(response.getOutputStream(), clazz).sheet(name).doWrite(data);
        } catch (Exception e) {
            responseWriteMsg(e, response);
        }
    }

    /**
     * 导入Excel
     *
     * @param file     MultipartFile
     * @param head     含有表头Class
     * @param consumer 需要消费的方法，用于做业务处理
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, Consumer<List<T>> consumer) {
        importExcel(file, head, EXCEL_BATCH_SIZE, consumer);
    }

    /**
     * 导入Excel
     *
     * @param file        MultipartFile
     * @param head        含有表头Class
     * @param isReadMerge 是否读取合并单元格，ExcelProperty注解上需要添加 index 属性定位数据列的位置，index从零开始
     * @param consumer    需要消费的方法，用于做业务处理
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, boolean isReadMerge, Consumer<List<T>> consumer) {
        importExcel(file, head, HEAD_ROW_NUMBER, isReadMerge, EXCEL_BATCH_SIZE, consumer);
    }

    /**
     * 导入Excel
     *
     * @param file      MultipartFile
     * @param head      含有表头Class
     * @param consumer  需要消费的方法，用于做业务处理
     * @param batchSize 单次缓存处理的数据量
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, int batchSize, Consumer<List<T>> consumer) {
        importExcel(file, head, HEAD_ROW_NUMBER, batchSize, consumer);
    }

    /**
     * 导入Excel
     *
     * @param file          MultipartFile
     * @param head          含有表头Class
     * @param headRowNumber 数据起始行
     * @param consumer      需要消费的方法，用于做业务处理
     * @param batchSize     单次缓存处理的数据量
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, int headRowNumber, int batchSize, Consumer<List<T>> consumer) {
        importExcel(file, head, headRowNumber, false, batchSize, consumer);
    }

    /**
     * 导入Excel
     *
     * @param file          MultipartFile
     * @param head          含有表头Class
     * @param headRowNumber 数据起始行
     * @param isReadMerge   是否读取合并单元格，ExcelProperty注解上需要添加 index 属性定位数据列的位置，index从零开始
     * @param batchSize     单次缓存处理的数据量
     * @param consumer      需要消费的方法，用于做业务处理
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, int headRowNumber, boolean isReadMerge, int batchSize, Consumer<List<T>> consumer) {
        Assert.isTrue(file != null && !file.isEmpty(), "导入文件不能为空！");
        try (InputStream is = file.getInputStream()) {
            importExcel(is, head, headRowNumber, isReadMerge, new ExcelBatchReadListener<>(consumer, batchSize));
        } catch (Exception e) {
            throw BizException.newInstance(e);
        }
    }

    /**
     * 导入Excel
     *
     * @param inputStream   InputStream
     * @param head          含有表头Class
     * @param headRowNumber 数据起始行
     * @param isReadMerge   是否读取合并单元格，ExcelProperty注解上需要添加 index 属性定位数据列的位置，index从零开始
     * @param readListener  ReadListener
     */
    public static <T extends BaseExcel> void importExcel(InputStream inputStream, Class<T> head, int headRowNumber, boolean isReadMerge, ReadListener<T> readListener) {
        if (isReadMerge) {
            EasyExcel.read(inputStream, head, readListener).headRowNumber(headRowNumber).extraRead(CellExtraTypeEnum.MERGE).sheet().doRead();
        } else {
            EasyExcel.read(inputStream, head, readListener).headRowNumber(headRowNumber).sheet().doRead();
        }
    }

    /**
     * Excel多线程分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name     名称
     * @param data     数据列表
     * @param clazz    对象Class
     * @param response HttpServletResponse
     */
    public static <T> void exportZip(String name, List<T> data, Class<T> clazz, HttpServletResponse response) {
        exportZip(name, data, clazz, ZIP_BATCH_SIZE, response, DEFAULT_THREAD_POOL);
    }

    /**
     * Excel多线程分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name      名称
     * @param data      数据列表
     * @param clazz     对象Class
     * @param batchSize 批量大小，一个Excel保存多少条数据
     * @param response  HttpServletResponse
     */
    public static <T> void exportZip(String name, List<T> data, Class<T> clazz, int batchSize, HttpServletResponse response) {
        exportZip(name, data, clazz, batchSize, response, DEFAULT_THREAD_POOL);
    }

    /**
     * Excel多线程分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name     名称
     * @param data     数据列表
     * @param clazz    对象Class
     * @param response HttpServletResponse
     * @param executor 线程池
     */
    public static <T> void exportZip(String name, List<T> data, Class<T> clazz, HttpServletResponse response, Executor executor) {
        exportZip(name, data, clazz, ZIP_BATCH_SIZE, response, executor);
    }

    /**
     * Excel多线程分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name      名称
     * @param data      数据列表
     * @param clazz     对象Class
     * @param batchSize 批量大小，一个Excel保存多少条数据
     * @param response  HttpServletResponse
     * @param executor  线程池
     */
    public static <T> void exportZip(String name, List<T> data, Class<T> clazz, int batchSize, HttpServletResponse response, Executor executor) {
        List<List<T>> splitList = ListUtil.split(data, batchSize);
        List<CompletableFuture<byte[]>> completableFutureList = ListUtil.toList();
        // 分批生成Excel文档
        for (List<T> list : splitList) {
            // 使用异步线程生成Excel文档
            CompletableFuture<byte[]> supplyAsync = CompletableFuture.supplyAsync(() -> {
                try (ByteArrayOutputStream baos = new ByteArrayOutputStream(); ExcelWriter excelWriter = EasyExcel.write(baos).autoCloseStream(false).build()) {
                    WriteSheet writeSheet = EasyExcel.writerSheet(name).head(clazz).build();
                    excelWriter.write(list, writeSheet);
                    excelWriter.finish();
                    return baos.toByteArray();
                } catch (Exception e) {
                    throw BizException.newInstance(e);
                }
            }, executor);
            completableFutureList.add(supplyAsync);
        }
        CompletableFuture.allOf(completableFutureList.toArray(new CompletableFuture[]{})).join();

        // 把生成的Excel文件打包成zip下载
        try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
            String fileName = getZipFileName(name);
            response.reset();
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            response.setContentType(OCTET_STREAM_CONTENT_TYPE);
            response.setHeader("Content-Disposition", StrUtil.format(HEADER_CONTENT_DISPOSITION, fileName, fileName));
            for (CompletableFuture<byte[]> completableFuture : completableFutureList) {
                ZipEntry zipEntry = new ZipEntry(name + IdWorker.getId() + EXCEL_XLSX_EXT);
                zos.putNextEntry(zipEntry);
                zos.write(completableFuture.get());
                zos.closeEntry();
            }
        } catch (Exception e) {
            throw BizException.newInstance(e);
        }
    }

    /**
     * Excel简单分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name     名称
     * @param data     数据列表
     * @param clazz    对象Class
     * @param response HttpServletResponse
     */
    public static <T> void exportSimpleZip(String name, List<T> data, Class<T> clazz, HttpServletResponse response) {
        exportSimpleZip(name, data, clazz, ZIP_BATCH_SIZE, response);
    }

    /**
     * Excel简单分批生成并打包成zip压缩包导出，用于大量数据导出
     *
     * @param name      名称
     * @param data      数据列表
     * @param clazz     对象Class
     * @param batchSize 批量大小，一个Excel保存多少条数据
     * @param response  HttpServletResponse
     */
    public static <T> void exportSimpleZip(String name, List<T> data, Class<T> clazz, int batchSize, HttpServletResponse response) {
        try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
            String fileName = getZipFileName(name);
            response.reset();
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            response.setContentType(OCTET_STREAM_CONTENT_TYPE);
            response.setHeader("Content-Disposition", StrUtil.format(HEADER_CONTENT_DISPOSITION, fileName, fileName));

            // 分批生成Excel文档
            List<List<T>> splitList = ListUtil.split(data, batchSize);
            for (List<T> list : splitList) {
                try (ByteArrayOutputStream baos = new ByteArrayOutputStream(); ExcelWriter excelWriter = EasyExcel.write(baos).autoCloseStream(false).build()) {
                    WriteSheet writeSheet = EasyExcel.writerSheet(name).head(clazz).build();
                    excelWriter.write(list, writeSheet);
                    excelWriter.finish();

                    // 把生成的Excel文件打包成zip下载
                    ZipEntry zipEntry = new ZipEntry(name + IdWorker.getId() + EXCEL_XLSX_EXT);
                    zos.putNextEntry(zipEntry);
                    baos.writeTo(zos);
                    zos.closeEntry();
                } catch (Exception e) {
                    throw BizException.newInstance(e);
                }
            }
        } catch (Exception e) {
            throw BizException.newInstance(e);
        }
    }

    /**
     * 获取JavaBean中@ExcelProperty注解变量名和表头名对应关系
     *
     * @param obj JavaBean对象
     * @return 变量名和表头名对应关系
     */
    public static Map<String, String> getExcelPropertyAnnotationValueMap(Object obj) {
        if (obj == null) {
            return Collections.emptyMap();
        }
        Map<String, String> map = new HashMap<>();
        Field[] fields = ReflectUtil.getFields(obj.getClass());
        for (Field field : fields) {
            String name = field.getName();
            ExcelProperty annotation = field.getAnnotation(ExcelProperty.class);
            String value = Optional.ofNullable(annotation).map(ExcelProperty::value)
                    .filter(ArrayUtil::isNotEmpty)
                    .map(values -> values[0])
                    .orElse(null);
            if (StrUtil.isNotBlank(value)) {
                map.put(name, value);
            }
        }
        return map;
    }

    /**
     * 获取URL编码后的Excel文件名
     *
     * @param name 名称
     * @return URL编码后的Excel文件名
     */
    private static String getExcelFileName(String name) {
        String fileName = name + StrPool.UNDERLINE + DateUtil.format(DateUtil.date(), DatePattern.PURE_DATETIME_PATTERN) + EXCEL_XLSX_EXT;
        return URLUtil.encodeAll(fileName, CharsetUtil.charset(CharsetUtil.UTF_8));
    }

    /**
     * 获取URL编码后的Zip文件名
     *
     * @param name 名称
     * @return URL编码后的Zip文件名
     */
    private static String getZipFileName(String name) {
        String fileName = name + StrPool.UNDERLINE + DateUtil.format(DateUtil.date(), DatePattern.PURE_DATETIME_PATTERN) + ZIP_EXT;
        return URLUtil.encodeAll(fileName, CharsetUtil.charset(CharsetUtil.UTF_8));
    }

    /**
     * 把异常消息用 HttpServletResponse 输出到前端
     *
     * @param ex       Exception
     * @param response HttpServletResponse
     */
    private static void responseWriteMsg(Exception ex, HttpServletResponse response) {
        log.error(ex.getMessage(), ex);
        Result<Boolean> result = Result.error(ex.getMessage(), ex);
        try {
            response.reset();
            response.setContentType(MediaType.APPLICATION_JSON_VALUE);
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            response.getWriter().println(JSONUtil.toJsonStr(result));
        } catch (Exception e) {
            throw BizException.newInstance(e);
        }
    }
}
