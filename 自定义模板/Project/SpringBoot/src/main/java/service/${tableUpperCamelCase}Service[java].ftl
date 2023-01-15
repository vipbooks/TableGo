<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
<#-- 初始化是否是使用缓存的表 -->
<#assign isUseCacheTable = FtlUtils.tableExisted(tableInfo, jsonParam.useCacheTables) />
package ${jsonParam.packagePath}

<#if isNoSqlTable>
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
<#else>
import cn.hutool.core.collection.CollUtil;
</#if>
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import ${jsonParam.basePackagePath}.common.util.Assert;
</#if>
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
</#if>
import java.util.List;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
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
<#assign fieldInfo = FtlUtils.getFieldByFieldTypeAtList(tableInfo, searchFields, "Date") />
<#if isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if fieldInfo?has_content>

        queryWrapper.ge(condition.get${fieldInfo.upperCamelCase}Begin() != null, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}Begin());
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lt(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATION_DATE")>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreationDate);
    </#if>
        return this.page(page, queryWrapper);
<#else>
    <#if fieldInfo?has_content>

        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            condition.set${fieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
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
    <#if FtlUtils.fieldExisted(tableInfo, "CREATION_DATE")>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreationDate);
    </#if>
        return this.list(queryWrapper);
<#else>
    <#if dateFieldInfo?has_content>
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            condition.set${fieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
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
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
        return this.getOne(queryWrapper, false);
    <#else>
        List<${tableInfo.upperCamelCase}> list = this.baseMapper.get${tableInfo.upperCamelCase}(condition);
        if (CollUtil.isNotEmpty(list)) {
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
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    /**
     * 检查${fieldInfo.simpleRemark!fieldInfo.colName}是否存在
     *
     * @param ${fieldInfo.proName} ${fieldInfo.simpleRemark}
                <#if tableInfo.pkLowerCamelName?has_content>
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}(排除)
                </#if>
     * @return 是否存在
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public Boolean check${fieldInfo.upperCamelCase}Existed(${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>) {
                <#if !fieldInfo.isNotNull>
        if (<#if fieldInfo.javaType == "String">StrUtil.isBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} == null</#if>) {
            return false;
        }
                </#if>
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.query();
        queryWrapper.select("1").lambda().eq(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, ${fieldInfo.proName});
        <#if tableInfo.pkLowerCamelName?has_content>
        if (<#if fieldInfo.javaType == "String">StrUtil.isNotBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} != null</#if>) {
            queryWrapper.lambda().ne(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.pkLowerCamelName});
        }
        </#if>
        queryWrapper.last("LIMIT 1");

        return BooleanUtil.toBoolean(this.getObj(queryWrapper, Object::toString));
    }
            </#if>
        </#list>
    </#list>
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
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        Boolean ${fieldInfo.proName}Existed = check${fieldInfo.upperCamelCase}Existed(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}()<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}()</#if>);
        Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");
            </#if>
        </#list>
    </#list>
    }
</#if>
}