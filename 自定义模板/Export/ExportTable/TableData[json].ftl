<#-- 用于生成导出表数据的JSON自定义模板 -->
<#if tableInfoList?has_content>
[
    <#list tableInfoList as tableInfo>
        <#assign tableDataList = null />
        <#if tableDataMap?has_content && tableDataMap[tableInfo.originalTableName]??>
            <#assign tableDataList = tableDataMap[tableInfo.originalTableName] />
        </#if>
        <#if tableDataList?has_content && tableInfo.fieldInfos?has_content>
    {
        "tableName": "${tableInfo.tableName}",
        "tableRemark": "${tableInfo.remark}",
        "dataList": [
            <#list tableDataList as data>
            {
                <#list tableInfo.fieldInfos as fieldInfo>
                "${fieldInfo.lowerCamelCase}": <#if !data[fieldInfo.originalColName]??>null<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>,</#if>
                </#list>
            }<#if data_has_next>,</#if>
            </#list>
        ]
    }<#if tableInfo_has_next>,</#if>
        </#if>
    </#list>
]
</#if>