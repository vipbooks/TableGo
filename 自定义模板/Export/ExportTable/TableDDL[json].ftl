<#-- 用于生成导出表结构的JSON自定义模板 -->
<#if tableInfoList?has_content>
[
    <#list tableInfoList as tableInfo>
    {
        "tableName": "${tableInfo.tableName}",
        "tableRemark": "${tableInfo.remark}"<#if tableInfo.fieldInfos?has_content>,</#if>
        <#if tableInfo.fieldInfos?has_content>
        "fieldInfos": [
            <#list tableInfo.fieldInfos as fieldInfo>
            {
                "fieldName": "${fieldInfo.colName}",
                "fieldType": "${fieldInfo.dataTypeStr}",
                "primaryKey": "${fieldInfo.primaryKey?string('是', '否')}",
                "isNotNull": "${fieldInfo.isNotNull?string('是', '否')}",
                "defaultValue": "${fieldInfo.defaultValue}",
                "remark": "${fieldInfo.remark}"
            }<#if fieldInfo_has_next>,</#if>
            </#list>
        ]
        </#if>
    }<#if tableInfo_has_next>,</#if>
    </#list>
]
</#if>