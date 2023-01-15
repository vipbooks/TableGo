package ${jsonParam.packagePath}

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.DataType;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * Redis客户端接口<br/>
 * Redis命令参考：http://redisdoc.com
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
@Service
public class RedisService {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /* =============================操作Key的方法============================= */

    /**
     * 设置缓存失效时间
     *
     * @param key     键
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     */
    public Boolean expire(String key, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || unit == null) {
            return false;
        }
        try {
            return redisTemplate.expire(key, timeout, unit);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置缓存失效时间
     *
     * @param key     键
     * @param timeout 超时时间，单位秒，0代表为永久有效
     */
    public Boolean expire(String key, long timeout) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.expire(key, timeout, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置缓存失效时间
     *
     * @param key  键
     * @param date 超时时间
     */
    public Boolean expireAt(String key, Date date) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.expireAt(key, date);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 获取key的剩余超时时间
     *
     * @param key  键
     * @param unit 时间单位
     * @return 剩余超时时间，0代表为永久有效
     */
    public Long getExpire(String key, TimeUnit unit) {
        if (StrUtil.isBlank(key) || unit == null) {
            return null;
        }
        try {
            return redisTemplate.getExpire(key, unit);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 获取key的剩余超时时间
     *
     * @param key 键
     * @return 剩余超时时间，单位秒，0代表为永久有效
     */
    public Long getExpire(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.getExpire(key, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 获取key对应值的数据类型
     *
     * @param key 键
     * @return 数据类型
     */
    public DataType type(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.type(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 从当前库中随机返回一个key
     *
     * @return key 键
     */
    public String randomKey(String key) {
        try {
            return redisTemplate.randomKey();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 移除key的过期时间，key将持久保存
     *
     * @param key 键
     * @return 是否成功
     */
    public Boolean persist(String key) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.persist(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 判断key是否存在
     *
     * @param key 键
     * @return 是否存在
     */
    public Boolean hasKey(String key) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.hasKey(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 查找当前库中所有符合给定模式 pattern 的 key 。 <br>
     * KEYS * 匹配数据库中所有 key 。 <br>
     * KEYS h?llo 匹配 hello ， hallo 和 hxllo 等。 <br>
     * KEYS h*llo 匹配 hllo 和 heeeeello 等。 <br>
     * KEYS h[ae]llo 匹配 hello 和 hallo ，但不匹配 hillo 。 <br>
     * 特殊符号用 \ 隔开<br>
     *
     * @param pattern 模式
     * @return 匹配的key集合
     */
    public Set<String> keys(String pattern) {
        if (StrUtil.isBlank(pattern)) {
            return Collections.emptySet();
        }
        try {
            return redisTemplate.keys(pattern);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptySet();
    }

    /**
     * 批量删除缓存key
     *
     * @param keys 一个或多个缓存key
     * @return 删除数量
     */
    public Long deletes(String... keys) {
        if (ObjectUtil.isEmpty(keys)) {
            return null;
        }
        List<String> keyList = Stream.of(keys).filter(StrUtil::isNotBlank).distinct().collect(Collectors.toList());
        try {
            return redisTemplate.delete(keyList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 批量删除缓存key
     *
     * @param keyList key集合
     * @return 删除数量
     */
    public Long deleteList(List<String> keyList) {
        if (CollUtil.isEmpty(keyList)) {
            return null;
        }
        try {
            return redisTemplate.delete(keyList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将当前库中的指定key移动到指定的库db当中
     *
     * @param key     键
     * @param dbIndex 指定库下标
     * @return 是否成功
     */
    public Boolean move(String key, int dbIndex) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.move(key, dbIndex);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将oldKey重命名为newKey
     *
     * @param oldKey 旧key
     * @param newKey 新key
     * @return 是否成功
     */
    public Boolean rename(String oldKey, String newKey) {
        if (StrUtil.hasBlank(oldKey, newKey)) {
            return false;
        }
        try {
            redisTemplate.rename(oldKey, newKey);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 仅当newkey不存在时，将oldKey重命名为newkey
     *
     * @param oldKey 旧key
     * @param newKey 新key
     * @return 是否成功
     */
    public Boolean renameIfAbsent(String oldKey, String newKey) {
        if (StrUtil.hasBlank(oldKey, newKey)) {
            return false;
        }
        try {
            redisTemplate.renameIfAbsent(oldKey, newKey);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /* =============================对存储结构为String（字符串）类型的操作============================= */

    /**
     * 获取字符串长度
     *
     * @param key 键
     * @return 字符串长度
     */
    public Long size(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().size(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 获取key缓存的对象
     *
     * @param key 键
     * @return 值
     */
    public Object get(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 批量获取key缓存的对象列表
     *
     * @param keys 一个或多个键
     * @return 对象列表
     */
    public List<Object> multiGet(String... keys) {
        if (ObjectUtil.isEmpty(keys)) {
            return Collections.emptyList();
        }
        List<String> keyList = Stream.of(keys).filter(StrUtil::isNotBlank).distinct().collect(Collectors.toList());
        try {
            return redisTemplate.opsForValue().multiGet(keyList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptyList();
    }

    /**
     * 批量获取key缓存的对象列表
     *
     * @param keyList 键列表
     * @return 对象列表
     */
    public List<Object> multiGet(List<String> keyList) {
        if (CollUtil.isEmpty(keyList)) {
            return Collections.emptyList();
        }
        try {
            return redisTemplate.opsForValue().multiGet(keyList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptyList();
    }

    /**
     * 返回 key 中字符串值的子字符串，字符串的截取范围由 start 和 end 两个偏移量决定(包括 start 和 end 在内)。<br>
     * 负数偏移量表示从字符串最后开始计数， -1 表示最后一个字符， -2 表示倒数第二个，以此类推。
     *
     * @param key   键
     * @param start 开始位置(包含)
     * @param end   结束位置(包含)
     * @return 对象列表
     */
    public String getRange(String key, long start, long end) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().get(key, start, end);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 根据key设置value值
     *
     * @param key   键
     * @param value 值
     * @return 是否成功
     */
    public boolean set(String key, Object value) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            redisTemplate.opsForValue().set(key, value);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据key设置value值并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @return 是否成功
     */
    public boolean set(String key, Object value, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || unit == null) {
            return false;
        }
        try {
            redisTemplate.opsForValue().set(key, value, timeout, unit);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据key设置value值并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public boolean set(String key, Object value, long timeout) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            redisTemplate.opsForValue().set(key, value, timeout, TimeUnit.SECONDS);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据key设置value值，并返回key的旧值(old value)
     *
     * @param key   键
     * @param value 值
     * @return 是否成功
     */
    public Object getAndSet(String key, Object value) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().getAndSet(key, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 根据key设置value值，只有key不存时才设置key的值
     *
     * @param key   键
     * @param value 值
     * @return 是否成功
     */
    public Boolean setIfAbsent(String key, Object value) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.opsForValue().setIfAbsent(key, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据key设置value值，只有key不存时才设置key的值，并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @return 是否成功
     */
    public Boolean setIfAbsent(String key, Object value, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || unit == null) {
            return false;
        }
        try {
            return redisTemplate.opsForValue().setIfAbsent(key, value, timeout, unit);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据key设置value值，只有key不存时才设置key的值，并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public Boolean setIfAbsent(String key, Object value, long timeout) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.opsForValue().setIfAbsent(key, value, timeout, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 用 value 参数覆写给定 key 所储存的字符串值，从偏移量 offset 开始
     *
     * @param key   键
     * @param value 值
     * @return 是否成功
     */
    public Boolean setRange(String key, String value, long offset) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            redisTemplate.opsForValue().set(key, value, offset);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 将value追加到key原来的值的末尾
     *
     * @param key   键
     * @param value 值
     * @return 追加后的长度
     */
    public Integer append(String key, String value) {
        if (StrUtil.hasBlank(key, value)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().append(key, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 批量添加键值对数据
     *
     * @param map 键
     * @return 是否成功
     */
    public Boolean multiSet(Map<String, String> map) {
        if (MapUtil.isEmpty(map)) {
            return false;
        }
        try {
            redisTemplate.opsForValue().multiSet(map);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 批量添加键值对数据，并且仅当所有给定key都不存在时
     *
     * @param map 键
     * @return 是否成功
     */
    public Boolean multiSetIfAbsent(Map<String, String> map) {
        if (MapUtil.isEmpty(map)) {
            return false;
        }
        try {
            return redisTemplate.opsForValue().multiSetIfAbsent(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据递增因子递增值，负数则是递减，返回更新的值
     *
     * @param key   键
     * @param delta 递增因子，负数则是递减
     * @return 更新的值
     */
    public Long increment(String key, long delta) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForValue().increment(key, delta);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /* ========================对存储结构为List（列表）类型的操作======================== */

    /**
     * 获取列表指定范围内的元素
     *
     * @param key   键
     * @param start 开始
     * @param end   结束，0 到 -1代表所有值
     * @return 范围内的元素
     */
    public List<Object> lRange(String key, long start, long end) {
        if (StrUtil.isBlank(key)) {
            return Collections.emptyList();
        }
        try {
            return redisTemplate.opsForList().range(key, start, end);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptyList();
    }

    /**
     * 获取列表的长度
     *
     * @param key 键
     * @return 列表的长度
     */
    public Long lSize(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForList().size(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 通过索引获取列表中的元素
     *
     * @param key   键
     * @param index 索引，index >= 0时，0表头，1 第二个元素，依次类推；index <0 时，-1，表尾，-2倒数第二个元素，依次类推
     * @return 指定索引的元素
     */
    public Object lIndex(String key, long index) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForList().index(key, index);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 添加值到列表的表尾(最右边)
     *
     * @param key   键
     * @param value 值
     * @return 执行操作后列表的长度
     */
    public Long lRightPush(String key, Object value) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForList().rightPush(key, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 添加值到列表的表尾(最右边)，并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @return 是否成功
     */
    public boolean lRightPush(String key, Object value, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || unit == null) {
            return false;
        }
        try {
            redisTemplate.opsForList().rightPush(key, value);
            expire(key, timeout, unit);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 添加值到列表的表尾(最右边)，并设置超时时间
     *
     * @param key     键
     * @param value   值
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public boolean lRightPush(String key, Object value, long timeout) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            redisTemplate.opsForList().rightPush(key, value);
            expire(key, timeout);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 批量添加值到列表的表尾(最右边)
     *
     * @param key       键
     * @param valueList 值列表
     * @return 执行操作后列表的长度
     */
    public Long lRightPushAll(String key, List<Object> valueList) {
        if (StrUtil.isBlank(key) || CollUtil.isEmpty(valueList)) {
            return null;
        }
        try {
            return redisTemplate.opsForList().rightPushAll(key, valueList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 批量添加值到列表的表尾(最右边)，并设置超时时间
     *
     * @param key       键
     * @param valueList 值列表
     * @param timeout   超时时间，0代表为永久有效
     * @param unit      时间单位
     * @return 是否成功
     */
    public boolean lRightPushAll(String key, List<Object> valueList, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || CollUtil.isEmpty(valueList) || unit == null) {
            return false;
        }
        try {
            redisTemplate.opsForList().rightPushAll(key, valueList);
            expire(key, timeout, unit);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 批量添加值到列表的表尾(最右边)，并设置超时时间
     *
     * @param key       键
     * @param valueList 值列表
     * @param timeout   超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public boolean lRightPushAll(String key, List<Object> valueList, long timeout) {
        if (StrUtil.isBlank(key) || CollUtil.isEmpty(valueList)) {
            return false;
        }
        try {
            redisTemplate.opsForList().rightPushAll(key, valueList);
            expire(key, timeout);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据索引设置列表元素的值
     *
     * @param key   键
     * @param index 索引
     * @param value 值
     * @return 是否成功
     */
    public boolean lSet(String key, long index, Object value) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            redisTemplate.opsForList().set(key, index, value);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 根据参数 count 的值，移除列表中与参数 value 相等的元素
     * count 的值可以是以下几种：<br>
     * count > 0 : 从表头开始向表尾搜索，移除与 value 相等的元素，数量为 count 。<br>
     * count < 0 : 从表尾开始向表头搜索，移除与 value 相等的元素，数量为 count 的绝对值。<br>
     * count = 0 : 移除表中所有与 value 相等的值。
     *
     * @param key   键
     * @param count 移除数
     * @param value 要匹配删除的值
     * @return 被移除元素的数量
     */
    public Long lRemove(String key, long count, Object value) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForList().remove(key, count, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /* ========================对存储结构为Set（集合）类型的操作======================== */

    /**
     * 获取集合中所有元素值
     *
     * @param key 键
     * @return 所有元素值
     */
    public Set<Object> sMembers(String key) {
        if (StrUtil.isBlank(key)) {
            return Collections.emptySet();
        }
        try {
            return redisTemplate.opsForSet().members(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptySet();
    }

    /**
     * 获取集合的长度
     *
     * @param key 键
     * @return 集合的长度
     */
    public Long sGetSetSize(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForSet().size(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 随机获取集合中的一个元素值
     *
     * @param key 键
     * @return 随机元素值
     */
    public Object sRandomMember(String key) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForSet().randomMember(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 判断集合是否包含指定的元素值
     *
     * @param key   键
     * @param value 元素值
     * @return 是否包含
     */
    public Boolean sIsMember(String key, Object value) {
        if (StrUtil.isBlank(key)) {
            return false;
        }
        try {
            return redisTemplate.opsForSet().isMember(key, value);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 添加一个或多个元素值到集合中
     *
     * @param key    键
     * @param values 一个或多个元素值
     * @return 被添加到集合中新元素的数量，不包括被忽略的元素
     */
    public Long sAdd(String key, Object... values) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForSet().add(key, values);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 添加一个或多个元素值到集合中，并添加超时时间
     *
     * @param key     键
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @param values  一个或多个元素值
     * @return 被添加到集合中新元素的数量，不包括被忽略的元素
     */
    public Long sAddEx(String key, long timeout, TimeUnit unit, Object... values) {
        if (StrUtil.isBlank(key) || unit == null) {
            return null;
        }
        try {
            Long count = redisTemplate.opsForSet().add(key, values);
            expire(key, timeout, unit);
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 添加一个或多个元素值到集合中，并添加超时时间
     *
     * @param key     键
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @param values  一个或多个元素值
     * @return 被添加到集合中新元素的数量，不包括被忽略的元素
     */
    public Long sAddExSe(String key, long timeout, Object... values) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            Long count = redisTemplate.opsForSet().add(key, values);
            expire(key, timeout);
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 从集合中移除一个或多个元素值
     *
     * @param key    键
     * @param values 一个或多个元素值
     * @return 移除的个数
     */
    public Long sRemove(String key, Object... values) {
        if (StrUtil.isBlank(key)) {
            return null;
        }
        try {
            return redisTemplate.opsForSet().remove(key, values);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /* ========================对存储结构为Hash（哈希表）类型的操作======================== */

    /**
     * 获取哈希表 key 中给定hashKey对应的值
     *
     * @param key     键
     * @param hashKey 项
     * @return hashKey对应的值
     */
    public Object hget(String key, Object hashKey) {
        if (StrUtil.hasBlank(key) || hashKey == null) {
            return null;
        }
        try {
            return redisTemplate.opsForHash().get(key, hashKey);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 获取哈希表key中所有hashKey的值
     *
     * @param key 键
     * @return 所有hashKey的值
     */
    public Map<Object, Object> hmget(String key) {
        if (StrUtil.isBlank(key)) {
            return Collections.emptyMap();
        }
        try {
            return redisTemplate.opsForHash().entries(key);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptyMap();
    }

    /**
     * 获取哈希表key中指定多个hashKey的值列表
     *
     * @param key      键
     * @param hashKeys 一个或多个hashKey
     * @return 多个hashKey的值列表
     */
    public List<Object> hmultiGet(String key, Object... hashKeys) {
        if (StrUtil.isBlank(key) || ObjectUtil.isEmpty(hashKeys)) {
            return Collections.emptyList();
        }
        List<Object> hashKeyList = Stream.of(hashKeys).filter(Objects::nonNull).distinct().collect(Collectors.toList());
        try {
            return redisTemplate.opsForHash().multiGet(key, hashKeyList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return Collections.emptyList();
    }

    /**
     * 批量设置哈希表key中对应的值
     *
     * @param key 键
     * @param map 一个或多个值
     * @return 是否成功
     */
    public boolean hmset(String key, Map<String, Object> map) {
        if (StrUtil.isBlank(key) || MapUtil.isEmpty(map)) {
            return false;
        }
        try {
            redisTemplate.opsForHash().putAll(key, map);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中对应的值，并添加过期时间
     *
     * @param key     键
     * @param map     一个或多个值
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @return 是否成功
     */
    public boolean hmset(String key, Map<String, Object> map, long timeout, TimeUnit unit) {
        if (StrUtil.isBlank(key) || MapUtil.isEmpty(map) || unit == null) {
            return false;
        }
        try {
            redisTemplate.opsForHash().putAll(key, map);
            expire(key, timeout, unit);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中对应的值，并添加过期时间
     *
     * @param key     键
     * @param map     一个或多个值
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public boolean hmset(String key, Map<String, Object> map, long timeout) {
        if (StrUtil.isBlank(key) || MapUtil.isEmpty(map)) {
            return false;
        }
        try {
            redisTemplate.opsForHash().putAll(key, map);
            expire(key, timeout);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中指定hashKey的值，如果没有则创建
     *
     * @param key     键
     * @param hashKey 项
     * @param value   值
     * @return 是否成功
     */
    public boolean hset(String key, String hashKey, Object value) {
        if (StrUtil.hasBlank(key, hashKey)) {
            return false;
        }
        try {
            redisTemplate.opsForHash().put(key, hashKey, value);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中指定hashKey的值，如果没有则创建，并设置过期时间
     *
     * @param key     键
     * @param hashKey 项
     * @param value   值
     * @param timeout 超时时间，0代表为永久有效
     * @param unit    时间单位
     * @return 是否成功
     */
    public boolean hset(String key, String hashKey, Object value, long timeout, TimeUnit unit) {
        if (StrUtil.hasBlank(key, hashKey) || unit == null) {
            return false;
        }
        try {
            redisTemplate.opsForHash().put(key, hashKey, value);
            expire(key, timeout, unit);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中指定hashKey的值，如果没有则创建，并设置过期时间
     *
     * @param key     键
     * @param hashKey 项
     * @param value   值
     * @param timeout 超时时间，单位秒，0代表为永久有效
     * @return 是否成功
     */
    public boolean hset(String key, String hashKey, Object value, long timeout) {
        if (StrUtil.hasBlank(key, hashKey)) {
            return false;
        }
        try {
            redisTemplate.opsForHash().put(key, hashKey, value);
            expire(key, timeout);
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 批量删除哈希表中的hashKey
     *
     * @param key      键
     * @param hashKeys 一个或多个hashKey
     * @return 删除数量
     */
    public Long hdel(String key, Object... hashKeys) {
        if (StrUtil.isBlank(key) || ObjectUtil.isEmpty(hashKeys)) {
            return null;
        }
        try {
            return redisTemplate.opsForHash().delete(key, hashKeys);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 判断哈希表中是否存在指定的hashKey
     *
     * @param key     键
     * @param hashKey 项
     * @return 是否存在
     */
    public Boolean hHasKey(String key, Object hashKey) {
        if (StrUtil.isBlank(key) || ObjectUtil.isEmpty(hashKey)) {
            return false;
        }
        try {
            return redisTemplate.opsForHash().hasKey(key, hashKey);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    /**
     * 设置哈希表key中指定hashKey的值，根据递增因子递增值，负数则是递减，返回更新的值
     *
     * @param key     键
     * @param hashKey 项
     * @param delta   递增因子，负数则是递减
     * @return 更新的值
     */
    public Long hIncrement(String key, Object hashKey, long delta) {
        if (StrUtil.isBlank(key) || ObjectUtil.isEmpty(hashKey)) {
            return null;
        }
        try {
            return redisTemplate.opsForHash().increment(key, hashKey, delta);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
}