<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if checkValueExistedFields?has_content>
import org.apache.commons.lang3.BooleanUtils;
</#if>
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.core.text.Convert;

import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.domain.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.mapper.${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.service.I${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
public class ${tableInfo.upperCamelCase}ServiceImpl implements I${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}ServiceImpl.class);

    @Autowired
    private ${tableInfo.upperCamelCase}Mapper ${tableInfo.lowerCamelCase}Mapper;

    @Override
    public List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}List(${tableInfo.lowerCamelCase});
    }

    @Override
    public ${tableInfo.upperCamelCase} select${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        ${tableInfo.lowerCamelCase}.setCreateTime(DateUtils.getNowDate());
        return ${tableInfo.lowerCamelCase}Mapper.insert${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        ${tableInfo.lowerCamelCase}.setUpdateTime(DateUtils.getNowDate());
        return ${tableInfo.lowerCamelCase}Mapper.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete${tableInfo.upperCamelCase}ByIds(String ids) {
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}ByIds(Convert.toStrArray(ids));
    }
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    @Override
    public Boolean check${fieldInfo.upperCamelCase}Existed(${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>) {
        return BooleanUtils.toBoolean(${tableInfo.lowerCamelCase}Mapper.check${fieldInfo.upperCamelCase}Existed(${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, ${tableInfo.pkLowerCamelName}</#if>));
    }
            </#if>
        </#list>
    </#list>
</#if>
}