<#-- 用于生成MyBatis的Mapper.xml配置文件 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFeilds) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.moduleName}.${tableInfo.lowerCamelCase}">
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="entity.${jsonParam.moduleName}.${tableInfo.upperCamelCase}Entity"></resultMap>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldExistedAny(tableInfo, jsonParam.excludeFields)>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.excludeFields, paramConfig.customColumnThreshold)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <!-- 根据条件参数查询数据列表 -->
    <select id="find${tableInfo.upperCamelCase}ByCondition" resultMap="${tableInfo.lowerCamelCase}Map" parameterType="map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE 1 = 1
    <#if searchFeilds?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFeilds as fieldName>
                <#if StringUtils.equalsIgnoreCase(fieldInfo.colName, fieldName)>
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
    <delete id="delete${tableInfo.upperCamelCase}ByIds" parameterType="list">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="list" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
</mapper>