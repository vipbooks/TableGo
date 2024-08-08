<#-- 根据数据库表结构生成批量插入随机数据的SQL -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.fieldInfos?has_content>
-- ${tableInfo.remark}
-- TRUNCATE TABLE ${tableInfo.tableName};
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES
    <#list 1..10 as i>
    (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>'<#if tableInfo.pkColumnSize gte 32>${IdWorker.get32UUID()}<#elseif fieldInfo.columnSize gte 19>${IdWorker.getId()}<#else>${FtlUtils.getRandomString19(6)}</#if>'<#elseif fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType>'<#if fieldInfo.isDateTimeType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${DateUtils.getRandomDate("2000-01-01")}</#if>'<#else>'${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}'</#if><#if fieldInfo_has_next>,</#if></#list>)<#if i_has_next>,<#else>;</#if>
    </#list>

        </#if>
    </#list>
</#if>