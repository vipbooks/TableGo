<#-- 自定义模板导出数据生成CSV -->
<#if tableInfo.fieldInfos?has_content>
序号,<#list tableInfo.fieldInfos as fieldInfo><#if StringUtils.isNotBlank(fieldInfo.remark)>${fieldInfo.simpleRemark}<#else>${fieldInfo.proName}</#if><#if fieldInfo_has_next>,</#if></#list>
    <#if tableInfo.sqlQueryDataList?has_content>
        <#list tableInfo.sqlQueryDataList as data>
${data_index + 1},<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??><#elseif FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>${data[fieldInfo.originalColName]?string(DateUtils.DATE_TIME_PATTERN)}<#elseif fieldInfo.javaType=="Boolean">${data[fieldInfo.originalColName]?string("是","否")}<#else>${data[fieldInfo.originalColName]}</#if><#if fieldInfo_has_next>,</#if></#list>
        </#list>
    </#if>
</#if>