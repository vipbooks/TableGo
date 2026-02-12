<#-- 用于生成导出SQL Server表结构和数据的自定义模板 -->
<#if tableIndex == 1>
/*==============================================================*/
${"/*        Host:     ${dbConfig.ip}"?right_pad(64)}*/
${"/*     Catalog:     ${catalog}"?right_pad(64)}*/
${"/*      Schema:     ${schema}"?right_pad(64)}*/
${"/*    Database:     ${dbConfig.dbName}"?right_pad(64)}*/
${"/*   DbVersion:     ${dbVersion}"?right_pad(64)}*/
${"/*  Created on:     ${dateTime}"?right_pad(64)}*/
<#if tableInfoList?has_content && exportType != 3>
${"/* Table count:     ${tableInfoList?size}"?right_pad(64)}*/
</#if>
/*==============================================================*/

</#if>
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#if exportType != 3>
            <#assign pkIndexList = FtlUtils.tableIndexFilter(tableInfo, "INCLUDE_PK_INDEX") />
            <#assign uniqueIndexList = FtlUtils.tableIndexFilter(tableInfo, "IGNORE_PK&COMPOSITE_UNIQUE_INDEX") />
            <#assign normalIndexList = FtlUtils.tableIndexFilter(tableInfo, "IGNORE_COMPOSITE_NORMAL_INDEX") />
            <#assign uniqueCompositeIndexList = FtlUtils.tableCompositeIndexFilter(tableInfo, "IGNORE_PK_UNIQUE_INDEX") />
            <#assign normalCompositeIndexList = FtlUtils.tableCompositeIndexFilter(tableInfo, "INCLUDE_NORMAL_INDEX") />
/*==============================================================*/
            <#if StringUtils.isNotBlank(tableInfo.remark)>
${"/* Table: ${tableInfo.tableName}(${tableInfo.remark})"?right_pad(62)}*/
            <#else>
${"/* Table: ${tableInfo.tableName}"?right_pad(64)}*/
            </#if>
/*==============================================================*/
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('${tableInfo.tableName}') AND TYPE = 'U') DROP TABLE ${tableInfo.tableName}
GO

CREATE TABLE ${tableInfo.tableName} (
            <#list tableInfo.fieldInfos as fieldInfo>
                <#assign columnSize = fieldInfo.columnSize />
                <#if fieldInfo.isStringType && columnSize &gt; 4000>
                    <#assign columnSize = 4000 />
                <#elseif fieldInfo.isNumericType && columnSize &gt; 60>
                    <#assign columnSize = 20 />
                </#if>
                <#assign newNumberPrecision = FtlUtils.getNewNumberPrecision(fieldInfo, columnSize, fieldInfo.decimalDigits) />
                <#assign newDataTypeStr = FtlUtils.getNewDataTypeStr(fieldInfo, columnSize, fieldInfo.decimalDigits) />
${"    ${fieldInfo.colName}"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>CHAR(${columnSize})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>DECIMAL(${newNumberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>SMALLINT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "integer")>INT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>TINYINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>SMALLINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>TIMESTAMP<#elseif fieldInfo.isDateTimeType>DATETIME<#elseif fieldInfo.isDateType>DATETIME<#else>${newDataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content && !StringUtils.containsAnyIgnoreCase(fieldInfo.defaultValue, "::", "(", ")", "to_date", "to_char", "varchar", "character", "without", "pg_")> DEFAULT <#if fieldInfo.isStringType && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if fieldInfo_has_next || pkIndexList?has_content || uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
            </#list>
            <#if pkIndexList?has_content>
    CONSTRAINT PK_${tableInfo.upperNoAffixTableName} PRIMARY KEY (<#list pkIndexList as index>${index.fieldInfo.colName}<#if index_has_next>, </#if></#list>)<#if uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
            </#if>
            <#if uniqueIndexList?has_content>
                <#list uniqueIndexList as index>
    CONSTRAINT ${index.indexName?upper_case} UNIQUE (${index.fieldInfo.colName})<#if index_has_next || uniqueCompositeIndexList?has_content>,</#if>
                </#list>
            </#if>
            <#if uniqueCompositeIndexList?has_content>
                <#list uniqueCompositeIndexList as index>
    CONSTRAINT ${index.indexInfo.indexName?upper_case} UNIQUE (<#list index.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list>)<#if index_has_next>,</#if>
                </#list>
            </#if>
)
GO

IF EXISTS (SELECT 1 FROM SYS.EXTENDED_PROPERTIES WHERE MAJOR_ID = OBJECT_ID('${tableInfo.tableName}') AND MINOR_ID = 0)
BEGIN
    DECLARE @CURRENTUSER SYSNAME SELECT @CURRENTUSER = USER_NAME()
    EXECUTE SP_DROPEXTENDEDPROPERTY 'MS_Description', 'user', @CURRENTUSER, 'table', '${tableInfo.tableName}' 
END

SELECT @CURRENTUSER = USER_NAME() EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', '${tableInfo.remark}', 'user', @CURRENTUSER, 'table', '${tableInfo.tableName}'
GO

            <#list tableInfo.fieldInfos as fieldInfo>
IF EXISTS(SELECT 1 FROM SYS.EXTENDED_PROPERTIES P WHERE P.MAJOR_ID = OBJECT_ID('${tableInfo.tableName}')
    AND P.MINOR_ID = (SELECT C.COLUMN_ID FROM SYS.COLUMNS C WHERE C.OBJECT_ID = P.MAJOR_ID AND C.NAME = '${fieldInfo.colName}')
)
BEGIN
    DECLARE @CURRENTUSER SYSNAME SELECT @CURRENTUSER = USER_NAME()
    EXECUTE SP_DROPEXTENDEDPROPERTY 'MS_Description', 'user', @CURRENTUSER, 'table', '${tableInfo.tableName}', 'column', '${fieldInfo.colName}'
END

SELECT @CURRENTUSER = USER_NAME() EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', '${fieldInfo.remark}', 'user', @CURRENTUSER, 'table', '${tableInfo.tableName}', 'column', '${fieldInfo.colName}'
GO

            </#list>
            <#if normalIndexList?has_content>
                <#list normalIndexList as index>
/*==============================================================*/
${"/* Index: ${index.indexName?upper_case}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX ${index.indexName?upper_case} ON ${tableInfo.tableName} (${index.fieldInfo.colName} ASC)
GO

                </#list>
            </#if>
            <#if normalCompositeIndexList?has_content>
                <#list normalCompositeIndexList as index>
/*==============================================================*/
${"/* Index: ${index.indexInfo.indexName?upper_case}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX ${index.indexInfo.indexName?upper_case} ON ${tableInfo.tableName} (<#list index.fieldInfos as fieldInfo>${fieldInfo.colName} ASC<#if fieldInfo_has_next>, </#if></#list>);
GO

                </#list>
            </#if>
        </#if>
        <#assign tableDataList = null />
        <#if tableDataMap?has_content && tableDataMap[tableInfo.originalTableName]??>
            <#assign tableDataList = tableDataMap[tableInfo.originalTableName] />
        </#if>
        <#if tableDataList?has_content && (exportType == 1 || exportType == 3)>
            <#if isUseBatchInsert && batchInsertSize &gt; 1 && tableDataList?size &gt; 1>
                <#assign partitionList = FtlUtils.partition(tableDataList, batchInsertSize) />
-- 共插入 ${tableDataList?size} 条数据，分 ${partitionList?size} 组批量插入，每组最大批量插入 ${batchInsertSize} 条
                <#list partitionList as partition>
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES <#list partition as data>(<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??>NULL<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>,</#if></#list>)<#if data_has_next>,</#if></#list>;
                </#list>
            <#else>
-- 共插入 ${tableDataList?size} 条数据
                <#list tableDataList as data>
INSERT INTO ${tableInfo.tableName}(<#list tableInfo.fieldInfos as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></#list>) VALUES (<#list tableInfo.fieldInfos as fieldInfo><#if !data[fieldInfo.originalColName]??>NULL<#elseif fieldInfo.isNumericType>${data[fieldInfo.originalColName]}<#else>'${data[fieldInfo.originalColName]}'</#if><#if fieldInfo_has_next>,</#if></#list>);
                </#list>
            </#if>

        </#if>
    </#list>
</#if>