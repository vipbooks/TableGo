<#-- 根据数据库表结构生成XML随机数据 -->
<?xml version="1.0" encoding="UTF-8"?>

<!-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<${tableInfo.lowerCamelCase}List>
<#if tableInfo.fieldInfos?has_content>
    <#list 1..10 as i>
    <${tableInfo.lowerCamelCase}>
        <#list tableInfo.fieldInfos as fieldInfo>
        <${fieldInfo.lowerCamelCase}><#if fieldInfo.primaryKey><#if tableInfo.pkColumnSize gte 32>${IdWorker.get32UUID()}<#elseif fieldInfo.columnSize gte 19>${IdWorker.getId()}<#else>${FtlUtils.getRandomString19(6)}</#if><#elseif fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType><#if fieldInfo.isDateTimeType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${DateUtils.getRandomDate("2000-01-01")}</#if><#else>${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}</#if></${fieldInfo.lowerCamelCase}>
        </#list>
    </${tableInfo.lowerCamelCase}>
    </#list>
</#if>
</${tableInfo.lowerCamelCase}List>