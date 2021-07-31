<#-- 用于生成清空数据库表数据SQL的自定义模板 -->
-- 清空数据库表数据SQL
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>

-- 清空<#if StringUtils.isNotBlank(tableInfo.simpleRemark)>${tableInfo.simpleRemark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
TRUNCATE TABLE ${tableInfo.tableName};
    </#list>
</#if>