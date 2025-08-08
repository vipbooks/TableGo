<#-- 用于生成Oracle的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     Oracle"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
-- ${tableInfo.remark}
DROP TABLE ${tableInfo.tableName} CASCADE CONSTRAINTS;

    </#list>
</#if>
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
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
CREATE TABLE "${tableInfo.tableName}"
(
        <#list tableInfo.fieldInfos as fieldInfo>
${"    \"${fieldInfo.colName}\""?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar")>VARCHAR2(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "decimal")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "numeric")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>NUMBER(10,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int unsigned")>NUMBER(20,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>NUMBER(3,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>NUMBER(5,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>NUMBER(7,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "bigint")>NUMBER(20,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>NUMBER(5,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>NUMBER(10,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>NUMBER(20,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>TIMESTAMP<#elseif fieldInfo.isDateTimeType>DATE<#elseif fieldInfo.isDateType>DATE<#else>${fieldInfo.dataTypeStr?upper_case}</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else><#if StringUtils.equalsIgnoreCase(fieldInfo.defaultValue, "CURRENT_TIMESTAMP")>SYSDATE<#else>${fieldInfo.defaultValue}</#if></#if></#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo_has_next || pkIndexList?has_content || uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
        </#list>
        <#if pkIndexList?has_content>
    CONSTRAINT "PK_${tableInfo.upperNoAffixTableName}" PRIMARY KEY (<#list pkIndexList as index>"${index.fieldInfo.colName}"<#if index_has_next>, </#if></#list>)<#if uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
        </#if>
        <#if uniqueIndexList?has_content>
            <#list uniqueIndexList as index>
    CONSTRAINT "${index.indexName?upper_case}" UNIQUE ("${index.fieldInfo.colName}")<#if index_has_next || uniqueCompositeIndexList?has_content>,</#if>
            </#list>
        </#if>
        <#if uniqueCompositeIndexList?has_content>
            <#list uniqueCompositeIndexList as index>
    CONSTRAINT "${index.indexInfo.indexName?upper_case}" UNIQUE (<#list index.fieldInfos as fieldInfo>"${fieldInfo.colName}"<#if fieldInfo_has_next>, </#if></#list>)<#if index_has_next>,</#if>
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
${"/* Index: ${index.indexName?upper_case}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX "${index.indexName?upper_case}" ON ${tableInfo.tableName} (${index.fieldInfo.colName} ASC);

            </#list>
        </#if>
        <#if normalCompositeIndexList?has_content>
            <#list normalCompositeIndexList as index>
/*==============================================================*/
${"/* Index: ${index.indexInfo.indexName?upper_case}"?right_pad(64)}*/
/*==============================================================*/
CREATE INDEX "${index.indexInfo.indexName?upper_case}" ON ${tableInfo.tableName} (<#list index.fieldInfos as fieldInfo>${fieldInfo.colName} ASC<#if fieldInfo_has_next>, </#if></#list>);

            </#list>
        </#if>
    </#list>
</#if>