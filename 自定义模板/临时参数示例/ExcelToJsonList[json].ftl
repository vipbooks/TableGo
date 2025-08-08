<#-- 用于生成从Excel导入数据生成集合的JSON的自定义模板例示 -->
[
<#if excelDataList?has_content>
    <#list excelDataList as excelData>
    {
        "姓名" : "${excelData.姓名}",
        "用户名" : "${excelData.用户名}",
        "移动电话" : "${excelData.移动电话}"
    }<#if excelData_has_next>,</#if>
    </#list>
</#if>
]