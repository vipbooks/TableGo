<#-- 用于生成Oracle的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     Oracle"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
DROP TABLE ${tableInfo.tableName} CASCADE CONSTRAINTS;

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
CREATE TABLE "${tableInfo.tableName}"
(
        <#list tableInfo.fieldInfos as fieldInfo>
${"    \"${fieldInfo.colName}\""?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar")>VARCHAR2(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "decimal")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "numeric")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")><#if fieldInfo.numberPrecision??>NUMBER(${fieldInfo.numberPrecision})<#else>NUMBER</#if><#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>NUMBER(10,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int unsigned")>NUMBER(20,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>NUMBER(3,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>NUMBER(5,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>NUMBER(7,0)<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "bigint")>NUMBER(20,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>NUMBER(5,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>NUMBER(10,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>NUMBER(20,0)<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "datetime")>DATE<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>TIMESTAMP<#else>${fieldInfo.dataTypeStr}</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else><#if StringUtils.equalsIgnoreCase(fieldInfo.defaultValue, "CURRENT_TIMESTAMP")>SYSDATE<#else>${fieldInfo.defaultValue}</#if></#if></#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if pkCount &gt; 0 || ukCount &gt; 0>,<#elseif fieldInfo_has_next>,</#if>
        </#list>
        <#if pkCount &gt; 0>
    CONSTRAINT "PK_${tableInfo.upperTableName}" PRIMARY KEY (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>"${fieldInfo.colName}"<#assign pkCount = pkCount - 1 /><#if pkCount &gt; 0>, </#if></#if></#list>)<#if ukCount &gt; 0>,</#if>
        </#if>
        <#if ukCount &gt; 0>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if !fieldInfo.primaryKey && fieldInfo.unique>
                    <#assign ukCount = ukCount - 1 />
    CONSTRAINT "AK_${fieldInfo.upperColName}_UNIQUE" UNIQUE ("${fieldInfo.colName}")<#if ukCount &gt; 0>,</#if>
                </#if>
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
    </#list>
</#if>