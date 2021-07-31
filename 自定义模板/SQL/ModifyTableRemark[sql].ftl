<#-- 用于生成修改数据库表注释和字段注释的自定义模板 -->
-- 修改数据库表注释和字段注释SQL
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>

        <#if tableInfo.fieldInfos?? && tableInfo.fieldInfos?size &gt; 0>
            <#if tableInfo.remark?? && tableInfo.remark?trim != "">
-- 修改${tableInfo.remark}
            <#else>
-- 修改${tableInfo.tableName}
            </#if>
            <#if tableInfo.remark?? && tableInfo.remark?trim != "">
ALTER TABLE ${tableInfo.tableName} COMMENT='${tableInfo.remark}';
            </#if>
            <#list tableInfo.fieldInfos as fieldInfo>
                <#if fieldInfo.remark?? && fieldInfo.remark?trim != "">
ALTER TABLE ${tableInfo.tableName} MODIFY COLUMN ${fieldInfo.colName} ${fieldInfo.dataTypeStr}<#if fieldInfo.isNotNull> NOT NULL</#if> COMMENT '${fieldInfo.remark}';
                </#if>
            </#list>
        </#if>
    </#list>
</#if>