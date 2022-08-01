<#-- 导出表数据并生成逐条插入数据的标准SQL -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.fieldInfos?has_content && tableInfo.sqlQueryDataList?has_content>
-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
-- TRUNCATE TABLE ${tableInfo.tableName};
            <#list tableInfo.sqlQueryDataList as data>
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES (<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??>NULL<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>,</#if></#list>);
            </#list>

        </#if>
    </#list>
</#if>