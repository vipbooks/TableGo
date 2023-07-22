<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.batchSearchFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper">
<#if !isNoSqlTable>
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}"/>

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
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.commonFields, paramConfig.customColumnThreshold)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <!-- 分页查询${tableInfo.simpleRemark}列表 -->
    <select id="find${tableInfo.upperCamelCase}List" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DELETE_FLAG = '1'<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFields as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                    <#if fieldInfo.javaType == "Date">
        <if test="condition.${fieldInfo.proName}Begin != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &gt;= ${"#"}{condition.${fieldInfo.proName}Begin}
        </if>
        <if test="condition.${fieldInfo.proName}End != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &lt; ${"#"}{condition.${fieldInfo.proName}End}
        </if>
                    <#else>
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.isStringType> and condition.${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.isStringType && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{condition.${fieldInfo.proName}}, '%')<#else> = ${"#"}{condition.${fieldInfo.proName}}</#if>
        </if>
                    </#if>
                </#if>
            </#list>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list batchSearchFields as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        <if test="condition.${fieldInfo.proName}List != null and condition.${fieldInfo.proName}List.size > 0">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} IN
            <foreach collection="condition.${fieldInfo.proName}List" index="index" item="${fieldInfo.proName}" open="(" separator="," close=")">
                ${"#"}{${fieldInfo.proName}}
            </foreach>
        </if>
                </#if>
            </#list>
        </#list>
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATION_DATE")>
        ORDER BY <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>CREATION_DATE DESC
    </#if>
    </select>

    <!-- 查询${tableInfo.simpleRemark} -->
    <select id="get${tableInfo.upperCamelCase}" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DELETE_FLAG = '1'<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFields as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.isStringType> and condition.${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} = ${"#"}{condition.${fieldInfo.proName}}
        </if>
                </#if>
            </#list>
        </#list>
    </#if>
    </select>
</#if>

</mapper>