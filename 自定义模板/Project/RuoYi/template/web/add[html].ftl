<#-- 用于生成新增页面的自定义模板 -->
<#-- 初始化Form表单字段 -->
<#assign formFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.formFields) />
<#-- 如果配置的表单字段为空则取表字段的前几个字段 -->
<#if !formFields?has_content><#assign formFields = FtlUtils.subFieldInfosFilter(tableInfo.fieldInfos, 0, 4, "ID") /></#if>
<!DOCTYPE html>
<html lang="zh" xmlns:th="http://www.thymeleaf.org">
<head>
    <th:block th:include="include :: header('新增${tableInfo.simpleRemark}')" />
<#if FtlUtils.fieldTypeExisted(tableInfo, "isRichTextType")>
    <th:block th:include="include :: summernote-css" />
</#if>
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content animated fadeInRight ibox-content">
        <form class="form-horizontal m" id="form-${tableInfo.lowerCamelCase}-add">
        <#if formFields?has_content>
            <#list formFields as fieldInfo>
            <div class="form-group">
                <label class="col-sm-3 control-label<#if fieldInfo.isNotNull> is-required</#if>">${fieldInfo.simpleRemark}：</label>
                <div class="col-sm-8">
                        <#if fieldInfo.isDictType>
                    <select id="${fieldInfo.proName}Add" name="${fieldInfo.proName}" th:with="type=${"$"}{@dict.getType('${fieldInfo.lowerColName}')}" class="form-control m-b"<#if fieldInfo.isNotNull> required</#if>>
                        <option value="">请选择</option>
                        <option th:each="dict : ${"$"}{type}" th:text="${"$"}{dict.dictLabel}" th:value="${"$"}{dict.dictValue}"></option>
                    </select>
                        <#elseif fieldInfo.isDateType>
                    <input type="text" id="${fieldInfo.proName}Add" name="${fieldInfo.proName}" placeholder="${fieldInfo.simpleRemark}" class="form-control time-input" readonly<#if fieldInfo.isNotNull> required</#if>/>
                        <#elseif fieldInfo.isNumericType>
                    <input type="number" id="${fieldInfo.proName}Add" name="${fieldInfo.proName}" placeholder="${fieldInfo.simpleRemark}" class="form-control"/>
                        <#elseif fieldInfo.isMultiLineType>
                    <textarea id="${fieldInfo.proName}Add" name="${fieldInfo.proName}" maxlength="${fieldInfo.length}" placeholder="${fieldInfo.simpleRemark}" class="form-control" rows="3"></textarea>
                        <#elseif fieldInfo.isRichTextType>
                            <#assign hasRichTextType = true />
                            <#assign richTextField = fieldInfo.proName />
                    <input type="hidden" id="${fieldInfo.proName}Add" name="${fieldInfo.proName}"/>
                    <div id="${fieldInfo.proName}Editor" class="summernote"></div>
                        <#else>
                    <input type="text" id="${fieldInfo.proName}Add" name="${fieldInfo.proName}" placeholder="${fieldInfo.simpleRemark}" class="form-control"<#if fieldInfo.isNotNull> required</#if>/>
                    </#if>
                </div>
            </div>
            </#list>
        </#if>
        </form>
    </div>
    <th:block th:include="include :: footer" />
<#if hasRichTextType??>
    <th:block th:include="include :: summernote-js" />
</#if>

    <script type="text/javascript">
        var prefix = ctx + "${jsonParam.moduleName}/${tableInfo.lowerCamelCase}";

<#if hasRichTextType??>
        $(function () {
            $('#form-${tableInfo.lowerCamelCase}-add').validate({
                focusCleanup: true
            });

            $('.summernote').summernote({
                placeholder: '请输入${tableInfo.simpleRemark}',
                height: 200,
                lang: 'zh-CN',
                followingToolbar: false,
                dialogsInBody: true,
                callbacks: {
                    onImageUpload: function (files) {
                        imageUpload(files[0], this);
                    }
                }
            });
        });

        function imageUpload(file, obj) {
            var data = new FormData()
            data.append('file', file)
            $.ajax({
                type: 'POST',
                url: ctx + 'common/upload',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                dataType: 'json',
                success: function (result) {
                    if (result.code == web_status.SUCCESS) {
                        $(obj).summernote('editor.insertImage', result.url, result.fileName);
                    } else {
                        $.modal.alertError(result.msg);
                    }
                },
                error: function (error) {
                    $.modal.alertWarning('图片上传失败！');
                }
            });
        }

</#if>
        function submitHandler() {
            if ($.validate.form()) {
<#if hasRichTextType??>
                var content = $('.summernote').summernote('code');
                $('#${richTextField}Add').val(content);
</#if>
                $.operate.save(prefix + '/add', $('#form-${tableInfo.lowerCamelCase}-add').serialize());
            }
        }
	</script>
</body>
</html>