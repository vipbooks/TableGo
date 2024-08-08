<#-- 用于生成从Excel导入数据生成批量新增表数据的自定义模板例示 -->
-- 批量新增用户数据
-- TRUNCATE TABLE t_user;
<#if excelDataList?has_content>
INSERT INTO t_user (username, full_name, mobile_phone, id_card, email, birthday) VALUES
    <#list excelDataList as excelData>
    ('${excelData.用户名}', '${excelData.姓名}', '${excelData.移动电话}', '${excelData.身份证}', '${excelData.电子邮箱}', '${excelData.出生日期}')<#if excelData_has_next>,<#else>;</#if>
    </#list>
</#if>