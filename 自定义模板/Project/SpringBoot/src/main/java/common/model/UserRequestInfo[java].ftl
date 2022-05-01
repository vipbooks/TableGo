package ${jsonParam.packagePath}

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * 用户请求信息
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Setter
@Getter
@Accessors(chain = true)
public class UserRequestInfo extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 66334266866024978L;

    /** 创建用户请求信息对象 */
    public static UserRequestInfo newInstance() {
        return new UserRequestInfo();
    }

    /** 请求路径 */
    private String uri;

    /** 接口描述 */
    private String apiDesc;

    /** 客户端IP */
    private String clientIp;

    /** 浏览器类型 */
    private String browser;

    /** 系统类型 */
    private String os;

    /** 请求方式 */
    private String requestMethod;

    /** 请求参数 */
    private String requestParams;

    /** 请求Body参数 */
    private String requestBody;

    /** 用户代理信息 */
    private String headerUserAgent;

    /** 方法类路径 */
    private String classMethod;

    /** 执行耗时 */
    private Long timeCost;
}
