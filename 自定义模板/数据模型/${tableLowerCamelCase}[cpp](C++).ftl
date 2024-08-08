<#-- 用于生成C++数据模型的自定义模板 -->

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 * 
 * Created by ${paramConfig.author} on ${today}.
 */
typedef struct {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.javaType == "BigDecimal">
    double ${fieldInfo.lowerCamelCase}; // ${fieldInfo.remark!fieldInfo.colName}
        <#elseif fieldInfo.javaType == "Integer">
    int ${fieldInfo.lowerCamelCase}; // ${fieldInfo.remark!fieldInfo.colName}
        <#else>
    string ${fieldInfo.lowerCamelCase}; // ${fieldInfo.remark!fieldInfo.colName}
        </#if>
    </#list>
</#if>
} ${tableInfo.upperCamelCase};