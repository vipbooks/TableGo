<#-- 生成基于EasyUI的JSP管理页面引用的JS文件 -->
/** ${tableInfo.simpleRemark}管理模块JS */

var ${tableInfo.lowerCamelCase}GridUrl = "/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}/list";
var ${tableInfo.lowerCamelCase}AddUrl = "/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}/add";
var ${tableInfo.lowerCamelCase}ModifyUrl = "/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}/modify";
var ${tableInfo.lowerCamelCase}DeleteUrl = "/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}/deleteList";

// ${tableInfo.simpleRemark}数据列表
var ${tableInfo.lowerCamelCase}Grid = null;

/** 初始化页面组件和数据 */
$(function(){
    initDataGrid();
    initCombobox();
    ${tableInfo.lowerCamelCase}GridSearch();
});

/** 初始化数据列表组件 */
function initDataGrid() {
    ${tableInfo.lowerCamelCase}Grid = $("#${tableInfo.lowerCamelCase}Grid").datagrid({
        fit:true,
        border:false,
        rownumbers:true,
        ctrlSelect:true,
        method:"post",
        pagination:true,
        pageSize:pageSize,
        pageList:pageList,
        toolbar:"#${tableInfo.lowerCamelCase}Toolbar",
        columns:[[
<#list tableInfo.fieldInfos as fieldInfo>
    <#if fieldInfo.primaryKey>
            {field:"${fieldInfo.lowerCamelCase}", checkbox:true},
    <#else>
        <#if fieldInfo.isDictType>
            <#if fieldInfo.simpleRemark?? && fieldInfo.simpleRemark?index_of("是否") != -1>
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}", width:100,align:"center", formatter:GetDictName.getYesOrNoName},
            <#else>
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}", width:100,align:"center", formatter:GetDictName.get${fieldInfo.upperCamelCase}Name},
            </#if>
        <#elseif fieldInfo.isMultiLineType>
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}", width:200},
        <#elseif fieldInfo.lowerCamelCase == "createdBy" || fieldInfo.lowerCamelCase == "lastUpdatedBy">
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}", width:100, align:"center", formatter:RemoteCall.getFullNameByUserId},
        <#elseif fieldInfo.lowerCamelCase == "creationDate" || fieldInfo.lowerCamelCase == "lastUpdateDate">
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}",width:130, align:"center"},
        <#else>
            {field:"${fieldInfo.lowerCamelCase}", title:"${fieldInfo.simpleRemark}",width:100, align:"center"},
        </#if>
    </#if>
</#list>
       ]]
    });
}

/** 初始化下拉框组件 */
function initCombobox() {
<#list tableInfo.fieldInfos as fieldInfo>
    <#if fieldInfo.isDictType>
    // ${fieldInfo.simpleRemark}
    ${"$"}("#${fieldInfo.lowerCamelCase}Edit").combobox({
    	loader: function(param,success,error) {
    		DictUtils.getComboboxDictData({dictTypeCode:"<#if fieldInfo.simpleRemark?? && fieldInfo.simpleRemark?index_of("是否") != -1>yesOrNo<#else>${fieldInfo.lowerCamelCase}</#if>"<#if !fieldInfo.isNotNull>,defaultEmpty:true</#if>}, function(data){
    			success(data);
    		});
    	},
        panelHeight:"auto",
        editable:false,
        required:<#if fieldInfo.isNotNull>true<#else>false</#if>
    });
        
    </#if>
</#list>
}

/** ${tableInfo.simpleRemark}列表查询 */
function ${tableInfo.lowerCamelCase}GridSearch() {
    ${tableInfo.lowerCamelCase}Grid.datagrid("options").url = path + ${tableInfo.lowerCamelCase}GridUrl;
    ${tableInfo.lowerCamelCase}Grid.datagrid("options").queryParams = CommonUtils.getFormJson("${tableInfo.lowerCamelCase}SearchForm");
    ${tableInfo.lowerCamelCase}Grid.datagrid("load");
}

/** 新增${tableInfo.simpleRemark} */
function show${tableInfo.upperCamelCase}AddRowWindow() {
    CommonUtils.showAddWindow("新增${tableInfo.simpleRemark}", ${tableInfo.lowerCamelCase}AddUrl, "${tableInfo.lowerCamelCase}AddOrModifyWindow");

<#list tableInfo.fieldInfos as fieldInfo>
    <#if fieldInfo.isDictType>
    CommonUtils.setComboboxValueByIndex("${fieldInfo.lowerCamelCase}Edit");
    </#if>
</#list>
}

/** 修改${tableInfo.simpleRemark} */
function show${tableInfo.upperCamelCase}ModifyRowWindow() {
    CommonUtils.showModifyWindow("修改${tableInfo.simpleRemark}", ${tableInfo.lowerCamelCase}ModifyUrl, ${tableInfo.lowerCamelCase}Grid, "${tableInfo.lowerCamelCase}AddOrModifyWindow");
}

/** 保存${tableInfo.simpleRemark} */
function ${tableInfo.lowerCamelCase}AddOrModifySave() {
    CommonUtils.addOrModifyWindowSave("${tableInfo.lowerCamelCase}AddOrModifyWindow", ${tableInfo.lowerCamelCase}Grid);
}

/** 批量删除${tableInfo.simpleRemark} */
function ${tableInfo.lowerCamelCase}DeleteRows() {
    CommonUtils.deleteGridRows(${tableInfo.lowerCamelCase}DeleteUrl, ${tableInfo.lowerCamelCase}Grid);
}
