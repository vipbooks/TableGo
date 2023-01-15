package ${jsonParam.packagePath}

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.stereotype.Service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * EhCache缓存Service接口
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
public class EhCacheService {
    private CacheManager cacheManager;

    @Autowired
    private EhCacheCacheManager ehCacheCacheManager;

    /**
     * 初始化EhCache缓存
     */
    @PostConstruct
    public void init() {
        cacheManager = ehCacheCacheManager.getCacheManager();
    }

    /**
     * 通过缓存名称获取缓存对象
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     */
    public Cache getCache(String cacheName) {
        return cacheManager.getCache(cacheName);
    }

    /**
     * 将对象放置到指定的缓存中，如果该对象在缓存中已存在，则更新该对象
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @param key       缓存中的key
     * @param value     要缓存的对象
     */
    public void put(String cacheName, String key, Object value) {
        Cache cache = getCache(cacheName);
        Element element = new Element(key, value);
        cache.put(element);
    }

    /**
     * 通过key获取缓存中存放的对象
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @param key       缓存中的key
     */
    public Object getValue(String cacheName, String key) {
        Cache cache = getCache(cacheName);
        // 移除过期元素
        cache.evictExpiredElements();
        cache.flush();
        Element element = cache.get(key);
        return element == null ? null : element.getObjectValue();
    }

    /**
     * 获取指定缓存中保存的所有数据集
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     */
    public Map<String, Object> getAllValues(String cacheName) {
        Cache cache = getCache(cacheName);
        List<?> keys = cache.getKeys();
        if (CollUtil.isEmpty(keys)) {
            return null;
        }
        Map<Object, Element> map = cache.getAll(keys);
        if (MapUtil.isEmpty(map)) {
            return null;
        }
        // 移除过期元素
        cache.evictExpiredElements();
        cache.flush();
        Map<String, Object> data = new HashMap<>();
        for (Map.Entry<Object, Element> entry : map.entrySet()) {
            Object key = entry.getKey();
            Element value = entry.getValue();
            if (key != null && value != null) {
                data.put(key.toString(), value.getObjectValue());
            }
        }

        return data;
    }

    /**
     * 判断指定的对象在缓存中是否存在
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @param key       缓存中的key
     */
    public boolean isExisted(String cacheName, String key) {
        return getValue(cacheName, key) != null;
    }

    /**
     * 移除缓存对象中的指定元素
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @param key       缓存中的key
     */
    public boolean removeElement(String cacheName, String key) {
        Cache cache = getCache(cacheName);
        return cache.remove(key);
    }

    /**
     * 移除缓存对象中的所有元素
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     */
    public void removeAllElement(String cacheName) {
        Cache cache = getCache(cacheName);
        cache.removeAll();
    }

    /**
     * 移除指定的缓存对象
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     */
    public void removeCache(String cacheName) {
        cacheManager.removeCache(cacheName);
    }

    /**
     * 移除所有缓存对象
     */
    public void removeAllCaches() {
        cacheManager.removeAllCaches();
    }

    /**
     * 获取指定缓存中的对象数
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @return 缓存中的对象数
     */
    public int getCacheObjSize(String cacheName) {
        Cache cache = getCache(cacheName);
        List<?> keys = cache.getKeys();
        if (CollUtil.isEmpty(keys)) {
            return 0;
        }
        return keys.size();
    }

    /**
     * 获取指定缓存中的对象数，仅限未过期的数据
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @return 缓存中的对象数
     */
    public int getCacheSize(String cacheName) {
        Cache cache = getCache(cacheName);
        List<?> list = cache.getKeysWithExpiryCheck();
        if (CollUtil.isEmpty(list)) {
            return 0;
        }
        return list.size();
    }

    /**
     * 获取指定缓存对象占用的内存大小
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @return 缓存对象占用的内存大小
     */
    public long getCacheMemoryStoreSize(String cacheName) {
        Cache cache = getCache(cacheName);
        return cache.getStatistics().getLocalHeapSize();
    }

    /**
     * 获取指定缓存读取的命中次数
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @return 缓存读取的命中次数
     */
    public long getCacheHits(String cacheName) {
        Cache cache = getCache(cacheName);
        return cache.getStatistics().cacheHitCount();
    }

    /**
     * 获取指定缓存读取的未命中次数
     *
     * @param cacheName 在ehcache.xml中配置的缓存名称
     * @return 缓存读取的未命中次数
     */
    public long getCacheMisses(String cacheName) {
        Cache cache = getCache(cacheName);
        return cache.getStatistics().cacheMissCount();
    }

    /**
     * 获取所有的缓存名称
     *
     * @return 存放缓存名称的数组
     */
    public String[] getCacheNames() {
        return cacheManager.getCacheNames();
    }

    /**
     * 关闭CacheManager
     */
    public void shutdown() {
        cacheManager.shutdown();
    }

}
