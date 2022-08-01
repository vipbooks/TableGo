<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 如果配置的查询字段为空则取表字段的前几个字段 -->
<#if !searchFields?has_content><#assign searchFields = FtlUtils.subListContainsFilter(tableInfo.fieldNameList, 0, 2, "ID") /></#if>
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.basePackagePath}.${jsonParam.moduleName}.mapper.${tableInfo.upperCamelCase}Mapper">
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${tableInfo.upperCamelCase}">
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.primaryKey>
        ${"<id"?right_pad(7)} ${"column=\"${fieldInfo.colName}\""?right_pad(30)} property="${fieldInfo.lowerCamelCase}" />
        <#else>
        <result ${"column=\"${fieldInfo.colName}\""?right_pad(30)} property="${fieldInfo.lowerCamelCase}" />
        </#if>
    </#list>
    </resultMap>

    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.commonFields, paramConfig.customColumnThreshold)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <!-- 分页查询${tableInfo.simpleRemark}列表 -->
    <select id="select${tableInfo.upperCamelCase}List" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DEL_FLAG = '0'<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFields as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
        <if test="${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and ${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.javaType == "String" && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{${fieldInfo.proName}}, '%')<#else> = ${"#"}{${fieldInfo.proName}}</#if>
        </if>
                </#if>
            </#list>
        </#list>
    </#if>
    </select>

    <!-- 查询${tableInfo.simpleRemark} -->
    <select id="select${tableInfo.upperCamelCase}ById" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </select>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 2)} -->
    </#if>
    <!-- 新增${tableInfo.simpleRemark} -->
    <insert id="insert${tableInfo.upperCamelCase}" useGeneratedKeys="true" keyColumn="${tableInfo.pkColName}" keyProperty="${tableInfo.pkLowerCamelName}">
        INSERT INTO ${tableInfo.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
    <#list tableInfo.fieldInfos as fieldInfo>
            <if test="${fieldInfo.proName} != null">${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></if>
    </#list>
        </trim>
        <trim prefix="VALUES (" suffix=")" suffixOverrides=",">
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if dbConfig.dbType == "oracle">
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName},jdbcType=${fieldInfo.typeName}}<#if fieldInfo_has_next>,</#if></if>
        <#else>
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if></if>
        </#if>
    </#list>
        </trim>
    </insert>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 2)} -->
    </#if>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 3)} -->
    </#if>
    <!-- 修改${tableInfo.simpleRemark} -->
    <update id="update${tableInfo.upperCamelCase}">
        UPDATE ${tableInfo.tableName}
        <set>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey>
            <if test="${fieldInfo.proName} != null">${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}<#if dbConfig.dbType == "oracle">,jdbcType=${fieldInfo.typeName}</#if>}<#if fieldInfo_has_next>,</#if></if>
        </#if>
    </#list>
        </set>
        WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </update>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 3)} -->
    </#if>

    <!-- 删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ById">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </delete>

    <!-- 批量删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ByIds">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="array" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    <!-- 检查${fieldInfo.simpleRemark!fieldInfo.colName}是否存在 -->
    <select id="check${fieldInfo.upperCamelCase}Existed" resultType="string">
                <#if tableInfo.pkLowerCamelName?has_content>
        SELECT 1 FROM ${tableInfo.tableName} WHERE<#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")> DEL_FLAG = '0'</#if>
            <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>AND </#if>${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}}
            <if test="${tableInfo.pkLowerCamelName} != null<#if tableInfo.pkJavaType == "String"> and ${tableInfo.pkLowerCamelName} != ''</#if>">
                AND ${tableInfo.pkColName} != ${"#"}{${tableInfo.pkLowerCamelName}}
            </if>
        LIMIT 1
                <#else>
        SELECT 1 FROM ${tableInfo.tableName} WHERE<#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")> DEL_FLAG = '0' AND</#if> ${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}} LIMIT 1
                </#if>
    </select>
            </#if>
        </#list>
    </#list>
</#if>
</mapper>