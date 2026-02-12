<#-- 用于生成导出GaussDB表结构和数据的自定义模板 -->
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
DROP TABLE IF EXISTS "${tableInfo.tableName}";
CREATE TABLE "${tableInfo.tableName}"
(
            <#list tableInfo.fieldInfos as fieldInfo>
                <#assign columnSize = fieldInfo.columnSize />
                <#if fieldInfo.isStringType && columnSize &gt; 4000>
                    <#assign columnSize = 4000 />
                <#elseif fieldInfo.isNumericType && columnSize &gt; 60>
                    <#assign columnSize = 20 />
                </#if>
                <#assign newNumberPrecision = FtlUtils.getNewNumberPrecision(fieldInfo, columnSize, fieldInfo.decimalDigits) />
                <#assign newDataTypeStr = FtlUtils.getNewDataTypeStr(fieldInfo, columnSize, fieldInfo.decimalDigits, false) />
${"    \"${fieldInfo.colName}\""?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>varchar2(${columnSize})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "nvarchar")>nvarchar(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>nvarchar2(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>char(${columnSize})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>decimal(${newNumberPrecision})<#else>decimal</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")><#if fieldInfo.numberPrecision??>decimal(${newNumberPrecision})<#else>decimal</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>int2<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>int2<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>int4<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>int4<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int unsigned")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "integer")>int4<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "bigint")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>timestamp<#elseif fieldInfo.isDateTimeType>timestamp<#elseif fieldInfo.isDateType>date<#else>${newDataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.isStringType && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if fieldInfo_has_next || pkIndexList?has_content || uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
            </#list>
            <#if pkIndexList?has_content>
    CONSTRAINT pk_${tableInfo.lowerNoAffixTableName} PRIMARY KEY (<#list pkIndexList as index>"${index.fieldInfo.colName}"<#if index_has_next>, </#if></#list>)<#if uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
            </#if>
            <#if uniqueIndexList?has_content>
                <#list uniqueIndexList as index>
    CONSTRAINT ${index.indexName} UNIQUE ("${index.fieldInfo.colName}")<#if index_has_next || uniqueCompositeIndexList?has_content>,</#if>
                </#list>
            </#if>
            <#if uniqueCompositeIndexList?has_content>
                <#list uniqueCompositeIndexList as index>
    CONSTRAINT ${index.indexInfo.indexName} UNIQUE (<#list index.fieldInfos as fieldInfo>"${fieldInfo.colName}"<#if fieldInfo_has_next>, </#if></#list>)<#if index_has_next>,</#if>
                </#list>
            </#if>
);

            <#if tableInfo.remark?has_content>
COMMENT ON TABLE "${tableInfo.tableName}" IS '${tableInfo.remark}';

            </#if>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if fieldInfo.remark?has_content>
COMMENT ON COLUMN "${tableInfo.tableName}"."${fieldInfo.colName}" IS '${fieldInfo.remark}';

                </#if>
            </#list>
            <#if normalIndexList?has_content>
                <#list normalIndexList as index>
/*==============================================================*/
${"/* Index: ${index.indexName}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX ${index.indexName} ON "${tableInfo.tableName}" ("${index.fieldInfo.colName}");

                </#list>
            </#if>
            <#if normalCompositeIndexList?has_content>
                <#list normalCompositeIndexList as index>
/*==============================================================*/
${"/* Index: ${index.indexInfo.indexName}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX ${index.indexInfo.indexName} ON "${tableInfo.tableName}" (<#list index.fieldInfos as fieldInfo>"${fieldInfo.colName}"<#if fieldInfo_has_next>, </#if></#list>);

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