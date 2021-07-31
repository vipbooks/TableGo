<#-- 根据数据库表结构生成JSON随机数据 -->
[
<#if tableInfo.fieldInfos?has_content>
    <#list 1..10 as i>
    {
        <#list tableInfo.fieldInfos as fieldInfo>
      "${fieldInfo.lowerCamelCase}": "<#if fieldInfo.primaryKey>${IdWorker.getId()}<#elseif fieldInfo.isNumericType>${RandomStringUtils.randomNumeric(fieldInfo.columnSize)}<#elseif fieldInfo.javaType=="Date">${DateUtils.getNow()}<#else>${RandomStringUtils.randomAlphanumeric(((fieldInfo.columnSize>50)?string(50,fieldInfo.columnSize))?number)}</#if>"<#if fieldInfo_has_next>,</#if>
        </#list>
    }<#if i_has_next>,</#if>
    </#list>
</#if>
]