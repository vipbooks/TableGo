<#-- 用于生成DB2的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     DB2"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
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
${"    ${fieldInfo.colName}"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>DECIMAL(${fieldInfo.numberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")><#if fieldInfo.numberPrecision??>DECIMAL(${fieldInfo.numberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>DECIMAL(3,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>SMALLINT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>DECIMAL(7,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "bigint")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>SMALLINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "datetime")>DATE<#else>${fieldInfo.dataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if pkCount &gt; 0 || ukCount &gt; 0>,<#elseif fieldInfo_has_next>,</#if>
        </#list>
        <#if pkCount &gt; 0>
    CONSTRAINT PK_${tableInfo.upperTableName} PRIMARY KEY (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>${fieldInfo.colName}<#assign pkCount = pkCount - 1 /><#if pkCount &gt; 0>, </#if></#if></#list>)<#if ukCount &gt; 0>,</#if>
        </#if>
        <#if ukCount &gt; 0>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if !fieldInfo.primaryKey && fieldInfo.unique>
                    <#assign ukCount = ukCount - 1 />
    CONSTRAINT AK_${fieldInfo.upperColName}_UNIQUE UNIQUE (${fieldInfo.colName})<#if ukCount &gt; 0>,</#if>
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
    </#list>
</#if>