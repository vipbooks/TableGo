<#-- 导出表数据生成JSON数据 -->
[
<#if tableInfo.fieldInfos?has_content && tableInfo.sqlQueryDataList?has_content>
    <#list tableInfo.sqlQueryDataList as data>
    {
            <#list tableInfo.fieldInfos as fieldInfo>
      "${fieldInfo.lowerCamelCase}": "${data[fieldInfo.originalColName]}"<#if fieldInfo_has_next>,</#if>
            </#list>
    }<#if data_has_next>,</#if>
    </#list>
</#if>
]