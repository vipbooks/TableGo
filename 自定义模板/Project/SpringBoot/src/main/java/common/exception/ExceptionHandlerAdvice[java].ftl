package ${jsonParam.packagePath}

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import ${jsonParam.basePackagePath}.common.model.Result;

/**
 * 统一异常处理类
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
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
    public Result<Boolean> bizExceptionHandler(BizException e) {
        Result<Boolean> result = Result.failed(e.getMessage());
        Integer code = e.getCode();
        if (code != null) {
            result.setCode(code);
        } else {
            result.setCode(HttpStatus.PRECONDITION_FAILED.value());
        }
        return result;
    }

    /**
     * Bean Validation字段验证的异常处理方法
     *
     * @param e MethodArgumentNotValidException
     * @return 异常结果数据
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Boolean> methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        return Result.failed(e.getBindingResult().getFieldError().getDefaultMessage());
    }

    /**
     * Bean Validation字段验证的异常处理方法
     *
     * @param e BindException
     * @return 异常结果数据
     */
    @ExceptionHandler(BindException.class)
    public Result<Boolean> bindExceptionHandler(BindException e) {
        return Result.failed(e.getBindingResult().getFieldError().getDefaultMessage());
    }

    /**
     * 上传文件的总大小超过maxUploadSize配置的大小时的异常处理方法
     *
     * @param e MaxUploadSizeExceededException
     * @return 异常结果数据
     */
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public Result<Boolean> maxUploadSizeExceededException(MaxUploadSizeExceededException e) {
        return Result.failed("上传文件总大小超过 " + (e.getMaxUploadSize() / 1024 / 1024) + "M 大小限制！");
    }
}
