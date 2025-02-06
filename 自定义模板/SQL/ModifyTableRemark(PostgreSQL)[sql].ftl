<#-- 用于生成 PostgreSQL 修改数据库表注释和字段注释的自定义模板 -->
-- 修改 PostgreSQL 数据库表注释和字段注释SQL
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>

        <#if tableInfo.fieldInfos?? && tableInfo.fieldInfos?size &gt; 0>
            <#if tableInfo.remark?? && tableInfo.remark?trim != "">
-- 修改${tableInfo.remark}
            <#else>
-- 修改${tableInfo.tableName}
            </#if>
            <#if tableInfo.remark?? && tableInfo.remark?trim != "">
COMMENT ON TABLE ${tableInfo.tableName} IS '${tableInfo.remark}';
            </#if>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if fieldInfo.remark?? && fieldInfo.remark?trim != "">
COMMENT ON COLUMN ${tableInfo.tableName}.${fieldInfo.colName} IS '${fieldInfo.remark}';
                </#if>
            </#list>
        </#if>
    </#list>
</#if>