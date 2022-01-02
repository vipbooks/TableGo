package cn.tablego.project.springboot.service;

import java.util.List;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.tablego.project.springboot.mapper.AreaMapper;
import cn.tablego.project.springboot.model.Area;
import cn.tablego.project.springboot.model.condition.AreaCondition;
import lombok.extern.slf4j.Slf4j;

/**
 * 地区Service接口实现
 *
 * @author bianj
 * @version 1.0.0 2021-06-24
 */
@Slf4j
@Service
@Transactional(readOnly = true)
@CacheConfig(cacheNames = "AreaService")
public class AreaService extends ServiceImpl<AreaMapper, Area> {
    /**
     * 根据条件分页查询地区列表
     *
     * @param condition 查询条件
     * @return 分页数据
     */
    @Cacheable
    public IPage<Area> findAreaPage(AreaCondition condition) {
        IPage<Area> page = condition.buildPage();
        return this.baseMapper.findAreaPage(page, condition);
    }

    /**
     * 根据主键ID查询地区信息
     *
     * @param id 主键ID
     * @return 地区信息
     */
    @Cacheable
    public Area getAreaById(String id) {
        return this.getById(id);
    }

    /**
     * 根据主键ID查询地区信息
     *
     * @param id 主键ID
     * @return 地区信息
     */
    @Cacheable(key = "methodName + #id")
    public Area getAreaById2(String id) {
        return this.getById(id);
    }

    /**
     * 新增地区信息
     *
     * @param area 地区信息
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean addArea(Area area) {
        return this.save(area);
    }

    /**
     * 修改地区信息
     *
     * @param area 地区信息
     * @return 是否成功
     */
    @CacheEvict(allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateArea(Area area) {
        return this.updateById(area);
    }

    /**
     * 根据主键ID删除地区
     *
     * @param id 主键ID
     * @return 是否成功
     */
    @CacheEvict(allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteAreaById(String id) {
        return this.removeById(id);
    }

    /**
     * 根据主键ID列表批量删除地区
     *
     * @param idList 主键ID列表
     * @return 是否成功
     */
    @CacheEvict(allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteAreaByIds(List<String> idList) {
        return this.removeByIds(idList);
    }
}