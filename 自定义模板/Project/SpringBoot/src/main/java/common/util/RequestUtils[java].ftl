package ${jsonParam.packagePath}

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentParser;

/**
 * 处理用户请求的工具类
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public class RequestUtils {
    private static final Logger logger = LoggerFactory.getLogger(RequestUtils.class);
    /** 用户代理Key */
    public static final String USER_AGENT_KEY = "User-Agent";

    /**
     * 获取ServletRequestAttributes
     *
     * @return ServletRequestAttributes
     */
    public static ServletRequestAttributes getServletRequestAttributes() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes == null) {
            logger.warn("RequestAttributes is null");
            return null;
        }
        if (!(requestAttributes instanceof ServletRequestAttributes)) {
            logger.warn("Request is not an HttpServletRequest: {}", requestAttributes);
            return null;
        }
        return (ServletRequestAttributes) requestAttributes;
    }

    /**
     * 获取当前用户的请求对象
     * 
     * @return HttpServletRequest
     */
    public static HttpServletRequest getRequest() {
        ServletRequestAttributes servletRequestAttributes = getServletRequestAttributes();
        if (servletRequestAttributes != null) {
            return servletRequestAttributes.getRequest();
        }
        return null;
    }

    /**
     * 获取当前用户的响应对象
     *
     * @return HttpServletResponse
     */
    public static HttpServletResponse getResponse() {
        ServletRequestAttributes servletRequestAttributes = getServletRequestAttributes();
        if (servletRequestAttributes != null) {
            return servletRequestAttributes.getResponse();
        }
        return null;
    }

    /**
     * 获取当前用户的会话
     * 
     * @return HttpSession
     */
    public static HttpSession getSession() {
        HttpServletRequest request = getRequest();
        if (request != null) {
            return request.getSession();
        }
        return null;
    }

    /**
     * 获取请求头中的用户代理信息
     *
     * @param request HttpServletRequest
     * @return 用户代理信息
     */
    public static String getHeaderUserAgent(HttpServletRequest request) {
        if (request != null) {
            return ServletUtil.getHeaderIgnoreCase(request, USER_AGENT_KEY);
        }
        return StrUtil.EMPTY;
    }

    /**
     * 获取请求头中的用户代理对象
     *
     * @param headerUserAgent 请求头中的用户代理信息
     * @return 用户代理对象
     */
    public static UserAgent getUserAgent(String headerUserAgent) {
        if (StrUtil.isBlank(headerUserAgent)) {
            return null;
        }
        return UserAgentParser.parse(headerUserAgent);
    }

    /**
     * 获取响应状态
     *
     * @return 响应状态
     */
    public static Integer getResponseStatus() {
        HttpServletResponse response = RequestUtils.getResponse();
        if (response != null) {
            return response.getStatus();
        }
        return null;
    }
}