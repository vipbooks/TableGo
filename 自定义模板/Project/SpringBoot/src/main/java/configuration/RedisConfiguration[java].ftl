package ${jsonParam.packagePath}

import java.time.Duration;

import org.redisson.api.RedissonClient;
import org.redisson.codec.JsonJacksonCodec;
import org.redisson.spring.cache.RedissonSpringCacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.cache.interceptor.SimpleKey;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import cn.hutool.core.text.CharPool;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import ${jsonParam.basePackagePath}.common.service.RedisService;

/**
 * Redis参数配置，继承CachingConfigurerSupport覆盖默认的缓存Key生成器
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Configuration
@EnableCaching
public class RedisConfiguration extends CachingConfigurerSupport {
    /** String序列化器 */
    private StringRedisSerializer stringRedisSerializer = new StringRedisSerializer();

    /** Jackson序列化器 */
    private Jackson2JsonRedisSerializer jackson2JsonRedisSerializer = getJackson2JsonRedisSerializer();

    @Autowired
    private RedisConnectionFactory redisConnectionFactory;

    @Autowired
    private RedissonClient redissonClient;

    /** 自定义Redis缓存Key生成器 */
    @Bean
    @Primary
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
                if (!param.getClass().isArray()
                        && (param instanceof String || NumberUtil.isNumber(param.toString()))) {
                    return keyPrefix + param;
                }
            }
            return keyPrefix + SecureUtil.md5(StrUtil.str(params, CharsetUtil.CHARSET_UTF_8));
        };
    }

    /** 初始化Spring缓存管理器 */
    @Bean
    @Primary
    @Override
    public CacheManager cacheManager() {
        return getRedissonSpringCacheManager();
    }

    /** 初始化RedisTemplate<String, Object> */
    @Bean
    public RedisTemplate<String, Object> redisTemplate() {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(stringRedisSerializer);
        redisTemplate.setHashKeySerializer(stringRedisSerializer);

        redisTemplate.setValueSerializer(jackson2JsonRedisSerializer);
        redisTemplate.setHashValueSerializer(jackson2JsonRedisSerializer);

        redisTemplate.setConnectionFactory(redisConnectionFactory);
        redisTemplate.afterPropertiesSet();

        return redisTemplate;
    }

    /** 初始化Redis客户端操作服务 */
    @Bean
    public RedisService redisService() {
        return new RedisService();
    }

    /** 获得RedissonSpringCacheManager对象 */
    private RedissonSpringCacheManager getRedissonSpringCacheManager() {
        RedissonSpringCacheManager redissonSpringCacheManager = new RedissonSpringCacheManager(redissonClient);
        redissonSpringCacheManager.setCodec(new JsonJacksonCodec(getObjectMapper()));
        return redissonSpringCacheManager;
    }

    /** 获得RedisCacheManager对象 */
    private RedisCacheManager getRedisCacheManager() {
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig()
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(stringRedisSerializer))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jackson2JsonRedisSerializer))
                .entryTtl(Duration.ofDays(7))
                .disableCachingNullValues();

        return RedisCacheManager.builder(redisConnectionFactory).cacheDefaults(config).build();
    }

    /** 获取Jackson序列化器 */
    private Jackson2JsonRedisSerializer getJackson2JsonRedisSerializer() {
        Jackson2JsonRedisSerializer jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer(Object.class);
        jackson2JsonRedisSerializer.setObjectMapper(getObjectMapper());
        return jackson2JsonRedisSerializer;
    }

    /** 获得ObjectMapper对象 */
    private ObjectMapper getObjectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        // 设置输入空对象不要抛异常
        objectMapper.disable(SerializationFeature.FAIL_ON_EMPTY_BEANS);
        // 设置输入时忽略在JSON字符串中存在但Java对象实际没有的属性
        objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        // 属性为NULL不序列化
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        // 序列化JSON串时，在值上打印出对象类型
        objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance, ObjectMapper.DefaultTyping.NON_FINAL, JsonTypeInfo.As.WRAPPER_ARRAY);
        // 取消Timestamps形式
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        // 解决Jackson序列化LocalDateTime报错
        objectMapper.registerModule(new JavaTimeModule());
        // 指定要序列化的域，Field、Get、Set和以及修饰符范围，ANY是都有包括Private和Public
        objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        return objectMapper;
    }
}