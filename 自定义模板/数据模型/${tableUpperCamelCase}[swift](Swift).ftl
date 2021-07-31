<#-- 用于生成Swift数据模型的自定义模板 -->

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 * 
 * Created by ${paramConfig.author} on ${today}.
 */
class ${tableInfo.upperCamelCase}: Mappable {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
    // ${fieldInfo.remark!fieldInfo.colName}
        <#if fieldInfo.javaType == "Date">
    var ${fieldInfo.lowerCamelCase}: datetime?
        <#elseif fieldInfo.isNumericType>
    var ${fieldInfo.lowerCamelCase}: Int?
        <#else>
    var ${fieldInfo.lowerCamelCase}: String?
        </#if>

    </#list>
    init() { }

    required init?(_ map: Map) {
    }

    // Mappable
    func mapping(map: Map) {
    <#list tableInfo.fieldInfos as fieldInfo>
        ${fieldInfo.lowerCamelCase}         <- map["${fieldInfo.lowerCamelCase}"]
    </#list>
    }
</#if>
}