<#-- 用于生成Rust数据模型的自定义模板 -->

// <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
// Created by ${paramConfig.author} on ${today}.
#[derive(Default, Debug, Serialize)]
pub struct ${tableInfo.upperCamelCase} {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.fieldType == "Date">
    pub ${fieldInfo.lowerColName}: DateTime, // ${fieldInfo.remark!fieldInfo.colName}
        <#elseif fieldInfo.fieldType == "BigDecimal">
    pub ${fieldInfo.lowerColName}: f64, // ${fieldInfo.remark!fieldInfo.colName}
        <#elseif fieldInfo.fieldType == "Integer">
    pub ${fieldInfo.lowerColName}: u32, // ${fieldInfo.remark!fieldInfo.colName}
        <#else>
    pub ${fieldInfo.lowerColName}: String, // ${fieldInfo.remark!fieldInfo.colName}
        </#if>
    </#list>
</#if>
}