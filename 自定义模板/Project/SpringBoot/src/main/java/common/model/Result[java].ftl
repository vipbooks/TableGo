package ${jsonParam.packagePath}

import java.io.Serializable;
import org.springframework.http.HttpStatus;
import cn.hutool.core.exceptions.ExceptionUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
<#if jsonParam.enableSwagger>

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 响应参数
 * 
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@NoArgsConstructor
@Accessors(chain = true)
<#if jsonParam.enableSwagger>
@ApiModel(description = "响应参数")
</#if>
public class Result<T> implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** 请求成功的默认消息 */
    private static final String OK_MSG = "请求成功";

    /** 请求失败的默认消息 */
    private static final String FAILED_MSG = "请求失败";

    /** 请求是否成功的标识 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "请求是否成功的标识")
</#if>
    private boolean flag = true;

    /** 成功或失败的编码 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "成功或失败的编码")
</#if>
    private Integer code = HttpStatus.OK.value();

    /** 成功或失败的提示消息 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "成功或失败的提示消息")
</#if>
    private String msg = OK_MSG;

    /** 异常或报错消息 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "异常或报错消息")
</#if>
    private String errorMsg;

    /** 响应数据 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "响应数据")
</#if>
    private T data;

    /**
     * 创建响应参数实例对象
     *
     * @return 响应参数
     */
    public static <T> Result<T> newInstance() {
        return new Result<>();
    }

    /**
     * 返回成功的响应参数
     *
     * @return 成功的响应参数
     */
    public static <T> Result<T> ok() {
        return buildOkResult();
    }

    /**
     * 返回成功的响应参数
     *
     * @param data 响应数据
     * @return 成功的响应参数
     */
    public static <T> Result<T> ok(T data) {
        return buildOkResult(data);
    }

    /**
     * 返回成功的响应参数
     *
     * @param data 响应数据
     * @param msg  成功消息
     * @return 成功的响应参数
     */
    public static <T> Result<T> ok(T data, String msg) {
        return buildOkResult(data, msg);
    }

    /**
     * 返回成功的响应参数
     *
     * @param msg 成功消息
     * @return 成功的响应参数
     */
    public static <T> Result<T> okMsg(String msg) {
        return buildOkResult(null, msg);
    }

    /**
     * 返回失败的响应参数
     *
     * @return 失败的响应参数
     */
    public static <T> Result<T> failed() {
        return buildFailedResult();
    }

    /**
     * 返回失败的响应参数
     *
     * @param data 响应数据
     * @return 失败的响应参数
     */
    public static <T> Result<T> failed(T data) {
        return buildFailedResult(data);
    }

    /**
     * 返回失败的响应参数
     *
     * @param msg 失败消息
     * @return 失败的响应参数
     */
    public static <T> Result<T> failedMsg(String msg) {
        return buildFailedResult(msg);
    }

    /**
     * 返回失败的响应参数
     *
     * @param data 响应数据
     * @param msg  失败消息
     * @return 失败的响应参数
     */
    public static <T> Result<T> failed(T data, String msg) {
        return buildFailedResult(data, msg);
    }

    /**
     * 返回异常或报错的响应参数
     *
     * @param msg 错误消息
     * @return 异常或报错的响应参数
     */
    public static <T> Result<T> error(String msg) {
        return buildErrorResult(msg);
    }

    /**
     * 返回异常或报错的响应参数
     *
     * @param msg       错误消息
     * @param throwable 异常对象
     * @return 异常或报错的响应参数
     */
    public static <T> Result<T> error(String msg, Throwable throwable) {
        return buildErrorResult(msg, throwable);
    }

    /**
     * 返回成功或失败的响应参数
     *
     * @param isOk 是否成功
     * @return 响应参数
     */
    public static <T> Result<T> okOrFailed(boolean isOk) {
        if (isOk) {
            return Result.ok();
        } else {
            return Result.failed();
        }
    }

    /**
     * 创建成功的响应参数
     *
     * @return 响应参数
     */
    private static <T> Result<T> buildOkResult() {
        Result<T> result = Result.newInstance();
        return result.setFlag(true).setCode(HttpStatus.OK.value());
    }

    /**
     * 创建成功的响应参数
     *
     * @param data 响应数据
     * @return 响应参数
     */
    private static <T> Result<T> buildOkResult(T data) {
        Result<T> result = Result.newInstance();
        return result.setFlag(true).setCode(HttpStatus.OK.value()).setData(data);
    }

    /**
     * 创建成功的响应参数
     *
     * @param data 响应数据
     * @param msg  成功消息
     * @return 响应参数
     */
    private static <T> Result<T> buildOkResult(T data, String msg) {
        Result<T> result = Result.newInstance();
        return result.setFlag(true).setCode(HttpStatus.OK.value()).setData(data).setMsg(msg);
    }

    /**
     * 创建失败的响应参数
     *
     * @return 响应参数
     */
    private static <T> Result<T> buildFailedResult() {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setMsg(FAILED_MSG).setCode(HttpStatus.PRECONDITION_FAILED.value());
    }

    /**
     * 创建失败的响应参数
     *
     * @param data 响应数据
     * @return 响应参数
     */
    private static <T> Result<T> buildFailedResult(T data) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setMsg(FAILED_MSG).setCode(HttpStatus.PRECONDITION_FAILED.value()).setData(data);
    }

    /**
     * 创建失败的响应参数
     *
     * @param msg 失败消息
     * @return 响应参数
     */
    private static <T> Result<T> buildFailedResult(String msg) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setCode(HttpStatus.PRECONDITION_FAILED.value()).setMsg(msg);
    }

    /**
     * 创建失败的响应参数
     *
     * @param data 响应数据
     * @param msg  失败消息
     * @return 响应参数
     */
    private static <T> Result<T> buildFailedResult(T data, String msg) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setCode(HttpStatus.PRECONDITION_FAILED.value()).setData(data).setMsg(msg);
    }

    /**
     * 创建异常的响应参数
     *
     * @param msg 错误消息
     * @return 响应参数
     */
    private static <T> Result<T> buildErrorResult(String msg) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setCode(HttpStatus.INTERNAL_SERVER_ERROR.value()).setMsg(msg);
    }

    /**
     * 创建异常的响应参数
     *
     * @param msg       错误消息
     * @param throwable 异常对象
     * @return 响应参数
     */
    private static <T> Result<T> buildErrorResult(String msg, Throwable throwable) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setCode(HttpStatus.INTERNAL_SERVER_ERROR.value()).setMsg(msg).setExceptionMsg(throwable);
    }

    /**
     * 设置成功的响应参数
     */
    @JsonIgnore
    public void setOk() {
        setOk(null, OK_MSG);
    }

    /**
     * 设置成功的响应参数
     *
     * @param data 响应数据
     */
    @JsonIgnore
    public void setOk(T data) {
        setOk(data, OK_MSG);
    }

    /**
     * 设置成功的响应参数
     *
     * @param msg 成功消息
     */
    @JsonIgnore
    public void setOkMsg(String msg) {
        setOk(null, msg);
    }

    /**
     * 设置成功的响应参数
     *
     * @param data 响应数据
     * @param msg  成功消息
     */
    @JsonIgnore
    public void setOk(T data, String msg) {
        this.setFlag(true).setCode(HttpStatus.OK.value()).setData(data).setMsg(msg);
    }

    /**
     * 设置失败的响应参数
     */
    @JsonIgnore
    public void setFailed() {
        setFailed(null, FAILED_MSG);
    }

    /**
     * 设置失败的响应参数
     *
     * @param data 响应数据
     */
    @JsonIgnore
    public void setFailed(T data) {
        setFailed(data, FAILED_MSG);
    }

    /**
     * 设置失败的响应参数
     *
     * @param msg 成功消息
     */
    @JsonIgnore
    public void setFailedMsg(String msg) {
        setFailed(null, msg);
    }

    /**
     * 设置失败的响应参数
     *
     * @param data 响应数据
     * @param msg  成功消息
     */
    @JsonIgnore
    public void setFailed(T data, String msg) {
        this.setFlag(false).setCode(HttpStatus.PRECONDITION_FAILED.value()).setData(data).setMsg(msg);
    }

    /**
     * 设置异常或报错消息
     *
     * @param throwable 异常或报错对象
     */
    @JsonIgnore
    public Result<T> setExceptionMsg(Throwable throwable) {
        if (throwable != null) {
            this.errorMsg = ExceptionUtil.stacktraceToOneLineString(throwable);
        }
        return this;
    }
}