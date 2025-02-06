<#-- 根据数据库表结构生成JSON随机数据 -->
[
<#if tableInfo.fieldInfos?has_content>
    <#list 1..10 as i>
    {
        <#list tableInfo.fieldInfos as fieldInfo>
      "${fieldInfo.lowerCamelCase}": "<#if fieldInfo.primaryKey><#if tableInfo.pkColumnSize gte 32>${IdWorker.get32UUID()}<#elseif fieldInfo.columnSize gte 19>${IdWorker.getId()}<#else>${FtlUtils.getRandomString19(6)}</#if><#elseif fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType><#if fieldInfo.isDateTimeType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${DateUtils.getRandomDate("2000-01-01")}</#if><#elseif fieldInfo.isTimestampType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}</#if>"<#if fieldInfo_has_next>,</#if>
        </#list>
    }<#if i_has_next>,</#if>
    </#list>
</#if>
]