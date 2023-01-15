package ${jsonParam.packagePath}

import org.springframework.http.HttpStatus;
import com.fasterxml.jackson.annotation.JsonProperty;
import cn.hutool.core.exceptions.ExceptionUtil;

<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 响应参数
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
<#if jsonParam.enableSwagger>
@ApiModel(description = "响应参数")
</#if>
public class Result<T> extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 8856956965424828815L;

    /** 请求是否成功的标识 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "请求是否成功的标识", position = 1)
</#if>
    @JsonProperty(index = 1)
    private boolean flag = true;

    /** 响应成功或失败的编码 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "响应成功或失败的编码", position = 2)
</#if>
    @JsonProperty(index = 2)
    private Integer code;

    /** 响应的提示消息 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "响应的提示消息", position = 3)
</#if>
    @JsonProperty(index = 3)
    private String msg = "请求成功";

    /** 响应的异常消息 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "响应的异常消息", position = 4)
</#if>
    @JsonProperty(index = 4)
    private String exceptionMsg;

    /** 响应数据 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "响应数据", position = 5)
</#if>
    @JsonProperty(index = 5)
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
        return buildOkResult(null, null);
    }

    /**
     * 返回成功的响应参数
     *
     * @param data 响应数据
     * @return 成功的响应参数
     */
    public static <T> Result<T> ok(T data) {
        return buildOkResult(data, null);
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
     * @param msg  成功消息
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
        return buildFailedResult(null, null);
    }

    /**
     * 返回失败的响应参数
     *
     * @param msg 失败消息
     * @return 失败的响应参数
     */
    public static <T> Result<T> failed(String msg) {
        return buildFailedResult(null, msg);
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
     * 返回异常的响应参数
     *
     * @param msg 错误消息
     * @return 异常的响应参数
     */
    public static <T> Result<T> error(String msg) {
        return buildErrorResult(msg, null);
    }

    /**
     * 返回异常的响应参数
     *
     * @param msg       错误消息
     * @param throwable 异常对象
     * @return 异常的响应参数
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
     * @param msg       错误消息
     * @param throwable 异常对象
     * @return 响应参数
     */
    private static <T> Result<T> buildErrorResult(String msg, Throwable throwable) {
        Result<T> result = Result.newInstance();
        return result.setFlag(false).setCode(HttpStatus.INTERNAL_SERVER_ERROR.value()).setMsg(msg).setExceptionMsg(throwable);
    }

    /**
     * 设置异常信息
     *
     * @param throwable 异常对象
     */
    public Result<T> setExceptionMsg(Throwable throwable) {
        if (throwable != null) {
            this.exceptionMsg = ExceptionUtil.stacktraceToOneLineString(throwable);
        }
        return this;
    }

    /**
     * 获取请求是否成功的标识
     *
     * @return 请求是否成功的标识
     */
    public boolean getFlag() {
        return flag;
    }

    /**
     * 设置请求是否成功的标识
     *
     * @param flag 请求是否成功的标识
     * @return 响应参数
     */
    public Result<T> setFlag(boolean flag) {
        this.flag = flag;
        return this;
    }

    /**
     * 获取响应成功或错误的编码
     *
     * @return 响应成功或错误的编码
     */
    public Integer getCode() {
        return code;
    }

    /**
     * 设置响应成功或错误的编码
     *
     * @param code 响应成功或错误的编码
     * @return 响应参数
     */
    public Result<T> setCode(Integer code) {
        this.code = code;
        return this;
    }

    /**
     * 获取响应的提示消息
     *
     * @return 响应的提示消息
     */
    public String getMsg() {
        return msg;
    }

    /**
     * 设置响应的提示消息
     *
     * @param msg 响应的提示消息
     * @return 响应参数
     */
    public Result<T> setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    /**
     * 获取响应的异常消息
     *
     * @return 响应的异常消息
     */
    public String getExceptionMsg() {
        return exceptionMsg;
    }

    /**
     * 设置响应的异常消息
     *
     * @param exceptionMsg 响应的异常消息
     * @return 响应参数
     */
    public Result<T> setExceptionMsg(String exceptionMsg) {
        this.exceptionMsg = exceptionMsg;
        return this;
    }

    /**
     * 获取响应数据
     *
     * @return 响应数据
     */
    public T getData() {
        return data;
    }

    /**
     * 设置响应数据
     *
     * @param data 响应数据
     * @return 响应参数
     */
    public Result<T> setData(T data) {
        this.data = data;
        return this;
    }
}