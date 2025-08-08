<#-- 用于读取Excel获取表字段变更信息，与数据库已有表进行比较，把旧字段更新为新字段，生成GaussDB的DDL文件 -->
/*==============================================================*/
${"/*  DBMS name:     GaussDB"?right_pad(64)}*/
${"/* Created on:     ${dateTime}"?right_pad(64)}*/
/*==============================================================*/

<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
-- ${tableInfo.remark}
DROP TABLE IF EXISTS ${tableInfo.tableName};

    </#list>
</#if>
<#if tableInfoList?has_content && excelDataList?has_content>
    <#list tableInfoList as tableInfo>
        <#assign pkIndexList = FtlUtils.tableIndexFilter(tableInfo, "INCLUDE_PK_INDEX") />
        <#assign idExisted = false />
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
            <#list excelDataList as excelData>
                <#if FtlUtils.tableEquals(tableInfo, excelData.table_code)>
                    <#if fieldInfo.primaryKey && !idExisted>
                        <#assign idExisted = true />
${"    ${fieldInfo.colName}"?right_pad(30)} ${fieldInfo.dataTypeStr?lower_case} NOT NULL,
                    <#elseif FtlUtils.fieldEquals(fieldInfo, excelData.旧字段代码)>
${"    ${excelData.新字段代码}"?right_pad(30)} <#if fieldInfo.columnSize &gt; 10000>${fieldInfo.typeName}<#else>${fieldInfo.dataTypeStr?lower_case}</#if><#if fieldInfo.isNotNull> NOT NULL</#if><#if fieldInfo.defaultValue?has_content> DEFAULT <#if fieldInfo.javaType == "String" && !fieldInfo.defaultValue?contains("'")>'${fieldInfo.defaultValue}'<#else>${fieldInfo.defaultValue}</#if></#if><#if excelData_has_next || pkIndexList?has_content>,</#if>
                    </#if>
                </#if>
            </#list>
        </#list>
        <#if pkIndexList?has_content>
    CONSTRAINT pk_${tableInfo.lowerNoAffixTableName} PRIMARY KEY (<#list pkIndexList as index>${index.fieldInfo.colName}<#if index_has_next>, </#if></#list>)<#if uniqueIndexList?has_content || uniqueCompositeIndexList?has_content>,</#if>
        </#if>
);

        <#if tableInfo.remark?has_content>
COMMENT ON TABLE ${tableInfo.tableName} IS '${tableInfo.remark}';

        </#if>
        <#assign idExisted = false />
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list excelDataList as excelData>
                <#if FtlUtils.tableEquals(tableInfo, excelData.table_code)>
                    <#if fieldInfo.primaryKey && !idExisted>
                        <#assign idExisted = true />
COMMENT ON COLUMN ${tableInfo.tableName}.${fieldInfo.colName} IS '${fieldInfo.remark}';

                    <#elseif FtlUtils.fieldEquals(fieldInfo, excelData.旧字段代码)>
COMMENT ON COLUMN ${tableInfo.tableName}.${excelData.新字段代码} IS '${FtlUtils.emptyToDefault(fieldInfo.remark, excelData.中文全称注解)}';

                    </#if>
                </#if>
            </#list>
        </#list>
        <#assign absentFieldList = FtlUtils.createEmptyList() />
        <#list tableInfo.fieldInfos as fieldInfo>
            <#assign fieldExisted = false />
            <#list excelDataList as excelData>
                <#if FtlUtils.tableEquals(tableInfo, excelData.table_code)>
                    <#if fieldInfo.primaryKey><#continue/></#if>
                    <#if FtlUtils.fieldEquals(fieldInfo, excelData.旧字段代码)>
                        <#assign fieldExisted = true />
                    </#if>
                </#if>
            </#list>
            <#if !fieldExisted && !fieldInfo.primaryKey>
                <#assign absentFieldList = FtlUtils.listAddElement(absentFieldList, fieldInfo.colName) />
            </#if>
        </#list>
        <#if absentFieldList?has_content>
-- 原表中未匹配到的字段：${FtlUtils.collJoin(absentFieldList, "、")}

        </#if>
        <#assign absentFieldList = FtlUtils.createEmptyList() />
        <#list excelDataList as excelData>
            <#if FtlUtils.tableEquals(tableInfo, excelData.table_code)>
                <#assign fieldExisted = false />
                <#list tableInfo.fieldInfos as fieldInfo>
                    <#if fieldInfo.primaryKey><#continue/></#if>
                    <#if FtlUtils.fieldEquals(fieldInfo, excelData.旧字段代码)>
                        <#assign fieldExisted = true />
                    </#if>
                </#list>
                <#if !fieldExisted && !fieldInfo.primaryKey>
                    <#assign absentFieldList = FtlUtils.listAddElement(absentFieldList, excelData.新字段代码) />
                </#if>
            </#if>
        </#list>
        <#if absentFieldList?has_content>
-- 在Excel中未匹配到的新字段：${FtlUtils.collJoin(absentFieldList, "、")}

        </#if>
    </#list>
</#if>