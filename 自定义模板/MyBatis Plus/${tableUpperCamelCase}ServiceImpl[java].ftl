<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化查询字段中的日期字段 -->
<#assign dateFieldInfo = FtlUtils.getFieldByFieldTypeAtList(tableInfo, searchFields, "Date") />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
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
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.collection.CollUtil;

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
@Slf4j
@Service
@Transactional(readOnly = true)
public class ${tableInfo.upperCamelCase}ServiceImpl extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> implements ${tableInfo.upperCamelCase}Service {
    @Override
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
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
        return this.page(page, queryWrapper);
<#else>
    <#if dateFieldInfo?has_content>
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            condition.set${fieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}List(page, condition);
</#if>
    }

    @Override
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

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase}Condition condition) {
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper();
        <#if searchFields?has_content>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#list searchFields as fieldName>
                    <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        queryWrapper.eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}());
                    </#if>
                </#list>
            </#list>
        </#if>
        return this.getOne(queryWrapper, false);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }

    @Override
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Collections.emptyList();
        }
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.in(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, idList.stream().filter(StrUtil::isNotBlank).distinct().collect(Collectors.toList()));
        return this.list(queryWrapper);
    }

    @Override
    public Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        List<${tableInfo.upperCamelCase}> list = find${tableInfo.upperCamelCase}ByIds(idList);
        return Optional.ofNullable(list).orElse(CollUtil.toList()).stream().collect(Collectors.toMap(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.upperCamelCase} -> ${tableInfo.upperCamelCase}));
    }
</#if>
<#if checkValueExistedFields?has_content>

    @Override
    public Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.query();
        queryWrapper.select("1").lambda()
    <#list checkValueExistedFields as fieldName>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                .eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())<#else>${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())<#if !fieldName_has_next>;</#if>
            </#if>
        </#list>
    </#list>
        <#if tableInfo.pkUpperCamelName?has_content>
        queryWrapper.lambda().ne(<#if tableInfo.pkIsStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())<#else>${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}() != null</#if>, ${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}());
        </#if>
        queryWrapper.last("LIMIT 1");

        return BooleanUtil.toBoolean(this.getObj(queryWrapper, Object::toString));
    }
</#if>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return this.save(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
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
        ${fieldInfo.javaType} ${fieldInfo.proName} = ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}();
        if (<#if fieldInfo.isStringType>StrUtil.isNotBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} != null</#if>) {
            ${tableInfo.upperCamelCase} condition = ${tableInfo.upperCamelCase}.builder()<#if tableInfo.pkUpperCamelName?has_content>.${tableInfo.pkLowerCamelName}(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())</#if>.${fieldInfo.proName}(${fieldInfo.proName}).build();
            Boolean ${fieldInfo.proName}Existed = check${tableInfo.upperCamelCase}Existed(condition);
            Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");
        }
            </#if>
        </#list>
    </#list>
    }
</#if>
}