<#-- 用于生成 DB2 分页语句的自定义模板 -->
${findDataSql}<#if !isUsedOrderBy> ORDER BY ${tableInfo.pkOriginalName}</#if> OFFSET ${(page - 1) * pageSize} ROWS FETCH NEXT ${pageSize} ROWS ONLY