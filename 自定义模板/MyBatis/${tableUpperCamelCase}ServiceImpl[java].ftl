<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.BooleanUtil;
</#if>
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import ${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

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
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
        return ${tableInfo.upperCamelCase}Mapper.find${tableInfo.upperCamelCase}Page(page, condition);
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
        return ${tableInfo.upperCamelCase}Mapper.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
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
</#if>
}