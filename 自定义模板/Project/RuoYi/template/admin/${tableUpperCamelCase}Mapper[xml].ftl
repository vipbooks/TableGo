<#-- 用于生成Mapper.xml配置的自定义模板 -->
<#-- 初始化表别名 -->
<#assign tableAlias = FtlUtils.emptyToDefault(tableInfo.tableAlias, "${tableInfo.tableAlias}.", StringUtils.EMPTY) />
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.batchSearchFields) />
<#-- 如果配置的查询字段为空则取表字段的前几个字段 -->
<#if !searchFields?has_content><#assign searchFields = FtlUtils.subFieldInfosFilter(tableInfo.fieldInfos, 0, 2, "ID") /></#if>
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.simpleRemark}(${tableInfo.tableName})", tableInfo.tableName)} -->
<mapper namespace="${jsonParam.basePackagePath}.${jsonParam.moduleName}.mapper.${tableInfo.upperCamelCase}Mapper">
    <#if paramConfig.showMergeUpdateMark>
    <!-- ${String.format(paramConfig.mergeFileMarkBegin, 1)} -->
    </#if>
    <!-- 字段映射 -->
    <resultMap id="${tableInfo.lowerCamelCase}Map" type="${tableInfo.upperCamelCase}">
    <#if tableInfo.pkLowerCamelName?has_content>
        ${"<id"?right_pad(7)} ${"column=\"${tableInfo.pkColName}\""?right_pad(30)} property="${tableInfo.pkLowerCamelName}" />
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.primaryKey><#continue/></#if>
        <result ${"column=\"${fieldInfo.colName}\""?right_pad(30)} property="${fieldInfo.lowerCamelCase}" />
    </#list>
    </resultMap>

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

    <!-- 分页查询${tableInfo.simpleRemark}列表 -->
    <select id="select${tableInfo.upperCamelCase}List" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
    <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
            <include refid="mainColumns" />
    <#else>
            <include refid="allColumns" />
    </#if>
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>${tableAlias}DEL_FLAG = '0'<#else>1 = 1</#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
        <if test="${fieldInfo.proName}Begin != null">
            AND ${tableAlias}${fieldInfo.colName} &gt;= ${"#"}{${fieldInfo.proName}Begin}
        </if>
        <if test="${fieldInfo.proName}End != null">
            AND ${tableAlias}${fieldInfo.colName} &lt; ${"#"}{${fieldInfo.proName}End}
        </if>
            <#else>
        <if test="${fieldInfo.proName} != null<#if fieldInfo.isStringType> and ${fieldInfo.proName} != ''</#if>">
            AND ${tableAlias}${fieldInfo.colName}<#if fieldInfo.isStringType && !FtlUtils.strContainsAny(fieldInfo.colName, "_id") && !fieldInfo.isDictType> LIKE CONCAT('%', ${"#"}{${fieldInfo.proName}}, '%')<#else> = ${"#"}{${fieldInfo.proName}}</#if>
        </if>
            </#if>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>
        <if test="${fieldInfo.proName}List != null and ${fieldInfo.proName}List.size > 0">
            AND ${tableAlias}${fieldInfo.colName} IN
            <foreach collection="${fieldInfo.proName}List" index="index" item="${fieldInfo.proName}" open="(" separator="," close=")">
                ${"#"}{${fieldInfo.proName}}
            </foreach>
        </if>
        </#list>
    </#if>
    </select>

    <!-- 根据主键ID查询${tableInfo.simpleRemark} -->
    <select id="select${tableInfo.upperCamelCase}ById" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE ${tableAlias}${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </select>

    <!-- 根据主键ID列表查询${tableInfo.simpleRemark}列表 -->
    <select id="select${tableInfo.upperCamelCase}ByIds" resultMap="${tableInfo.lowerCamelCase}Map">
        SELECT
            <include refid="allColumns" />
        FROM ${tableInfo.tableName} <#if StringUtils.isNotBlank(tableInfo.tableAlias)>${tableInfo.tableAlias} </#if>WHERE ${tableAlias}${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </select>
<#if checkValueExistedFields?has_content>

    <!-- 检查${tableInfo.simpleRemark}是否存在 -->
    <select id="check${tableInfo.upperCamelCase}Existed" resultType="string">
        SELECT 1 FROM ${tableInfo.tableName}
        <where>
        <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>
            AND DEL_FLAG = '0'
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

    <!-- 删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ById">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} = ${"#"}{${tableInfo.pkLowerCamelName}}
    </delete>

    <!-- 批量删除${tableInfo.simpleRemark} -->
    <delete id="delete${tableInfo.upperCamelCase}ByIds">
        DELETE FROM ${tableInfo.tableName} WHERE ${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </delete>
    <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>

    <!-- 批量逻辑删除${tableInfo.simpleRemark} -->
    <update id="delete${tableInfo.upperCamelCase}LogicByIds">
        UPDATE ${tableInfo.tableName}
        <set>
            DEL_FLAG = '2',
            UPDATE_TIME = NOW(),
            <if test="loginName != null and loginName != ''">UPDATE_BY = ${"#"}{loginName}</if>
        </set>
        WHERE DEL_FLAG = '0' AND ${tableInfo.pkColName} IN
        <foreach collection="idList" index="index" item="${tableInfo.pkLowerCamelName}" open="(" separator="," close=")">
            ${"#"}{${tableInfo.pkLowerCamelName}}
        </foreach>
    </update>
    </#if>
</mapper>