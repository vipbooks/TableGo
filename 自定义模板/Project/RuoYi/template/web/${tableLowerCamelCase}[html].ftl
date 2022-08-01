<#-- 用于生成列表管理页面的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化列表显示的字段 -->
<#assign listFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.listFields) />
<#-- 初始化需要导出Excel的字段 -->
<#assign exportFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.exportFields) />
<#-- 如果配置的查询字段为空则取表字段的前几个字段 -->
<#if !searchFields?has_content><#assign searchFields = FtlUtils.subListContainsFilter(tableInfo.fieldNameList, 0, 2, "ID") /></#if>
<#-- 如果配置的列表显示字段为空则取过虑后的表字段 -->
<#if !listFields?has_content><#assign listFields = FtlUtils.listContainsFilter(tableInfo.fieldNameList, "ID") /></#if>
<!DOCTYPE html>
<html lang="zh" xmlns:th="http://www.thymeleaf.org" xmlns:shiro="http://www.pollix.at/thymeleaf/shiro">
<head>
    <th:block th:include="include :: header('${tableInfo.simpleRemark}列表')" />
</head>
<body class="gray-bg">
    <div class="container-div">
        <div class="row">
            <div class="col-sm-12 search-collapse">
                <form id="formId">
                    <div class="select-list">
                        <ul>
                        <#if searchFields?has_content>
                            <#list tableInfo.fieldInfos as fieldInfo>
                                <#list searchFields as fieldName>
                                    <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                            <li>
                                <label>${fieldInfo.simpleRemark}：</label>
                                        <#if fieldInfo.isDictType>
                                 <select id="${fieldInfo.proName}Search" name="${fieldInfo.proName}" th:with="type=${"$"}{@dict.getType('${fieldInfo.proName}')}">
                                    <option value="">请选择</option>
                                    <option th:each="dict : ${"$"}{type}" th:text="${"$"}{dict.dictLabel}" th:value="${"$"}{dict.dictValue}"></option>
                                 </select>
                                        <#elseif fieldInfo.javaType == "Date">
                                 <input type="text" id="${fieldInfo.proName}Search" name="${fieldInfo.proName}" class="time-input" placeholder="${fieldInfo.simpleRemark}" readonly/>
                                        <#elseif fieldInfo.isNumericType>
                                 <input type="number" id="${fieldInfo.proName}Search" name="${fieldInfo.proName}" placeholder="${fieldInfo.simpleRemark}"/>
                                        <#else>
                                <input type="text" id="${fieldInfo.proName}Search" name="${fieldInfo.proName}" placeholder="${fieldInfo.simpleRemark}"/>
                                        </#if>
                            </li>
                                    </#if>
                                </#list>
                            </#list>
                        </#if>
                            <li>
                                <a class="btn btn-primary btn-rounded btn-sm" onclick="$.table.search()"><i class="fa fa-search"></i>&nbsp;搜索</a>
                                <a class="btn btn-warning btn-rounded btn-sm" onclick="$.form.reset()"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>

            <div class="btn-group-sm" id="toolbar" role="group">
                <a class="btn btn-success" onclick="$.operate.add()" shiro:hasPermission="${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:add">
                    <i class="fa fa-plus"></i> 添加
                </a>
                <a class="btn btn-primary single disabled" onclick="$.operate.edit()" shiro:hasPermission="${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:edit">
                    <i class="fa fa-edit"></i> 修改
                </a>
                <a class="btn btn-danger multiple disabled" onclick="$.operate.removeAll()" shiro:hasPermission="${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:remove">
                    <i class="fa fa-remove"></i> 删除
                </a>
<#if FtlUtils.fieldAtListExisted(tableInfo, exportFields)>
                <a class="btn btn-warning" onclick="$.table.exportExcel()" shiro:hasPermission="${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:export">
                    <i class="fa fa-download"></i> 导出
                </a>
</#if>
            </div>
            <div class="col-sm-12 select-table table-striped">
                <table id="bootstrap-table"></table>
            </div>
        </div>
    </div>
    <th:block th:include="include :: footer" />

    <script th:inline="javascript">
        var editFlag = [[${"$"}{@permission.hasPermi('${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:edit')}]];
        var removeFlag = [[${"$"}{@permission.hasPermi('${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:remove')}]];
        var prefix = ctx + "${jsonParam.moduleName}/${tableInfo.lowerCamelCase}";

        $(function() {
            var options = {
                url: prefix + "/list",
                createUrl: prefix + "/add",
                updateUrl: prefix + "/edit/{id}",
                removeUrl: prefix + "/remove",
<#if FtlUtils.fieldAtListExisted(tableInfo, exportFields)>
                exportUrl: prefix + "/export",
</#if>
                modalName: "${tableInfo.simpleRemark}",
                columns: [{
                    checkbox: true
                },
                {
                    field: '${tableInfo.pkLowerCamelName}',
                    title: '${tableInfo.pkRemark}',
                    visible: false
                },
<#if listFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list listFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName) && !fieldInfo.primaryKey>
                {
                    field: '${fieldInfo.proName}',
                    title: '${fieldInfo.simpleRemark}'
                },
            </#if>
        </#list>
    </#list>
</#if>
                {
                    title: '操作',
                    align: 'center',
                    formatter: function(value, row, index) {
                        var actions = [];
                        actions.push('<a class="btn btn-success btn-xs ' + editFlag + '" href="javascript:void(0)" onclick="$.operate.edit(\'' + row.${tableInfo.pkLowerCamelName} + '\')"><i class="fa fa-edit"></i>编辑</a> ');
                        actions.push('<a class="btn btn-danger btn-xs ' + removeFlag + '" href="javascript:void(0)" onclick="$.operate.remove(\'' + row.${tableInfo.pkLowerCamelName} + '\')"><i class="fa fa-remove"></i>删除</a>');
                        return actions.join('');
                    }
                }]
            };
            $.table.init(options);
        });
    </script>
</body>
</html>