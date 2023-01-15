<#-- 用于生成MyBatis的Mapper.xml配置文件 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 如果配置的查询字段为空则取表字段的前几个字段 -->
<#if !searchFields?has_content><#assign searchFields = FtlUtils.subListContainsFilter(tableInfo.fieldNameList, 0, 2, "ID") /></#if>
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
        <id column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="${fieldInfo.jdbcType}" />
        <#else>
        <result column="${fieldInfo.colName}" property="${fieldInfo.lowerCamelCase}" jdbcType="${fieldInfo.jdbcType}" />
        </#if>
    </#list>
    </resultMap>

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
        <if test="${fieldInfo.proName} != null<#if fieldInfo.javaType == "String"> and ${fieldInfo.proName} != ''</#if>">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo.javaType == "String" && fieldInfo.lowerColName?index_of("_id") == -1 && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{${fieldInfo.proName}}, '%')<#else> = ${"#"}{${fieldInfo.proName}}</#if>
        </if>
                </#if>
            </#list>
        </#list>
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
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>DEL_FLAG = '0' AND </#if><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </select>
</#if>

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
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName},jdbcType=${fieldInfo.jdbcType}}<#if fieldInfo_has_next>,</#if></if>
        <#else>
            <if test="${fieldInfo.proName} != null">${"#"}{${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if></if>
        </#if>
    </#list>
        </trim>
    </insert>

    <!-- 批量新增${tableInfo.simpleRemark} -->
    <insert id="batchInsert${tableInfo.upperCamelCase}" useGeneratedKeys="true" keyColumn="${tableInfo.pkColName}" keyProperty="${tableInfo.pkLowerCamelName}">
        INSERT INTO ${tableInfo.tableName} (
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
            <#list pagingFieldList as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>,</#if>
        </#list>
        ) VALUES
        <foreach collection="list" index="index" item="item" separator=",">
            (
            <#list tableInfo.fieldInfos as fieldInfo>
                ${"#"}{item.${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if>
            </#list>
            )
        </foreach>
    </insert>

    <!-- 修改${tableInfo.simpleRemark} -->
    <update id="update${tableInfo.upperCamelCase}">
        UPDATE ${tableInfo.tableName}
        <set>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey>
            <if test="${fieldInfo.proName} != null">${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}<#if dbConfig.dbType == "oracle">,jdbcType=${fieldInfo.jdbcType}</#if>}<#if fieldInfo_has_next>,</#if></if>
        </#if>
    </#list>
        </set>
        WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </update>

    <!-- 批量修改${tableInfo.simpleRemark} -->
    <update id="batchUpdate${tableInfo.upperCamelCase}">
        <foreach collection="list" index="index" item="item" separator=";">
            UPDATE ${tableInfo.tableName}
            <set>
            <#list tableInfo.fieldInfos as fieldInfo>
                <if test="item.${fieldInfo.proName} != null">${fieldInfo.colName} = ${"#"}{item.${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if></if>
            </#list>
            </set>
            WHERE ${tableInfo.pkColName} = ${"#"}{item.${tableInfo.pkLowerCamelName}}
        </foreach>
    </update>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 2)} -->
    </#if>
<#if tableInfo.pkLowerCamelName?has_content>

    <!-- 删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ById">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
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