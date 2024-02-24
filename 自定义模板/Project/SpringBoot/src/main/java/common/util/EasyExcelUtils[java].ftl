package ${jsonParam.packagePath}

import java.io.InputStream;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.annotation.ExcelProperty;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;

import ${jsonParam.basePackagePath}.common.listener.BatchesReadListener;
import ${jsonParam.basePackagePath}.common.model.BaseExcel;
import ${jsonParam.basePackagePath}.common.model.Result;

/**
 * EasyExcel工具类
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
public class EasyExcelUtils {
    /** 单次缓存处理的数据量 */
    private static final int BATCH_COUNT = 1000;

    /**
     * 导出Excel空数据文件
     *
     * @param name     名称
     * @param clazz    对象class
     * @param response HttpServletResponse
     */
    public static <T> void exportEmptyExcel(String name, Class<T> clazz, HttpServletResponse response) {
        exportExcel(name, Collections.emptyList(), clazz, response);
    }

    /**
     * 导出Excel
     *
     * @param name     名称
     * @param data     数据
     * @param clazz    对象class
     * @param response HttpServletResponse
     */
    public static <T> void exportExcel(String name, Collection<T> data, Class<T> clazz, HttpServletResponse response) {
        try {
            String fileName = getFileName(name);
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName);
            EasyExcel.write(response.getOutputStream(), clazz).sheet(name).doWrite(data);
        } catch (Exception e) {
            responseWriteMsg(e, response);
        }
    }

    /**
     * 简单导入Excel
     *
     * @param file     MultipartFile
     * @param head     含有表头Class
     * @param consumer 需要消费的方法，用于做业务处理
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, Consumer<List<T>> consumer) {
        importExcel(file, head, consumer, BATCH_COUNT);
    }

    /**
     * 简单导入Excel
     *
     * @param file       MultipartFile
     * @param head       含有表头Class
     * @param consumer   需要消费的方法，用于做业务处理
     * @param batchCount 单次缓存处理的数据量
     */
    public static <T extends BaseExcel> void importExcel(MultipartFile file, Class<T> head, Consumer<List<T>> consumer, int batchCount) {
        Assert.isTrue(file != null && !file.isEmpty(), "导入文件不能为空");
        try (InputStream is = file.getInputStream()) {
            importExcel(is, head, new BatchesReadListener<>(consumer, batchCount));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }

    /**
     * 简单导入Excel
     *
     * @param inputStream         InputStream
     * @param head                含有表头Class
     * @param batchesReadListener PageReadListener
     */
    public static <T extends BaseExcel> void importExcel(InputStream inputStream, Class<T> head, BatchesReadListener<T> batchesReadListener) {
        EasyExcel.read(inputStream, head, batchesReadListener).sheet().doRead();
    }

    /**
     * 获取URL编码后的文件名
     *
     * @param name 名称
     * @return URL编码后的文件名
     * @throws Exception
     */
    private static String getFileName(String name) throws Exception {
        String fileName = name + DateUtil.format(DateUtil.date(), DatePattern.PURE_DATETIME_PATTERN) + ".xlsx";
        return URLEncoder.encode(fileName, CharsetUtil.UTF_8).replaceAll("\\+", "%20");
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
            throw new RuntimeException(e.getMessage(), e);
        }
    }
}
