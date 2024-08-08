package ${jsonParam.packagePath}

import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.cache.interceptor.SimpleKey;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.context.annotation.Primary;

import cn.hutool.core.text.CharPool;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.json.JSONUtil;

/**
 * EhCache参数配置，继承CachingConfigurerSupport覆盖默认的缓存Key生成器
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@EnableCaching
@SpringBootConfiguration
public class EhCacheConfig extends CachingConfigurerSupport {

    /** 自定义EhCache缓存Key生成器 */
    @Bean
<#if !jsonParam.enableRedis>
    @Primary
</#if>
    @Override
    public KeyGenerator keyGenerator() {
        return (target, method, params) -> {
            String methodName = method.getName();
            String keyPrefix = methodName + CharPool.UNDERLINE;
            int paramLength = params.length;
            if (paramLength == 0) {
                return new SimpleKey(keyPrefix);
            }
            if (paramLength == 1) {
                Object param = params[0];
                if (param == null) {
                    return new SimpleKey(methodName + StrUtil.str(params, CharsetUtil.CHARSET_UTF_8));
                }
                if (param instanceof String || NumberUtil.isNumber(param.toString())) {
                    return keyPrefix + param;
                }
                return keyPrefix + SecureUtil.md5(JSONUtil.toJsonStr(param));
            }
            return keyPrefix + SecureUtil.md5(JSONUtil.toJsonStr(params));
        };
    }
}
