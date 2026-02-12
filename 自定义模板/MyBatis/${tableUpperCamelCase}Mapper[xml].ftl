<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表别名 -->
<#assign tableAlias = FtlUtils.emptyToDefault(tableInfo.tableAlias, "${tableInfo.tableAlias}.", StringUtils.EMPTY) />
<#-- 初始化表的简单查询字段 -->
<#assign searchFields = FtlUtils.getAdvanceSearchFieldSimpleList(tableInfo, jsonParam.searchFields, jsonParam.advanceSearch) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getAdvanceSearchFieldBatchList(tableInfo, jsonParam.batchSearchFields, jsonParam.advanceSearch) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.simpleRemark}(${tableInfo.tableName})", tableInfo.tableName)} -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.${tableInfo.upperCamelCase}Mapper">
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase}"/>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo>${tableAlias}${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.commonFields, paramConfig.fieldGroup)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo>${tableAlias}${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
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
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "is_deleted")>${tableAlias}is_deleted = 0<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
        <if test="condition.${fieldInfo.proName}Begin != null">
            AND ${tableAlias}${fieldInfo.colName} &gt;= ${"#"}{condition.${fieldInfo.proName}Begin}
        </if>
        <if test="condition.${fieldInfo.proName}End != null">
            AND ${tableAlias}${fieldInfo.colName} &lt; ${"#"}{condition.${fieldInfo.proName}End}
        </if>
            <#else>
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.isStringType> and condition.${fieldInfo.proName} != ''</#if>">
            AND ${tableAlias}${fieldInfo.colName}<#if fieldInfo.isStringType && !FtlUtils.strContainsAny(fieldInfo.colName, "_id") && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{condition.${fieldInfo.proName}}, '%')<#else> = ${"#"}{condition.${fieldInfo.proName}}</#if>
        </if>
            </#if>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>
        <if test="condition.${fieldInfo.proName}List != null and condition.${fieldInfo.proName}List.size > 0">
            AND ${tableAlias}${fieldInfo.colName} IN
            <foreach collection="condition.${fieldInfo.proName}List" index="index" item="${fieldInfo.proName}" open="(" separator="," close=")">
                ${"#"}{${fieldInfo.proName}}
            </foreach>
        </if>
        </#list>
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATED_TIME")>
        ORDER BY ${tableAlias}CREATED_TIME IS NULL, ${tableAlias}CREATED_TIME DESC
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
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "is_deleted")>${tableAlias}is_deleted = 0<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if !fieldInfo.isDateType>
        <if test="condition.${fieldInfo.proName} != null<#if fieldInfo.isStringType> and condition.${fieldInfo.proName} != ''</#if>">
            AND ${tableAlias}${fieldInfo.colName} = ${"#"}{condition.${fieldInfo.proName}}
        </if>
            </#if>
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
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE ${tableAlias}${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}<#if FtlUtils.fieldExisted(tableInfo, "is_deleted")> AND ${tableAlias}is_deleted = 0</#if>
    </select>

    <!-- 根据主键ID列表批量查询${tableInfo.simpleRemark} -->
    <select id="find${tableInfo.upperCamelCase}ByIds" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "is_deleted")>${tableAlias}is_deleted = 0 AND </#if>${tableAlias}${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </select>
</#if>
<#if checkValueExistedFields?has_content>

    <!-- 检查${tableInfo.simpleRemark}是否存在 -->
    <select id="check${tableInfo.upperCamelCase}Existed" resultType="string">
        SELECT 1 FROM ${tableInfo.tableName}
        <where>
        <#if FtlUtils.fieldExisted(tableInfo, "is_deleted")>
            AND is_deleted = 0
        </#if>
    <#list checkValueExistedFields as fieldInfo>
            <if test="${fieldInfo.proName} != null<#if fieldInfo.isStringType> and ${fieldInfo.proName} != ''</#if>">
                AND ${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}}
            </if>
    </#list>
    <#if tableInfo.pkLowerCamelName?has_content>
            <if test="${tableInfo.pkLowerCamelName} != null<#if tableInfo.pkIsStringType> and ${tableInfo.pkLowerCamelName} != ''</#if>">
                AND ${tableInfo.pkColName} != ${"#"}{${tableInfo.pkLowerCamelName}}
            </if>
    </#if>
        </where>
        LIMIT 1
    </select>
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
    <#if FtlUtils.fieldExisted(tableInfo, "is_deleted")>

    <!-- 批量逻辑删除${tableInfo.simpleRemark} -->
    <update id="delete${tableInfo.upperCamelCase}LogicByIds">
        UPDATE ${tableInfo.tableName}
        <set>
            is_deleted = 1,
            LAST_UPDATED_TIME = NOW(),
            <if test="userId != null and userId != ''">LAST_UPDATED_BY = ${"#"}{userId}</if>
        </set>
        WHERE is_deleted = 0 AND ${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </update>
    </#if>
</#if>
</mapper>