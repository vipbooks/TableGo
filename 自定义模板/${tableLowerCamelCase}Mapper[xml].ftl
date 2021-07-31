<#-- 用于生成MyBatis的Mapper.xml配置文件 -->
<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(jsonParam.searchFeilds, tableInfo.tableName) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper">
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}">
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.primaryKey>
        <id column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="${fieldInfo.typeName}" />
        <#elseif fieldInfo.javaType == "Date">
        <result column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="TIMESTAMP" />
        <#elseif fieldInfo.javaType == "Integer">
        <result column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="INTEGER" />
        <#else>
        <result column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="${fieldInfo.typeName}" />
        </#if>
    </#list>
    </resultMap>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 2)} -->
    </#if>
    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldExistedAny(tableInfo, "CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, DELETE_FLAG")>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldPagingIgnore(tableInfo.pagingFieldInfos, "CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, DELETE_FLAG")>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 2)} -->
    </#if>

    <!-- 根据条件参数查询数据列表 -->
    <select id="findByCondition" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE 1 = 1
    <#if searchFeilds?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFeilds as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        <if test="${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and ${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.javaType == "String" && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{${fieldInfo.proName}}, '%')<#else> = ${"#"}{${fieldInfo.proName}}</#if>
        </if>
                </#if>
            </#list>
        </#list>
    <#else>
    <#assign loopCount = 0>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if !fieldInfo.primaryKey>
                <#assign loopCount = loopCount + 1>
        <if test="${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and ${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.javaType == "String" && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{${fieldInfo.proName}}, '%')<#else> = ${"#"}{${fieldInfo.proName}}</#if>
        </if>
                <#if !isAllConditionSql && loopCount == 3>
                    <#break>
                </#if>
            </#if>
        </#list>
    </#if>
    </select>

    <!-- 根据主键批量删除数据 -->
    <delete id="deleteByIds" parameterType="list">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="list" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
</mapper>