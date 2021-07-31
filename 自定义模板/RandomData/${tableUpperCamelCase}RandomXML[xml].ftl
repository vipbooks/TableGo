<#-- 根据数据库表结构生成XML随机数据 -->
<?xml version="1.0" encoding="UTF-8"?>

<!-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<${tableInfo.lowerCamelCase}List>
<#if tableInfo.fieldInfos?has_content>
    <#list 1..10 as i>
    <${tableInfo.lowerCamelCase}>
        <#list tableInfo.fieldInfos as fieldInfo>
        <${fieldInfo.lowerCamelCase}><#if fieldInfo.primaryKey>${IdWorker.getId()}<#elseif fieldInfo.isNumericType>${RandomStringUtils.randomNumeric(fieldInfo.columnSize)}<#elseif fieldInfo.javaType=="Date">${DateUtils.getNow()}<#else>${RandomStringUtils.randomAlphanumeric(((fieldInfo.columnSize>50)?string(50,fieldInfo.columnSize))?number)}</#if></${fieldInfo.lowerCamelCase}>
        </#list>
    </${tableInfo.lowerCamelCase}>
    </#list>
</#if>
</${tableInfo.lowerCamelCase}List>