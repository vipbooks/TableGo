<#-- 用于生成Mapper接口的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

import java.util.List;
import org.apache.ibatis.annotations.Param;
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.domain.${tableInfo.upperCamelCase};

/**
 * ${tableInfo.simpleRemark}Mapper接口
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public interface ${tableInfo.upperCamelCase}Mapper {
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return ${tableInfo.simpleRemark}列表
     */
    List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} select${tableInfo.upperCamelCase}ById(@Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
    int insert${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
    int update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 结果数据
     */
    int delete${tableInfo.upperCamelCase}ById(@Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 批量删除${tableInfo.simpleRemark}
     *
     * @param ids ${tableInfo.pkRemark}数组
     * @return 结果数据
     */
    int delete${tableInfo.upperCamelCase}ByIds(String[] ids);
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
    String check${fieldInfo.upperCamelCase}Existed(@Param("${fieldInfo.proName}") ${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, @Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>);
            </#if>
        </#list>
    </#list>
</#if>
}