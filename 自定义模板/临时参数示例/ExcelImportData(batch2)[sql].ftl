<#-- 用于生成从Excel导入数据生成批量新增表数据的自定义模板例示 -->
-- 批量新增用户数据，分批生成批量插入SQL
-- TRUNCATE TABLE t_user;
<#if excelDataList?has_content>
    <#assign batchSize = 200 />
    <#assign ignoreCount = 0 />
    <#assign count = 0 />
    <#list excelDataList as excelData>
        <#if !excelData.用户名?has_content || !excelData.姓名?has_content || !excelData.移动电话?has_content>
            <#assign ignoreCount = ignoreCount + 1 />
            <#continue/>
        </#if>
        <#if (excelData_index + 1) % batchSize == 1>
            <#assign count = count + 1 />

-- 第 ${count} 批，共 ${excelDataList?size} 条数据，共 ${(excelDataList?size + batchSize - 1) / batchSize} 批数据
INSERT INTO t_user (username, full_name, mobile_phone, id_card, email, birthday) VALUES
    ('${excelData.用户名}', '${excelData.姓名}', '${excelData.移动电话}', '${excelData.身份证}', '${excelData.电子邮箱}', '${excelData.出生日期?string('yyyy-MM-dd')}')<#if excelData_index % batchSize < batchSize - 1 && (excelData_index + 1) < excelDataList?size>,<#else>;</#if>
        <#else>
    ('${excelData.用户名}', '${excelData.姓名}', '${excelData.移动电话}', '${excelData.身份证}', '${excelData.电子邮箱}', '${excelData.出生日期?string('yyyy-MM-dd')}')<#if excelData_index % batchSize < batchSize - 1 && (excelData_index + 1) < excelDataList?size>,<#else>;</#if>
        </#if>
    </#list>
</#if>

-- 共忽略 ${ignoreCount} 条不符合条件的数据