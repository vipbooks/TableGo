<#-- 用于生成从Excel导入数据生成对象的JSON的自定义模板例示 -->
{
<#if excelDataList?has_content>
    <#list excelDataList as excelData>
    "${excelData.姓名}" : "${excelData.用户名}"<#if excelData_has_next>,</#if>
    </#list>
</#if>
}