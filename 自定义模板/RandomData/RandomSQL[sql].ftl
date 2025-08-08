<#-- 生成多个表的随机SQL，可用于生成CRUD的随机数据SQL做数据库测试 -->
<#assign buildCount = 5 />
<#assign randomTableList = FtlUtils.getRandomList(tableInfoList, buildCount) />
<#if randomTableList?has_content>
    <#assign pkValueMap = FtlUtils.createEmptyMap() />
    <#list randomTableList as tableInfo>
        <#assign pkValueList = FtlUtils.createEmptyList() />
        <#list 1..buildCount as i>
            <#if tableInfo.pkColumnSize gte 32>
                <#assign pkValueList = FtlUtils.listAddElement(pkValueList, IdWorker.get32UUID()) />
            <#elseif tableInfo.pkColumnSize gte 19>
                <#assign pkValueList = FtlUtils.listAddElement(pkValueList, IdWorker.getId()) />
            <#else>
                <#assign pkValueList = FtlUtils.listAddElement(pkValueList, FtlUtils.getRandomString19(6)) />
            </#if>
            <#assign pkValueMap = FtlUtils.mapAddElement(pkValueMap, tableInfo.tableName, pkValueList) />
        </#list>
    </#list>
/** 插入数据SQL */
    <#list randomTableList as tableInfo>
-- ${tableInfo.remark}
-- TRUNCATE TABLE ${tableInfo.tableName};
        <#assign pkValueList = pkValueMap[tableInfo.tableName] />
        <#assign fieldList = FtlUtils.tableFieldFilter(tableInfo.allFieldInfos, "INCLUDE_NOT_NULL") />
        <#if !fieldList?has_content>
            <#assign fieldList = FtlUtils.getRandomList(tableInfo.allFieldInfos, buildCount) />
        </#if>
        <#if !fieldList?has_content><#continue></#if>
        <#list 1..buildCount as i>
INSERT INTO ${tableInfo.tableName}(<#list fieldList as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES (<#list fieldList as fieldInfo><#if fieldInfo.primaryKey>'${pkValueList[i-1]}'<#elseif fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType><#if dbType=="oracle">SYSDATE<#elseif dbType=="mssql">GETDATE()<#else>NOW()</#if><#else>'${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}'</#if><#if fieldInfo_has_next>,</#if></#list>);
        </#list>
    </#list>

/** 修改数据SQL */
    <#list randomTableList as tableInfo>
-- ${tableInfo.remark}
        <#assign pkValueList = pkValueMap[tableInfo.tableName] />
        <#list 1..buildCount as i>
            <#assign fieldRandomCount = FtlUtils.getRandomInt(1, tableInfo.allFieldInfos?size) />
            <#assign fieldList = FtlUtils.tableFieldFilter(tableInfo.allFieldInfos, "IGNORE_PK") />
            <#assign fieldList = FtlUtils.getRandomList(fieldList, fieldRandomCount) />
            <#if !fieldList?has_content><#continue></#if>
UPDATE ${tableInfo.tableName} SET <#list fieldList as fieldInfo>${fieldInfo.colName}=<#if fieldInfo.isNumericType><#if fieldInfo.columnSize lt 4>${FtlUtils.getRandomString19(1)}<#else>${FtlUtils.getRandomString19(fieldInfo.columnSize-3)}</#if><#elseif fieldInfo.isDateType>'<#if fieldInfo.isDateTimeType>${DateUtils.getRandomDateTime("2000-01-01")}<#else>${DateUtils.getRandomDate("2000-01-01")}</#if>'<#elseif fieldInfo.isTimestampType>'${DateUtils.getRandomDateTime("2000-01-01")}'<#else>'${FtlUtils.getRandomString(((fieldInfo.columnSize>6)?string(6,fieldInfo.columnSize))?number)}'</#if><#if fieldInfo_has_next>,</#if></#list> WHERE ${tableInfo.pkColName}='${pkValueList[i-1]}';
        </#list>
    </#list>

/** 查询数据SQL */
    <#list randomTableList as tableInfo>
-- ${tableInfo.remark}
        <#assign pkValueList = pkValueMap[tableInfo.tableName] />
        <#list 1..buildCount as i>
            <#assign fieldRandomCount = FtlUtils.getRandomInt(1, tableInfo.allFieldInfos?size) />
            <#assign fieldList = FtlUtils.tableFieldFilter(tableInfo.allFieldInfos, "IGNORE_PK") />
            <#assign fieldList = FtlUtils.getRandomList(fieldList, fieldRandomCount) />
            <#assign idRandomCount = FtlUtils.getRandomInt(1, pkValueList?size) />
            <#assign idList = FtlUtils.getRandomList(pkValueList, idRandomCount) />
            <#if !fieldList?has_content || !idList?has_content><#continue></#if>
SELECT <#list fieldList as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list> FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN(<#list idList as id>'${id}'<#if id_has_next>,</#if></#list>);
        </#list>
    </#list>

/** 删除数据SQL */
    <#list randomTableList as tableInfo>
-- ${tableInfo.remark}
        <#assign pkValueList = pkValueMap[tableInfo.tableName] />
        <#list 1..buildCount as i>
DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName}='${pkValueList[i-1]}';
        </#list>
    </#list>
</#if>
