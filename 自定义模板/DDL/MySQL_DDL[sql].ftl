<#-- 用于生成MySQL的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     MySQL"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
DROP TABLE IF EXISTS ${tableInfo.tableName};

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
CREATE TABLE `${tableInfo.tableName}`
(
        <#list tableInfo.fieldInfos as fieldInfo>
${"    `${fieldInfo.colName}`"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>CHAR(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>DECIMAL(${fieldInfo.numberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>SMALLINT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>MEDIUMINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>SMALLINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "date")>DATETIME<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "timestamp")>TIMESTAMP<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "float")>FLOAT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "double")>DOUBLE<#else>${fieldInfo.dataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else><#if StringUtils.equalsIgnoreCase(fieldInfo.defaultValue, "SYSDATE")>CURRENT_TIMESTAMP<#else>${fieldInfo.defaultValue}</#if></#if></#if><#if fieldInfo.remark?has_content> COMMENT '${fieldInfo.remark}'</#if><#if pkCount &gt; 0 || ukCount &gt; 0>,<#elseif fieldInfo_has_next>,</#if>
        </#list>
        <#if pkCount &gt; 0>
    PRIMARY KEY (<#list tableInfo.fieldInfos as fieldInfo><#if fieldInfo.primaryKey>`${fieldInfo.colName}`<#assign pkCount = pkCount - 1 /><#if pkCount &gt; 0>, </#if></#if></#list>)<#if ukCount &gt; 0>,</#if>
        </#if>
        <#if ukCount &gt; 0>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if !fieldInfo.primaryKey && fieldInfo.unique>
                    <#assign ukCount = ukCount - 1 />
    UNIQUE KEY `AK_${fieldInfo.upperColName}_UNIQUE` (`${fieldInfo.colName}`)<#if ukCount &gt; 0>,</#if>
                </#if>
            </#list>
        </#if>
)<#if tableInfo.remark?has_content> COMMENT '${tableInfo.remark}'</#if>;

    </#list>
</#if>