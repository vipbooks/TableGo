<#-- 用于生成 OceanBase 分页语句的自定义模板 -->
SELECT * FROM (SELECT t.*, ROWNUM AS ROW_NUM FROM (${findDataSql}) t WHERE ROWNUM <= ${(page - 1) * pageSize + pageSize}) WHERE ROW_NUM > ${(page - 1) * pageSize}