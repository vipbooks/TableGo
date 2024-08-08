<#-- 用于生成清空数据库表数据SQL的自定义模板 -->
-- 清空数据库表数据SQL
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>

-- 清空${FtlUtils.replaceStrEmpty(tableInfo.simpleRemark, "表")}表数据
TRUNCATE TABLE ${tableInfo.tableName};
    </#list>
</#if>