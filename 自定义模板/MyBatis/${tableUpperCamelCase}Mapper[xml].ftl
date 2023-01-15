<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.${tableInfo.upperCamelCase}Mapper">
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
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.commonFields, paramConfig.customColumnThreshold)>
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
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and condition.${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.javaType == "String" && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{condition.${fieldInfo.proName}}, '%')<#else> = ${"#"}{condition.${fieldInfo.proName}}</#if>
        </if>
                    </#if>
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
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and condition.${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} = ${"#"}{condition.${fieldInfo.proName}}
        </if>
                </#if>
            </#list>
        </#list>
    </#if>
    </select>
<#if tableInfo.pkLowerCamelName?has_content>

    <!-- 根据主键ID查询${tableInfo.simpleRemark} -->
    <select id="get${tableInfo.upperCamelCase}ById" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}<#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")> AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DELETE_FLAG = '1'</#if>
    </select>

    <!-- 根据主键ID列表查询${tableInfo.simpleRemark}列表 -->
    <select id="find${tableInfo.upperCamelCase}ByIds" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DELETE_FLAG = '1' AND </#if><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </select>
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    <!-- 检查${fieldInfo.simpleRemark!fieldInfo.colName}是否存在 -->
    <select id="check${fieldInfo.upperCamelCase}Existed" resultType="string">
                <#if tableInfo.pkLowerCamelName?has_content>
        SELECT 1 FROM ${tableInfo.tableName} WHERE<#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")> DELETE_FLAG = '1'</#if>
            <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>AND </#if>${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}}
            <if test="${tableInfo.pkLowerCamelName} != null<#if tableInfo.pkJavaType == "String"> and ${tableInfo.pkLowerCamelName} != ''</#if>">
                AND ${tableInfo.pkColName} != ${"#"}{${tableInfo.pkLowerCamelName}}
            </if>
        LIMIT 1
                <#else>
        SELECT 1 FROM ${tableInfo.tableName} WHERE<#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")> DELETE_FLAG = '1' AND</#if> ${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}} LIMIT 1
                </#if>
    </select>
            </#if>
        </#list>
    </#list>
</#if>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 2)} -->
    </#if>
    <!-- 新增${tableInfo.simpleRemark} -->
    <insert id="add${tableInfo.upperCamelCase}" useGeneratedKeys="true" keyColumn="${tableInfo.pkColName}" keyProperty="${tableInfo.pkLowerCamelName}">
        INSERT INTO ${tableInfo.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
    <#list tableInfo.fieldInfos as fieldInfo>
            <if test="${fieldInfo.proName} != null">${fieldInfo.colName}<#if fieldInfo_has_next>,</#if></if>
    </#list>
        </trim>
        <trim prefix="VALUES (" suffix=")" suffixOverrides=",">
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if dbConfig.dbType == "oracle">
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName},jdbcType=${fieldInfo.jdbcType}}<#if fieldInfo_has_next>,</#if></if>
        <#else>
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if></if>
        </#if>
    </#list>
        </trim>
    </insert>

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
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 2)} -->
    </#if>
<#if tableInfo.pkLowerCamelName?has_content>

    <!-- 根据主键ID删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ById">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} = ${"#"}{id}
    </delete>

    <!-- 批量物理删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ByIds" parameterType="list">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="list" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
    <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>

    <!-- 批量逻辑删除${tableInfo.simpleRemark} -->
    <update id="delete${tableInfo.upperCamelCase}LogicByIds">
        UPDATE ${tableInfo.tableName}
        <set>
            DELETE_FLAG = '0',
            LAST_UPDATE_DATE = NOW(),
            <if test="userId != null">LAST_UPDATED_BY = ${"#"}{userId}</if>
        </set>
        WHERE DELETE_FLAG = '1' AND ${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </update>
    </#if>
</#if>
</mapper>