<#-- 用于导出数据库表信息生成JSON数据的自定义模板例示 -->
<#-- 通过设置生成单一文件和不收集字段扩展信息可以极大的提高大数据量生成的效率 -->
<#assign tableCount = 0 />
<#assign ignoreCount = 0 />
<#if tableInfoList?has_content>
[
    <#list tableInfoList as tableInfo>
        <#if StringUtils.isBlank(tableInfo.remark)><#assign ignoreCount = ignoreCount + 1 /><#continue/></#if><#assign tableCount = tableCount + 1 />
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
    },
    </#list>
    {
      "统计总计表数量": ${tableInfoList?size},
      "统计有效表数量": ${tableCount},
      "统计忽略表数量": ${ignoreCount}
    }
]
</#if>