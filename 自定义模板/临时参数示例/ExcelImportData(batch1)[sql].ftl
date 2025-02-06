<#-- 用于生成从Excel导入数据生成批量新增表数据的自定义模板例示 -->
-- 批量新增用户数据，分批生成批量插入SQL
-- TRUNCATE TABLE t_user;
<#if excelDataList?has_content>
    <#assign ignoreCount = 0 />
    <#assign validDataList = FtlUtils.createEmptyList() />
    <#list excelDataList as excelData>
        <#if !excelData.用户名?has_content || !excelData.姓名?has_content || !excelData.移动电话?has_content>
            <#assign ignoreCount = ignoreCount + 1 />
            <#continue/>
        </#if>
        <#assign validDataList = FtlUtils.listAddElement(validDataList, excelData) />
    </#list>
    <#assign partitionList = FtlUtils.partition(validDataList, 200) />
    <#list partitionList as dataList>
-- 第 ${dataList_index + 1} 批，插入 ${dataList?size} 条数据，共 ${partitionList?size} 批数据，共 ${validDataList?size} 条<#if ignoreCount gt 0>有效</#if>数据<#if ignoreCount gt 0>，共忽略 ${ignoreCount} 条不符合条件的数据</#if>
INSERT INTO t_user (username, full_name, mobile_phone, id_card, email, birthday) VALUES
        <#list dataList as excelData>
    ('${excelData.用户名}', '${excelData.姓名}', '${excelData.移动电话}', '${excelData.身份证}', '${excelData.电子邮箱}', '${excelData.出生日期?string('yyyy-MM-dd')}')<#if excelData_has_next>,<#else>;</#if>
        </#list>

    </#list>
</#if>