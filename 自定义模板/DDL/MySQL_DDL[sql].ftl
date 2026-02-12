<#-- 用于生成MySQL的DDL的自定义模板 -->
/*==============================================================*/
${"/*  DBMS name:     MySQL"?right_pad(64)}*/
${"/*    Catalog:     ${catalog}"?right_pad(64)}*/
${"/*     Schema:     ${schema}"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
-- ${tableInfo.remark}
DROP TABLE IF EXISTS `${tableInfo.tableName}`;

    </#list>
</#if>
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#assign pkIndexList = FtlUtils.tableIndexFilter(tableInfo, "INCLUDE_PK_INDEX") />
        <#assign indexList = FtlUtils.tableIndexFilter(tableInfo, "IGNORE_PK&COMPOSITE_INDEX") />
        <#assign compositeIndexList = FtlUtils.tableCompositeIndexFilter(tableInfo, "IGNORE_PK_INDEX") />
/*==============================================================*/
<#if StringUtils.isNotBlank(tableInfo.remark)>
${"/* Table: ${tableInfo.tableName}(${tableInfo.remark})"?right_pad(62)}*/
<#else>
${"/* Table: ${tableInfo.tableName}"?right_pad(64)}*/
</#if>
/*==============================================================*/
CREATE TABLE `${tableInfo.tableName}`
(
        <#list tableInfo.fieldInfos as fieldInfo>
            <#assign columnSize = fieldInfo.columnSize />
            <#if fieldInfo.isStringType && columnSize &gt; 4000>
                <#assign columnSize = 4000 />
            <#elseif fieldInfo.isNumericType && columnSize &gt; 60>
                <#assign columnSize = 20 />
            </#if>
            <#assign newNumberPrecision = FtlUtils.getNewNumberPrecision(fieldInfo, columnSize, fieldInfo.decimalDigits) />
            <#assign newDataTypeStr = FtlUtils.getNewDataTypeStr(fieldInfo, columnSize, fieldInfo.decimalDigits) />
${"    `${fieldInfo.colName}`"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>VARCHAR(${columnSize})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>CHAR(${columnSize})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>DECIMAL(${newNumberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>SMALLINT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>MEDIUMINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>SMALLINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "float")>FLOAT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")>DOUBLE<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>DATETIME<#if !fieldInfo.isNotNull> NULL</#if><#elseif fieldInfo.isDateTimeType>DATETIME<#elseif fieldInfo.isDateType>DATE<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "clob")>LONGTEXT<#else>${newDataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content && !StringUtils.containsAnyIgnoreCase(fieldInfo.defaultValue, "::", "(", ")", "to_date", "to_char", "varchar", "character", "without", "pg_")> DEFAULT <#if fieldInfo.isStringType && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else><#if StringUtils.equalsIgnoreCase(fieldInfo.defaultValue, "SYSDATE")>CURRENT_TIMESTAMP<#else>${fieldInfo.defaultValue}</#if></#if></#if><#if fieldInfo.remark?has_content> COMMENT '${fieldInfo.remark}'</#if><#if fieldInfo_has_next || pkIndexList?has_content || indexList?has_content || compositeIndexList?has_content>,</#if>
        </#list>
        <#if pkIndexList?has_content>
    PRIMARY KEY (<#list pkIndexList as index>`${index.fieldInfo.colName}`<#if index_has_next>, </#if></#list>)<#if indexList?has_content || compositeIndexList?has_content>,</#if>
        </#if>
        <#if indexList?has_content>
            <#list indexList as index>
    <#if index.unique>UNIQUE </#if>KEY `${index.indexName}` (`${index.fieldInfo.colName}`)<#if index_has_next || compositeIndexList?has_content>,</#if>
            </#list>
        </#if>
        <#if compositeIndexList?has_content>
            <#list compositeIndexList as index>
    <#if index.indexInfo.unique>UNIQUE </#if>KEY `${index.indexInfo.indexName}` (<#list index.fieldInfos as fieldInfo>`${fieldInfo.colName}`<#if fieldInfo_has_next>, </#if></#list>)<#if index_has_next>,</#if>
            </#list>
        </#if>
)<#if tableInfo.remark?has_content> COMMENT '${tableInfo.remark}'</#if>;

    </#list>
</#if>