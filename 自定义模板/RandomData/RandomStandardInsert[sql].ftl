<#-- 根据数据库表结构生成插入随机数据的标准SQL -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.fieldInfos?has_content>
-- ${tableInfo.remark}
-- TRUNCATE TABLE ${tableInfo.tableName};
            <#list 1..10 as i>
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>'<#if tableInfo.pkColumnSize gte 32>${IdWorker.get32UUID()}<#elseif fieldInfo.columnSize gte 19>${IdWorker.getId()}<#else>${FtlUtils.getRandomString19(6)}</#if>'<#elseif fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType>'<#if fieldInfo.isDateTimeType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${DateUtils.getRandomDate("2000-01-01")}</#if>'<#elseif fieldInfo.isTimestampType>'${DateUtils.getRandomDateTime("2000-01-01")}'<#else>'${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}'</#if><#if fieldInfo_has_next>,</#if></#list>);
            </#list>

        </#if>
    </#list>
</#if>