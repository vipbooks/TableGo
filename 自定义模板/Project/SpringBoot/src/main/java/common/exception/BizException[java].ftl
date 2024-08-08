package ${jsonParam.packagePath}

/**
 * 业务异常类
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
public class BizException extends RuntimeException {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** 异常编码，与org.springframework.http.HttpStatus同 */
    private Integer code;

    /** 创建业务异常实例对象 */
    public static BizException newInstance(String message) {
        return new BizException(message);
    }

    /** 创建业务异常实例对象 */
    public static BizException newInstance(Throwable cause) {
        return new BizException(cause);
    }

    /** 创建业务异常实例对象 */
    public static BizException newInstance(String message, Integer code) {
        return new BizException(message, code);
    }

    /** 创建业务异常实例对象 */
    public static BizException newInstance(String message, Throwable cause) {
        return new BizException(message, cause);
    }

    /** 创建业务异常实例对象 */
    public static BizException newInstance(String message, Integer code, Throwable cause) {
        return new BizException(message, code, cause);
    }

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
