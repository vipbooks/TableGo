<#-- 导出表数据并生成批量插入数据的SQL -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.fieldInfos?has_content && tableInfo.sqlQueryDataList?has_content>
-- ${tableInfo.remark}
-- TRUNCATE TABLE ${tableInfo.tableName};
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES <#list tableInfo.sqlQueryDataList as data>(<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??>NULL<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>,</#if></#list>)<#if data_has_next>,</#if></#list>;

        </#if>
    </#list>
</#if>