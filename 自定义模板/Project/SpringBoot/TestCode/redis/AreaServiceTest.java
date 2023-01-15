package cn.tablego.project.springboot;

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.Test;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;

import cn.hutool.core.lang.Console;
import cn.hutool.json.JSONUtil;
import cn.tablego.project.springboot.common.service.RedisService;
import cn.tablego.project.springboot.model.Area;
import cn.tablego.project.springboot.model.condition.AreaCondition;
import cn.tablego.project.springboot.service.AreaService;

/**
 * 地区Service接口测试
 *
* @author bianj
* @version 1.0.0 2021-06-24
 */
@SpringBootTest
public class AreaServiceTest {
    @Autowired
    private AreaService areaService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private RedissonClient redissonClient;

    @Autowired
    private RedisService redisService;

    /** 测试根据参数分页查询地区列表 */
    @Test
    public void testFindAreaPage() {
        Instant begin = Instant.now();

        AreaCondition condition = AreaCondition.builder().areaCode("88").areaName("江").build();

        IPage<Area> page = areaService.findAreaPage(condition);
        Console.log("Records: {}", page.getRecords());

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据地区ID查询地区 */
    @Test
    public void testGetAreaById() {
        Instant begin = Instant.now();

        Area area = areaService.getAreaById("59c99909-755c-11ea-b851-204747d7a351");
        Console.log("Area: {}", area);

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据地区ID查询地区 */
    @Test
    public void testGetAreaById2() {
        Instant begin = Instant.now();

        Area area2 = areaService.getAreaById2("59c99909-755c-11ea-b851-204747d7a351");
        Console.log("Area2: {}", area2);

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试RedisTemplate */
    @Test
    public void testStringRedisTemplate() {
        Instant begin = Instant.now();

        Area area = areaService.getAreaById("59c99909-755c-11ea-b851-204747d7a351");
        Console.log("Area1: {}", area);

        String key = "test::testStringRedisTemplate";

        stringRedisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(area), 3, TimeUnit.MINUTES);

        String json = stringRedisTemplate.opsForValue().get(key);
        Console.log("Area2: {}", JSONUtil.toBean(json, Area.class));

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试RedisTemplate */
    @Test
    public void testRedisTemplate() {
        Instant begin = Instant.now();

        Area area = areaService.getAreaById("59c99909-755c-11ea-b851-204747d7a351");
        Console.log("Area1: {}", area);

        String key = "test::testRedisTemplate";

        redisTemplate.opsForValue().set(key, area, 3, TimeUnit.MINUTES);

        Area area2 = (Area) redisTemplate.opsForValue().get(key);
        Console.log("Area2: {}", area2);

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试RedisService */
    @Test
    public void testRedisService() {
        Instant begin = Instant.now();

        Area area = areaService.getAreaById("59c99909-755c-11ea-b851-204747d7a351");
        Console.log("Area1:", area);

        String key = "test::testRedisService";

        redisService.set(key, area, 60);

        Object obj = redisService.get(key);
        Console.log("obj.getClass().getName():", obj.getClass().getName());

        Area area2 = (Area) obj;
        Console.log("Area2:", area2);

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试Redisson分布式锁 */
    @Test
    public void testRedissonLock() {
        Instant begin = Instant.now();

        String id = IdWorker.getIdStr();
        RLock lock = redissonClient.getLock(id);
        if (lock.isLocked()) {
            Console.log("ID已上锁");
            return;
        }
        try {
            Console.log("是否上锁：{}", lock.isLocked());
            lock.lock(10, TimeUnit.SECONDS);
            Console.log("是否上锁：{}", lock.isLocked());

            Console.log("模拟业务执行……");
            TimeUnit.SECONDS.sleep(8);
        } catch (Exception e) {
            Console.error(e.getMessage(), e);
        } finally {
            if (lock.isHeldByCurrentThread()) {
                lock.unlock();
                Console.log("解锁完成");
            } else {
                Console.log("当前线程未持有锁");
            }
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试新增地区 */
    @Test
    public void testAddArea() {
        Instant begin = Instant.now();

        Area area = Area.builder().build();

        boolean bool = areaService.addArea(area);
        if (bool) {
            Console.log("新增地区成功");
        } else {
            Console.log("新增地区失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试修改地区 */
    @Test
    public void testUpdateArea() {
        Instant begin = Instant.now();

        Area area = areaService.getAreaById("799618950700514890106341374429678809");
        if (area == null) {
            Console.log("地区不存在");
            return;
        }
        boolean bool = areaService.updateArea(area);
        if (bool) {
            Console.log("修改地区成功");
        } else {
            Console.log("修改地区失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据主键ID删除地区 */
    @Test
    public void testDeleteAreaById() {
        Instant begin = Instant.now();

        boolean bool = areaService.deleteAreaById("799618950700514890106341374429678809");
        if (bool) {
            Console.log("删除地区成功");
        } else {
            Console.log("删除地区失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据主键ID集合批量删除地区 */
    @Test
    public void testDeleteAreaByIds() {
        Instant begin = Instant.now();

        List<String> idList = new ArrayList<>();

        boolean bool = areaService.deleteAreaByIds(idList);
        if (bool) {
            Console.log("批量删除地区成功");
        } else {
            Console.log("批量删除地区失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
}