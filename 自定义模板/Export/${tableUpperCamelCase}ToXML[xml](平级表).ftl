<#-- 导出表数据生成XML数据 -->
<?xml version="1.0" encoding="UTF-8"?>

<!-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<${tableInfo.lowerCamelCase}List>
<#if tableInfo.fieldInfos?has_content && tableInfo.sqlQueryDataList?has_content>
    <#list tableInfo.sqlQueryDataList as data>
    <${tableInfo.lowerCamelCase}>
        <#list tableInfo.fieldInfos as fieldInfo>
        <${fieldInfo.lowerCamelCase}>${data[fieldInfo.originalColName]}</${fieldInfo.lowerCamelCase}>
        </#list>
    </${tableInfo.lowerCamelCase}>
    </#list>
</#if>
</${tableInfo.lowerCamelCase}List>