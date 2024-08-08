package ${jsonParam.packagePath}

import java.lang.reflect.Method;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.useragent.Browser;
import cn.hutool.http.useragent.OS;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentInfo;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiOperation;
</#if>

import ${jsonParam.basePackagePath}.common.util.RequestUtils;
import ${jsonParam.basePackagePath}.common.exception.BizException;
import ${jsonParam.basePackagePath}.common.model.UserRequestInfo;
import ${jsonParam.basePackagePath}.common.model.Result;

/**
 * 日志切面拦截器
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Aspect
@Component
public class LogAspect {
    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);

    /** 配置Controller方法的切入点 */
    @Pointcut("execution(* *..controller..*Controller.*(..))")
    public void controllerPoint() {
    }

    /**
     * 配置Controller请求方法的环绕通知
     *
     * @param joinPoint ProceedingJoinPoint
     */
    @Around("controllerPoint()")
    public Object doAround(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request = RequestUtils.getRequest();
        if (request == null) {
            return joinPoint.proceed();
        }
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Method method = methodSignature.getMethod();
        String uri = request.getRequestURI();
        String classMethod = String.format("%s.%s", methodSignature.getDeclaringTypeName(), methodSignature.getName());
        String requestMethod = request.getMethod();

<#if jsonParam.enableSwagger>
        String apiDesc = null;
        ApiOperation annotation = method.getAnnotation(ApiOperation.class);
        if (annotation != null) {
            apiDesc = annotation.value();
        }
</#if>
        JSONObject requestParams = new JSONObject();
        Map<String, String> paramMap = ServletUtil.getParamMap(request);
        if (MapUtil.isNotEmpty(paramMap)) {
            requestParams = JSONUtil.parseObj(paramMap);
        }
        String requestBody = null;
        if (!StrUtil.equalsAnyIgnoreCase(requestMethod, ServletUtil.METHOD_GET, ServletUtil.METHOD_DELETE)) {
            Object[] args = joinPoint.getArgs();
            if (args != null && args.length > 0) {
                Object obj = args[0];
                if (obj instanceof MultipartFile) {
                    MultipartFile file = ((MultipartFile) obj);
                    if (!file.isEmpty()) {
                        JSONObject fileJson = new JSONObject();
                        fileJson.set("fileName", file.getOriginalFilename());
                        fileJson.set("fileSize", String.valueOf(file.getSize()));
                        fileJson.set("fileType", file.getContentType());
                        requestParams.set("file", fileJson);
                    }
                } else if (obj instanceof List) {
                    List<JSONObject> fileList = CollUtil.newArrayList();
                    List<?> list = (List<?>) obj;
                    for (Object o : list) {
                        if (o instanceof MultipartFile) {
                            MultipartFile file = ((MultipartFile) o);
                            if (!file.isEmpty()) {
                                JSONObject fileJson = new JSONObject();
                                fileJson.set("fileName", file.getOriginalFilename());
                                fileJson.set("fileSize", String.valueOf(file.getSize()));
                                fileJson.set("fileType", file.getContentType());
                                fileList.add(fileJson);
                            }
                        }
                    }
                    if (CollUtil.isNotEmpty(fileList)) {
                        requestParams.set("fileList", fileList);
                    }
                } else {
                    requestBody = JSONUtil.toJsonStr(obj);
                }
            }
        }
        String clientIp = ServletUtil.getClientIP(request);
        String browserName = null;
        String osName = null;
        String headerUserAgent = RequestUtils.getHeaderUserAgent(request);
        if (StrUtil.isNotBlank(headerUserAgent)) {
            UserAgent userAgent = RequestUtils.getUserAgent(headerUserAgent);
            if (userAgent != null) {
                Browser browser = userAgent.getBrowser();
                if (browser != null && StrUtil.isNotBlank(browser.getName()) && !StrUtil.equalsAnyIgnoreCase(browser.getName(), UserAgentInfo.NameUnknown)) {
                    browserName = browser.getName();
                }
                String version = userAgent.getVersion();
                if (StrUtil.isAllNotBlank(version, browserName) && !StrUtil.equalsAnyIgnoreCase(version, UserAgentInfo.NameUnknown)) {
                    browserName += StrUtil.SPACE + version;
                }
                OS os = userAgent.getOs();
                if (os != null && StrUtil.isNotBlank(os.getName()) && !StrUtil.equalsAnyIgnoreCase(os.getName(), UserAgentInfo.NameUnknown)) {
                    osName = os.getName();
                }
            }
        }
        // 初始化用户请求信息
        UserRequestInfo userRequestInfo = UserRequestInfo.builder()
                .uri(uri)
<#if jsonParam.enableSwagger>
                .apiDesc(apiDesc)
</#if>
                .clientIp(clientIp)
                .browser(browserName)
                .os(osName)
                .requestMethod(requestMethod)
                .requestParams(requestParams.isEmpty() ? null : requestParams.toString())
                .requestBody(requestBody)
                .headerUserAgent(headerUserAgent)
                .classMethod(classMethod)
                .build();

        Instant begin = Instant.now();
        try {
            // 执行目标方法并获取响应数据
            Object result = joinPoint.proceed();
            outUserRequestInfo(userRequestInfo, begin, result, null);
            return result;
        } catch (Throwable t) {
            outUserRequestInfo(userRequestInfo, begin, null, t);
            throw t;
        }
    }

    /**
     * 输出用户请求信息
     *
     * @param userRequestInfo 用户请求信息
     * @param begin           开始时间
     * @param result          响应数据
     * @param t               Throwable
     */
    private void outUserRequestInfo(UserRequestInfo userRequestInfo, Instant begin, Object result, Throwable t) {
        Instant end = Instant.now();
        Long timeCost = Duration.between(begin, end).toMillis();
        userRequestInfo.setTimeCost(timeCost);
        if (t != null) {
            if (t instanceof BizException) {
                userRequestInfo.setStatus(HttpStatus.PRECONDITION_FAILED.value()).setErrorMsg(t.getMessage());
                logger.warn("UserRequestInfo: {}", JSONUtil.toJsonStr(userRequestInfo));
            } else {
                userRequestInfo.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value()).setErrorMsg(t.getMessage());
                logger.error("UserRequestInfo: {}", JSONUtil.toJsonStr(userRequestInfo));
            }
        } else {
            if (result instanceof Result) {
                userRequestInfo.setStatus(((Result<?>) result).getCode());
            }
            if (userRequestInfo.getStatus() == null) {
                userRequestInfo.setStatus(HttpStatus.OK.value());
            }
            logger.info("UserRequestInfo: {}", JSONUtil.toJsonStr(userRequestInfo));
        }
    }
}