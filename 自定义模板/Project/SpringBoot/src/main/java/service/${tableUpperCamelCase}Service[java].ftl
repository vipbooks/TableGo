<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化查询字段中的日期字段 -->
<#assign dateFieldInfo = FtlUtils.getFieldInfoByType(searchFields, "Date") />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
<#-- 初始化是否是使用缓存的表 -->
<#assign isUseCacheTable = FtlUtils.tableExisted(tableInfo, jsonParam.useCacheTables) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if checkValueExistedFields?has_content || tableInfo.pkLowerCamelName?has_content>
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
</#if>
<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import ${jsonParam.basePackagePath}.common.util.Assert;
</#if>
<#if tableInfo.pkLowerCamelName?has_content>
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Collections;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
</#if>
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
</#if>
<#if !tableInfo.pkIsStringType>
import java.util.Objects;
</#if>
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.collection.CollUtil;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
@Service
@Transactional(readOnly = true)
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
@CacheConfig(cacheNames = "${tableInfo.lowerCamelCase}Cache")
</#if>
public class ${tableInfo.upperCamelCase}Service extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> {
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition 查询条件
     * @return 分页数据
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
<#if isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if dateFieldInfo?has_content>

        queryWrapper.ge(condition.get${dateFieldInfo.upperCamelCase}Begin() != null, ${dateFieldInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}Begin());
        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lt(${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATED_TIME")>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreatedTime);
    </#if>
        return this.page(page, queryWrapper);
<#else>
    <#if dateFieldInfo?has_content>

        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            condition.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}List(page, condition);
</#if>
    }

    /**
     * 查询${tableInfo.simpleRemark}列表
     * 
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 列表数据
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase}Condition condition) {
<#if isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if dateFieldInfo?has_content>

        queryWrapper.ge(condition.get${dateFieldInfo.upperCamelCase}Begin() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}Begin());
        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lt(${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATED_TIME")>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreatedTime);
    </#if>
        return this.list(queryWrapper);
<#else>
    <#if dateFieldInfo?has_content>
        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            condition.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}List(condition);
</#if>
    }

    /**
     * 查询${tableInfo.simpleRemark}
     *
     * @param condition 查询条件
     * @return ${tableInfo.simpleRemark}
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase}Condition condition) {
<#if isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper();
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
                <#if !fieldInfo.isDateType>
        queryWrapper.eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}());
                </#if>
        </#list>
    </#if>
        return this.getOne(queryWrapper, false);
<#else>
        List<${tableInfo.upperCamelCase}> list = this.baseMapper.get${tableInfo.upperCamelCase}(condition);
        if (CollUtil.isNotEmpty(list)) {
            if (list.size() > 1) {
                log.warn("Expected one result (or null) to be returned by get${tableInfo.upperCamelCase}(), but found: {}", list.size());
            }
            return list.get(0);
        }
        return null;
</#if>
    }
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }

    /**
     * 根据主键ID列表查询${tableInfo.simpleRemark}列表
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return 列表数据
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Collections.emptyList();
        }
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.in(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, idList.stream().filter(<#if tableInfo.pkIsStringType>StrUtil::isNotBlank<#else>Objects::nonNull</#if>).distinct().collect(Collectors.toList()));
        return this.list(queryWrapper);
    }

    /**
     * 查询主键ID列表对应的${tableInfo.simpleRemark}集合
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return Map<${tableInfo.pkSimpleRemark}, ${tableInfo.simpleRemark}>
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        List<${tableInfo.upperCamelCase}> list = find${tableInfo.upperCamelCase}ByIds(idList);
        return Optional.ofNullable(list).orElse(CollUtil.toList()).stream().collect(Collectors.toMap(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.upperCamelCase} -> ${tableInfo.upperCamelCase}));
    }
</#if>
<#if checkValueExistedFields?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否存在
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否存在
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.query();
        queryWrapper.select("1").lambda()
    <#list checkValueExistedFields as fieldInfo>
                .eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())<#else>${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())<#if !fieldInfo_has_next>;</#if>
    </#list>
    <#if tableInfo.pkUpperCamelName?has_content>
        queryWrapper.lambda().ne(<#if tableInfo.pkIsStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())<#else>${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}() != null</#if>, ${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}());
    </#if>
        queryWrapper.last("LIMIT 1");

        return BooleanUtil.toBoolean(this.getObj(queryWrapper, Object::toString));
    }
</#if>

    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return this.save(${tableInfo.lowerCamelCase});
    }

    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return this.updateById(${tableInfo.lowerCamelCase});
    }
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.removeById(${tableInfo.pkLowerCamelName});
    }

    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return this.removeByIds(idList);
    }
</#if>
<#if checkValueExistedFields?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否有效
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     */
    private void check${tableInfo.upperCamelCase}Valid(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
    <#list checkValueExistedFields as fieldInfo>
        ${fieldInfo.javaType} ${fieldInfo.proName} = ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}();
        if (<#if fieldInfo.isStringType>StrUtil.isNotBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} != null</#if>) {
            Boolean ${fieldInfo.proName}Existed = check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.builder()<#if tableInfo.pkLowerCamelName?has_content>.${tableInfo.pkLowerCamelName}(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())</#if>.${fieldInfo.proName}(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}()).build());
            Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");
        }
    </#list>
    }
</#if>
}