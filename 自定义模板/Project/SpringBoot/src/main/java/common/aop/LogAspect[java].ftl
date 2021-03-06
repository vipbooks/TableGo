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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import cn.hutool.json.JSONConfig;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.tablego.project.springboot.common.model.UserRequestInfo;
import cn.tablego.project.springboot.common.util.RequestUtils;
import io.swagger.annotations.ApiOperation;

/**
 * 日志切面拦截器
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Aspect
@Component
public class LogAspect {
    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);
    /** JSON配置 */
    private static final JSONConfig JSON_CONFIG = new JSONConfig().setOrder(true);

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

        String apiDesc = null;
        ApiOperation annotation = method.getAnnotation(ApiOperation.class);
        if (annotation != null) {
            apiDesc = annotation.value();
        }
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
        Instant begin = Instant.now();
        Object result = joinPoint.proceed();
        Instant end = Instant.now();
        Long timeCost = Duration.between(begin, end).toMillis();

        UserRequestInfo userRequestInfo = UserRequestInfo.newInstance()
                .setUri(uri)
                .setApiDesc(apiDesc)
                .setClientIp(clientIp)
                .setBrowser(browserName)
                .setOs(osName)
                .setRequestMethod(requestMethod)
                .setRequestParams(requestParams.isEmpty() ? null : requestParams.toString())
                .setRequestBody(requestBody)
                .setHeaderUserAgent(headerUserAgent)
                .setClassMethod(classMethod)
                .setTimeCost(timeCost);

        logger.info("UserRequestInfo: {}", JSONUtil.toJsonStr(userRequestInfo, JSON_CONFIG));

        return result;
    }
}