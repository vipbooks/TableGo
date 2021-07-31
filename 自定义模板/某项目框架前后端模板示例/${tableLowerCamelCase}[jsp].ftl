<#-- 生成基于EasyUI的JSP管理页面 -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <title>${tableInfo.simpleRemark}管理</title>
        <jsp:include page="../common/input.jsp"></jsp:include>
        <script src="${"$"}{jsPath}/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}.js" type="text/javascript" charset="UTF-8"></script>
    </head>
    
    <body>
        <!-- 页面加载的遮罩层 -->
        <div id="pageLoadingDiv" class="pageLoadingDiv"></div>

        <!-- 搜索表单及工具栏部分 -->
        <div id="${tableInfo.lowerCamelCase}Toolbar">
            <!-- 搜索表单 -->
            <div class="toolbarSearch">
                <form id="${tableInfo.lowerCamelCase}SearchForm" method="post" class="easyui-form" data-options="novalidate:true" style="min-width: 850px;">
    <#assign loopCount = 0>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey && !fieldInfo.isMultiLineType && fieldInfo.lowerColName?index_of("_id") == -1 && fieldInfo.lowerCamelCase != "recordStatus" && fieldInfo.lowerCamelCase != "createdBy" && fieldInfo.lowerCamelCase != "creationDate" && fieldInfo.lowerCamelCase != "lastUpdatedBy" && fieldInfo.lowerCamelCase != "lastUpdateDate">
            <#assign loopCount = loopCount + 1>
                <#if fieldInfo.isDictType>
                    ${fieldInfo.simpleRemark}：<select id="${fieldInfo.lowerCamelCase}Search" name="${fieldInfo.lowerCamelCase}" style="width:153px;"></select>&nbsp;&nbsp;
                <#elseif fieldInfo.javaType == "Date">
                    ${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Search" name="${fieldInfo.lowerCamelCase}" class="easyui-datebox" style="width:153px;" editable="fasle"/>&nbsp;&nbsp;
                <#elseif fieldInfo.isNumericType>
                    ${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Search" name="${fieldInfo.lowerCamelCase}" class="easyui-numberbox" data-options="min:0" style='width:153px;'/>&nbsp;&nbsp;
                <#else>
                    ${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Search" name="${fieldInfo.lowerCamelCase}" class="easyui-textbox" style="width:153px;"/>&nbsp;&nbsp;
                </#if>
            <#if loopCount == 3>
                <#break>
            </#if>
        </#if>
    </#list>
                    
                    <a href="javascript:void(0);" onclick="${tableInfo.lowerCamelCase}GridSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
                    <a href="javascript:void(0);" onclick="CommonUtils.resetFormData('${tableInfo.lowerCamelCase}SearchForm');" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">清空搜索条件</a>
                </form>
            </div>
            
            <div>
                <t:authority code="${tableInfo.lowerCamelCase}.add">
                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="show${tableInfo.upperCamelCase}AddRowWindow();">新增</a>
                </t:authority>
                <t:authority code="${tableInfo.lowerCamelCase}.modify">
                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="show${tableInfo.upperCamelCase}ModifyRowWindow();">修改</a>
                </t:authority>
                <t:authority code="${tableInfo.lowerCamelCase}.deleteList">
                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="${tableInfo.lowerCamelCase}DeleteRows();">删除</a>
                </t:authority>
            </div>
        </div>
        
        <table id="${tableInfo.lowerCamelCase}Grid"></table>
        
        <!-- 新增或修改弹出窗口 -->
        <div id="${tableInfo.lowerCamelCase}AddOrModifyWindow" class="easyui-window" data-options="iconCls:'icon-add',modal:true, closed:true, resizable:false,minimizable:false,maximizable:false,collapsible:false,maximized:false" style="width:520px;height:300px;padding:2px;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'center',border:false" style="padding:10px;overflow: hidden;">
                    <form id="${tableInfo.lowerCamelCase}AddOrModifyWindowForm" method="post" class="easyui-form" data-options="novalidate:true">
    <#list tableInfo.pagingFieldInfos as pagingList>
        <#if tableInfo.pagingFieldInfos?size gt 1>
                        <div class="form_left_box50">
        </#if>
        <#list pagingList as fieldInfo>
            <#if !fieldInfo.primaryKey && !fieldInfo.isMultiLineType && fieldInfo.lowerColName?index_of("_id") == -1 && fieldInfo.lowerCamelCase != "createdBy" && fieldInfo.lowerCamelCase != "creationDate" && fieldInfo.lowerCamelCase != "lastUpdatedBy" && fieldInfo.lowerCamelCase != "lastUpdateDate">
                    <#if fieldInfo.isDictType>
                            <span>${fieldInfo.simpleRemark}：<select id="${fieldInfo.lowerCamelCase}Edit" name="${fieldInfo.lowerCamelCase}" style="width:153px;"></select></span>
                    <#elseif fieldInfo.javaType == "Date">
                            <span>${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Edit" name="${fieldInfo.lowerCamelCase}" class="easyui-datebox" data-options="<#if fieldInfo.isNotNull>required:true</#if>" editable="fasle" style="width:153px;"></span>
                    <#elseif fieldInfo.isNumericType>
                            <span>${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Edit" name="${fieldInfo.lowerCamelCase}" class="easyui-numberbox" data-options="<#if fieldInfo.isNotNull>required:true,</#if>min:0" style='width:153px;'/></span>
                    <#else>
                            <span>${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Edit" name="${fieldInfo.lowerCamelCase}" class="easyui-textbox" data-options="<#if fieldInfo.isNotNull>required:true,</#if>validType:'length[1,${fieldInfo.columnSize?c}]'" style="width:153px;"/></span>
                    </#if>
            </#if>
        </#list>
        <#if tableInfo.pagingFieldInfos?size gt 1>
                        </div>
        </#if>
        <#list pagingList as fieldInfo>
            <#if fieldInfo.isMultiLineType>
                        <div class="form_left_box100">
                            <div style="line-height: 70px;">
                                ${fieldInfo.simpleRemark}：<input id="${fieldInfo.lowerCamelCase}Edit" name="${fieldInfo.lowerCamelCase}" class="easyui-textbox" data-options="multiline:true,validType:'length[1,${fieldInfo.columnSize?c}]'" style="width: 372px;height: 70px;"/>
                            </div>
                        </div>
            </#if>
        </#list>
    </#list>
                        
                        <input type="hidden" id="${tableInfo.pkLowerCamelName}Edit" name="${tableInfo.pkLowerCamelName}"/>
                    </form>
                 </div>
                 
                 <!-- 按钮部分 -->
                 <div data-options="region:'south',border:false" style="text-align:right;padding:5px;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0);" onclick="${tableInfo.lowerCamelCase}AddOrModifySave();">保存</a>&nbsp;&nbsp;
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0);" onclick="$('#${tableInfo.lowerCamelCase}AddOrModifyWindow').window('close');">取消</a>
                 </div>
            </div>
        </div>
    </body>
</html>
