<#-- 用于生成导出表结构的XML自定义模板 -->
<?xml version="1.0" encoding="UTF-8"?>

<#if tableInfoList?has_content>
<tableInfoList>
    <#list tableInfoList as tableInfo>
    <tableInfo>
        <tableName>${tableInfo.tableName}</tableName>
        <tableRemark>${tableInfo.tableName}</tableRemark>
        <#if tableInfo.fieldInfos?has_content>
        <fieldInfoList>
            <#list tableInfo.fieldInfos as fieldInfo>
            <fieldInfo>
                <fieldName>${fieldInfo.colName}</fieldName>
                <fieldType>${fieldInfo.dataTypeStr}</fieldType>
                <primaryKey>${fieldInfo.primaryKey?string('是', '否')}</primaryKey>
                <isNotNull>${fieldInfo.isNotNull?string('是', '否')}</isNotNull>
                <defaultValue>${fieldInfo.defaultValue}</defaultValue>
                <remark>${fieldInfo.remark}</remark>
            </fieldInfo>
            </#list>
        </fieldInfoList>
        </#if>
    </tableInfo>
    </#list>
</tableInfoList>
</#if>