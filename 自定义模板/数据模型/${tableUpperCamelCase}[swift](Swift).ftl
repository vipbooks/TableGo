<#-- 用于生成Swift数据模型的自定义模板 -->
//
// <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
//
// Created by ${paramConfig.author} on ${today}.
//

import Foundation

struct ${tableInfo.upperCamelCase}: Codable {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
    /// ${fieldInfo.remark!fieldInfo.colName}
        <#if fieldInfo.isNumericType>
            <#if fieldInfo.javaType == "Float">
    var ${fieldInfo.lowerCamelCase}: Float?
            <#elseif fieldInfo.javaType == "Double">
    var ${fieldInfo.lowerCamelCase}: Double?
            <#else>
    var ${fieldInfo.lowerCamelCase}: Int?
            </#if>
        <#elseif fieldInfo.javaType == "Boolean">
    var ${fieldInfo.lowerCamelCase}: Bool?
        <#else>
    var ${fieldInfo.lowerCamelCase}: String?
        </#if>
    </#list>
</#if>
}