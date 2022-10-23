<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.BooleanUtil;
</#if>
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.Page;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
public class ${tableInfo.upperCamelCase}ServiceImpl implements ${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}ServiceImpl.class);

    @Autowired
    private ${tableInfo.upperCamelCase}Mapper ${tableInfo.upperCamelCase}Mapper;

    @Override
    public PageInfo<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        Page<${tableInfo.upperCamelCase}> page = condition.buildPage();
        Assert.isNotNull(page, "分页参数不能为空！");

        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        PageInfo<${tableInfo.upperCamelCase}> pageInfo = new PageInfo<>(${tableInfo.lowerCamelCase}Mapper.find${tableInfo.upperCamelCase}List(condition));
        return pageInfo;
    }

    @Override
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Mapper.find${tableInfo.upperCamelCase}List(condition);
        return list;
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.upperCamelCase}Mapper.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    @Override
    public Boolean check${fieldInfo.upperCamelCase}Existed(${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>) {
        return BooleanUtil.toBoolean(this.baseMapper.check${fieldInfo.upperCamelCase}Existed(${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkLowerCamelName}</#if>));
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
        return ${tableInfo.upperCamelCase}Mapper.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
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
        return ${tableInfo.upperCamelCase}Mapper.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.upperCamelCase}Mapper.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<String> idList) {
        return ${tableInfo.upperCamelCase}Mapper.delete${tableInfo.upperCamelCase}ByIds(idList);
    }
    <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}LogicByIds(List<String> idList) {
        String userId = null;
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}LogicByIds(idList, userId);
    }
    </#if>
</#if>
}