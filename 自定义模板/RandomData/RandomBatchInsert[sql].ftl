<#-- 根据数据库表结构生成批量插入随机数据的SQL -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.fieldInfos?has_content>
-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
-- TRUNCATE TABLE ${tableInfo.tableName};
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES <#list 1..10 as i>(<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey><#if dbType=="mysql" || dbType=="mariadb">UUID()<#elseif dbType=="oracle">SYS_GUID()<#elseif dbType=="mssql">NEWID()<#elseif dbType=="postgresql">UUID_GENERATE_V4()<#elseif dbType=="db2">CONCAT(HEX(RAND()),HEX(RAND()))</#if><#elseif fieldInfo.isNumericType>${RandomStringUtils.randomNumeric(fieldInfo.columnSize)}<#elseif fieldInfo.javaType=="Date"><#if dbType=="oracle">SYSDATE<#elseif dbType=="mssql">GETDATE()<#else>NOW()</#if><#else>'${RandomStringUtils.randomAlphanumeric(((fieldInfo.columnSize>50)?string(50,fieldInfo.columnSize))?number)}'</#if><#if fieldInfo_has_next>,</#if></#list>)<#if i_has_next>,</#if></#list>;

        </#if>
    </#list>
</#if>