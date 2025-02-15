<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.batchSearchFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.remark}(${tableInfo.tableName})", tableInfo.tableName)} -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.${tableInfo.upperCamelCase}Mapper">
<#if !isNoSqlTable>
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase}"/>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.commonFields, paramConfig.fieldGroup)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <!-- 查询${tableInfo.simpleRemark}列表 -->
    <select id="find${tableInfo.upperCamelCase}List" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "IS_DELETED")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>IS_DELETED = 0<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
        <if test="condition.${fieldInfo.proName}Begin != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &gt;= ${"#"}{condition.${fieldInfo.proName}Begin}
        </if>
        <if test="condition.${fieldInfo.proName}End != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &lt;<#if !fieldInfo.isDateTimeType>=</#if> ${"#"}{condition.${fieldInfo.proName}End}
        </if>
            <#else>
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.isStringType> and condition.${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.isStringType && !FtlUtils.strContainsAny(fieldInfo.colName, "_id") && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{condition.${fieldInfo.proName}}, '%')<#else> = ${"#"}{condition.${fieldInfo.proName}}</#if>
        </if>
            </#if>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>
        <if test="condition.${fieldInfo.proName}List != null and condition.${fieldInfo.proName}List.size > 0">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} IN
            <foreach collection="condition.${fieldInfo.proName}List" index="index" item="${fieldInfo.proName}" open="(" separator="," close=")">
                ${"#"}{${fieldInfo.proName}}
            </foreach>
        </if>
        </#list>
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATED_TIME")>
        ORDER BY <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>CREATED_TIME DESC
    </#if>
    </select>
</#if>

</mapper>