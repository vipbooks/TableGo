<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
package ${jsonParam.packagePath}

<#if isNoSqlTable>
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
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
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
@Transactional(readOnly = true)
public class ${tableInfo.upperCamelCase}ServiceImpl extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> implements ${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}Service.class);

    @Override
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
<#assign fieldInfo = FtlUtils.getFieldByFieldTypeAtList(tableInfo, searchFields, "Date") />
<#if isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if fieldInfo?has_content>

        if (condition.get${fieldInfo.upperCamelCase}Begin() != null) {
            queryWrapper.lambda().ge(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}Begin());
        }
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lambda().lt(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
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
        return this.baseMapper.find${tableInfo.upperCamelCase}Page(page, condition);
</#if>
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    @Override
    public Boolean check${fieldInfo.upperCamelCase}Existed(${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>) {
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.query();
        queryWrapper.select("1").lambda().eq(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, ${fieldInfo.proName});
        <#if tableInfo.pkLowerCamelName?has_content>
        if (StrUtil.isNotBlank(${tableInfo.pkLowerCamelName})) {
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

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        Boolean ${fieldInfo.proName}Existed = check${fieldInfo.upperCamelCase}Existed(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}()<#if tableInfo.pkLowerCamelName?has_content>, null</#if>);
        Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");

            </#if>
        </#list>
    </#list>
</#if>
        return this.save(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        Boolean ${fieldInfo.proName}Existed = check${fieldInfo.upperCamelCase}Existed(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}()<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}()</#if>);
        Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");

            </#if>
        </#list>
    </#list>
</#if>
        return this.updateById(${tableInfo.lowerCamelCase});
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.removeById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return this.removeByIds(idList);
    }
</#if>
}