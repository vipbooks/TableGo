<#-- 用于生成导出表数据的XML自定义模板 -->
<?xml version="1.0" encoding="UTF-8"?>

<#if tableInfoList?has_content>
<tableInfoList>
    <#list tableInfoList as tableInfo>
        <#assign tableDataList = null />
        <#if tableDataMap?has_content && tableDataMap[tableInfo.originalTableName]??>
            <#assign tableDataList = tableDataMap[tableInfo.originalTableName] />
        </#if>
        <#if tableDataList?has_content && tableInfo.fieldInfos?has_content>
    <tableInfo>
        <tableName>${tableInfo.tableName}</tableName>
        <tableRemark>${tableInfo.tableName}</tableRemark>
        <dataList>
            <#list tableDataList as data>
            <data>
                <#list tableInfo.fieldInfos as fieldInfo>
                <${fieldInfo.lowerCamelCase}>${data[fieldInfo.originalColName]}</${fieldInfo.lowerCamelCase}>
                </#list>
            </data>
            </#list>
        </dataList>
    </tableInfo>
        </#if>
    </#list>
</tableInfoList>
</#if>