<#-- 用于生成Golang数据模型的自定义模板 -->

package ${paramConfig.packagePath}

import (

)

// <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
// Created by ${paramConfig.author} on ${today}.
type ${tableInfo.upperCamelCase} struct {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.fieldType == "Date">
    ${fieldInfo.upperCamelCase} time.Time `field:"${fieldInfo.originalColName}"<#if fieldInfo.primaryKey> index:"pk"</#if> json:"${fieldInfo.lowerCamelCase}"` // ${fieldInfo.remark!fieldInfo.colName}
        <#elseif fieldInfo.fieldType == "BigDecimal">
    ${fieldInfo.upperCamelCase} float64 `field:"${fieldInfo.originalColName}"<#if fieldInfo.primaryKey> index:"pk"</#if> json:"${fieldInfo.lowerCamelCase}"` // ${fieldInfo.remark!fieldInfo.colName}
        <#elseif fieldInfo.fieldType == "Integer">
    ${fieldInfo.upperCamelCase} int `field:"${fieldInfo.originalColName}"<#if fieldInfo.primaryKey> index:"pk"</#if> json:"${fieldInfo.lowerCamelCase}"` // ${fieldInfo.remark!fieldInfo.colName}
        <#else>
    ${fieldInfo.upperCamelCase} string `field:"${fieldInfo.originalColName}"<#if fieldInfo.primaryKey> index:"pk"</#if> json:"${fieldInfo.lowerCamelCase}"` // ${fieldInfo.remark!fieldInfo.colName}
        </#if>
    </#list>
</#if>
}