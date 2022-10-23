<#-- 用于生成PostgreSQL的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     PostgreSQL"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
<#if tableInfo.pkColName?has_content>DROP INDEX ${tableInfo.lowerTableName}_pk;</#if>
DROP TABLE ${tableInfo.tableName};

    </#list>
</#if>
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
        <#assign pkCount = 0 />
        <#assign ukCount = 0 />
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if fieldInfo.primaryKey>
                <#assign pkCount = pkCount + 1 />
            <#elseif fieldInfo.unique>
                <#assign ukCount = ukCount + 1 />
            </#if>
        </#list>
        <#assign pkCount2 = pkCount />
/*==============================================================*/
<#if StringUtils.isNotBlank(tableInfo.remark)>
${"/* Table: ${tableInfo.tableName}(${tableInfo.remark})"?right_pad(62)}*/
<#else>
${"/* Table: ${tableInfo.tableName}"?right_pad(64)}*/
</#if>
/*==============================================================*/
CREATE TABLE ${tableInfo.tableName}
(
        <#list tableInfo.fieldInfos as fieldInfo>
${"    ${fieldInfo.colName}"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>varchar(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "nvarchar")>varchar(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>CHAR(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>decimal(${fieldInfo.numberPrecision})<#else>decimal</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")><#if fieldInfo.numberPrecision??>decimal(${fieldInfo.numberPrecision})<#else>decimal</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>int2<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>int2<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>int4<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>int4<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int unsigned")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "integer")>int4<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "bigint")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>int8<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "datetime")>date<#else>${fieldInfo.dataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if pkCount &gt; 0 || ukCount &gt; 0>,<#elseif fieldInfo_has_next>,</#if>
        </#list>
        <#if pkCount &gt; 0>
    CONSTRAINT pk_${tableInfo.lowerTableName} PRIMARY KEY (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>${fieldInfo.colName}<#assign pkCount = pkCount - 1 /><#if pkCount &gt; 0>, </#if></#if></#list>)<#if ukCount &gt; 0>,</#if>
        </#if>
        <#if ukCount &gt; 0>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if !fieldInfo.primaryKey && fieldInfo.unique>
                    <#assign ukCount = ukCount - 1 />
    CONSTRAINT ak_${fieldInfo.lowerColName}_unique UNIQUE (${fieldInfo.colName})<#if ukCount &gt; 0>,</#if>
                </#if>
            </#list>
        </#if>
);

        <#if tableInfo.remark?has_content>
COMMENT ON TABLE ${tableInfo.tableName} IS '${tableInfo.remark}';

        </#if>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if fieldInfo.remark?has_content>
COMMENT ON COLUMN ${tableInfo.tableName}.${fieldInfo.colName} IS '${fieldInfo.remark}';

            </#if>
        </#list>
        <#if tableInfo.pkColName?has_content>
/*==============================================================*/
${"/* Index: ${tableInfo.lowerTableName}_pk"?right_pad(64)}*/
/*==============================================================*/
CREATE UNIQUE INDEX ${tableInfo.lowerTableName}_pk ON ${tableInfo.tableName} (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>${fieldInfo.colName}<#assign pkCount2 = pkCount2 - 1 /></#if><#if pkCount2 &gt; 0>, </#if></#list>);

        </#if>
    </#list>
</#if>