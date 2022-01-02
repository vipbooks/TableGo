package ${jsonParam.packagePath}

/**
 * 业务异常类
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public class BizException extends RuntimeException {
    /** 版本号 */
    private static final long serialVersionUID = 6600666999314080292L;

    /** 异常编码 */
    private Integer code;

    public BizException(String message) {
        super(message);
    }

    public BizException(Throwable cause) {
        super(cause);
    }

    public BizException(String message, Integer code) {
        super(message);
        this.code = code;
    }

    public BizException(String message, Throwable cause) {
        super(message, cause);
    }

    public BizException(String message, Integer code, Throwable cause) {
        super(message, cause);
        this.code = code;
    }

    public Integer getCode() {
        return code;
    }
}
