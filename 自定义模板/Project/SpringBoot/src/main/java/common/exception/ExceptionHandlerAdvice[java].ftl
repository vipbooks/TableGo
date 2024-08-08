package ${jsonParam.packagePath}

import java.util.List;
import java.util.stream.Collectors;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;

import ${jsonParam.basePackagePath}.common.model.Result;

/**
 * 统一异常处理类
 * 
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@RestControllerAdvice
public class ExceptionHandlerAdvice {
    private static final Logger logger = LoggerFactory.getLogger(ExceptionHandlerAdvice.class);

    /**
     * 底层的全局异常处理方法
     *
     * @param t Throwable
     * @return 异常结果数据
     */
    @ExceptionHandler(Throwable.class)
    public Result<Boolean> throwableErrorHandler(Throwable t) {
        logger.error(t.getMessage(), t);
        return Result.error(t.getMessage(), t);
    }

    /**
     * 默认的全局异常处理方法
     *
     * @param e Exception
     * @return 异常结果数据
     */
    @ExceptionHandler(Exception.class)
    public Result<Boolean> defaultErrorHandler(Exception e) {
        logger.error(e.getMessage(), e);
        return Result.error(e.getMessage(), e);
    }

    /**
     * 运行时异常处理方法
     *
     * @param e RuntimeException
     * @return 异常结果数据
     */
    @ExceptionHandler(RuntimeException.class)
    public Result<Boolean> runtimeExceptionHandler(RuntimeException e) {
        logger.error(e.getMessage(), e);
        return Result.error(e.getMessage(), e);
    }

    /**
     * 业务异常处理方法
     *
     * @param e BizException
     * @return 异常结果数据
     */
    @ExceptionHandler(BizException.class)
    public Result<String> bizExceptionHandler(BizException e) {
        Result<String> result = Result.failed(e.getMessage());
        Integer code = e.getCode();
        if (code != null) {
            result.setCode(code);
        }
        return result;
    }

    /**
     * 非法参数异常处理方法
     *
     * @param e IllegalArgumentException
     * @return 异常结果数据
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public Result<String> illegalArgumentExceptionHandler(IllegalArgumentException e) {
        return Result.failed(e.getMessage());
    }

    /**
     * Bean Validation字段验证的异常处理方法
     *
     * @param e MethodArgumentNotValidException
     * @return 异常结果数据
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<String> methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        List<String> msgList = e.getBindingResult().getFieldErrors().stream().map(FieldError::getDefaultMessage).distinct().collect(Collectors.toList());
        return Result.failed(CollUtil.join(msgList, StrUtil.COMMA));
    }

    /**
     * Bean Validation字段验证的异常处理方法，方法的 Model 参数校验
     *
     * @param e BindException
     * @return 异常结果数据
     */
    @ExceptionHandler(BindException.class)
    public Result<String> bindExceptionHandler(BindException e) {
        List<String> msgList = e.getBindingResult().getFieldErrors().stream().map(FieldError::getDefaultMessage).distinct().collect(Collectors.toList());
        return Result.failed(CollUtil.join(msgList, StrUtil.COMMA));
    }

    /**
     * Validation字段验证的异常处理方法，方法的非 Model 参数校验
     *
     * @param e ConstraintViolationException
     * @return 异常结果数据
     */
    @ExceptionHandler(ConstraintViolationException.class)
    public Result<String> bindExceptionHandler(ConstraintViolationException e) {
        List<String> msgList = e.getConstraintViolations().stream().map(ConstraintViolation::getMessage).distinct().collect(Collectors.toList());
        return Result.failed(CollUtil.join(msgList, StrUtil.COMMA));
    }

    /**
     * 上传文件的总大小超过maxUploadSize配置的大小时的异常处理方法
     *
     * @param e MaxUploadSizeExceededException
     * @return 异常结果数据
     */
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public Result<String> maxUploadSizeExceededException(MaxUploadSizeExceededException e) {
        return Result.failed("上传文件总大小超过 " + (e.getMaxUploadSize() / 1024 / 1024) + "M 大小限制！");
    }
}
