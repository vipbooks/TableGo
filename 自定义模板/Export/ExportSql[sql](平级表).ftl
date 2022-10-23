<#-- 自定义模板导出数据生成SQL -->
<#if CollectionUtils.isNotEmpty(tableInfoList)>
    <#if jsonParam.sqlList?has_content>
        <#list jsonParam.sqlList as sql>
            <#list tableInfoList as tableInfo>
                <#if StringUtils.indexOfIgnoreCase(sql.tableNames, tableInfo.tableName) != -1>
TRUNCATE TABLE ${tableInfo.tableName};
                </#if>
            </#list>
        </#list>
    </#if>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.sqlQueryDataList?has_content>

            <#list tableInfo.sqlQueryDataList as data>
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list>) VALUES (<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??>NULL<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>, </#if></#list>);
            </#list>
        </#if>
    </#list>
</#if>