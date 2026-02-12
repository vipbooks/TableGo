<#-- 用于按字段生成文件功能生成MySQL的简单DDL的自定义模板 -->
/*==============================================================*/
${"/*  DBMS name:     MySQL"?right_pad(64)}*/
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
${"    `${fieldInfo.colName}`"?right_pad(30)} VARCHAR(${fieldInfo.length}) COMMENT '${fieldInfo.remark}'<#if fieldInfo_has_next>,</#if>
        </#list>
    PRIMARY KEY (`${tableInfo.pkColName}`)
) COMMENT '${tableInfo.remark}';

    </#list>
</#if>