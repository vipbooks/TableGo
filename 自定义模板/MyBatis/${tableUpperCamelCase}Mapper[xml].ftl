<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFeilds) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- <#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> -->
<mapper namespace="${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper">
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}"/>

    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 表所有字段 -->
    <sql id="allColumns">
        <#list tableInfo.pagingFieldInfos as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.logFields)>
    <!-- 表主要字段 -->
    <sql id="mainColumns">
        <#assign pagingFieldInfoList = FtlUtils.tableFieldIgnore(tableInfo.fieldInfos, jsonParam.logFields, paramConfig.customColumnThreshold)>
        <#list pagingFieldInfoList as pagingFieldList>
        <#list pagingFieldList as fieldInfo><#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingFieldList_has_next>, </#if>
        </#list>
    </sql>
    </#if>
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkEnd, 1)} -->
    </#if>

    <!-- 根据条件分页查询${tableInfo.simpleRemark}列表 -->
    <select id="find${tableInfo.upperCamelCase}ByCondition" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE 1 = 1
    <#if searchFeilds?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFeilds as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                    <#if fieldInfo.javaType == "Date">
        <if test="condition.${fieldInfo.proName}Begin != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &gt;= ${"#"}{condition.${fieldInfo.proName}Begin}
        </if>
        <if test="condition.${fieldInfo.proName}End != null">
            AND <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${fieldInfo.colName} &lt;= ${"#"}{condition.${fieldInfo.proName}End}
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
    </select>

    <!-- 根据主键ID查询${tableInfo.simpleRemark}信息 -->
    <select id="get${tableInfo.upperCamelCase}ById" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias}.</#if>${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </select>

    <!-- 新增${tableInfo.simpleRemark}信息 -->
    <insert id="add${tableInfo.upperCamelCase}" useGeneratedKeys="true" keyColumn="${tableInfo.pkColName}" keyProperty="${tableInfo.pkLowerCamelName}">
        INSERT INTO ${tableInfo.tableName} (
            <#list tableInfo.pagingFieldInfos as pagingList>
            <#list pagingList as fieldInfo>${fieldInfo.colName}<#if fieldInfo_has_next>, </#if></#list><#if pagingList_has_next>, </#if>
            </#list>
        ) VALUES (
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if dbConfig.dbType == "oracle">
            ${"#"}{${fieldInfo.proName},jdbcType=${fieldInfo.typeName}}<#if fieldInfo_has_next>,</#if>
        <#else>
            ${"#"}{${fieldInfo.proName}}<#if fieldInfo_has_next>,</#if>
        </#if>
    </#list>
        )
    </insert>

    <!-- 修改${tableInfo.simpleRemark}信息 -->
    <update id="update${tableInfo.upperCamelCase}">
        UPDATE ${tableInfo.tableName}
        <set>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey>
            <if test="${fieldInfo.proName} != null">
                ${fieldInfo.colName} = ${"#"}{${fieldInfo.proName}<#if dbConfig.dbType == "oracle">,jdbcType=${fieldInfo.typeName}</#if>}<#if fieldInfo_has_next>,</#if>
            </if>
        </#if>
    </#list>
        </set>
        WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </update>

    <!-- 根据主键ID删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ById">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} = ${"#"}{id}
    </delete>

    <!-- 根据主键ID列表批量删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ByIds" parameterType="list">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="list" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
</mapper>