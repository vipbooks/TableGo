<#-- 用于生成SQL Server的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     SQL Server"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('${tableInfo.tableName}') AND TYPE = 'U') DROP TABLE ${tableInfo.tableName}
GO

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
CREATE TABLE ${tableInfo.tableName} (
        <#list tableInfo.fieldInfos as fieldInfo>
${"    ${fieldInfo.colName}"?right_pad(30)} <#if StringUtils.equalsIgnoreCase(fieldInfo.typeName, "varchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nvarchar2")>VARCHAR(${fieldInfo.length})<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "nchar")>CHAR(${fieldInfo.length})<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "number")><#if fieldInfo.numberPrecision??>DECIMAL(${fieldInfo.numberPrecision})<#else>DECIMAL</#if><#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "smallint")>SMALLINT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "mediumint")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "integer")>INT<#elseif StringUtils.containsIgnoreCase(fieldInfo.typeName, "tinyint")>TINYINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int2")>SMALLINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int4")>INT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "int8")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "long")>BIGINT<#elseif StringUtils.equalsIgnoreCase(fieldInfo.typeName, "date")>DATETIME<#else>${fieldInfo.dataTypeStr}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if pkCount &gt; 0 || ukCount &gt; 0>,<#elseif fieldInfo_has_next>,</#if>
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
    </#list>
</#if>