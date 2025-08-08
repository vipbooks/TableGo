<#-- 用于生成表字段比较的自定义模板 -->
<#--
通过表字段与业务文档中的业务字段比较，快速找到与表字段匹配不上的业务字段
模板使用配置说明：
1、在公共参数的精确匹配中配置需要参与比较的表
2、从文档中复制需要参与比较的字段名，支持对表字段备注和字段名的比较，多个用英文逗号分隔，支持复制带换行的文本
3、打开生成自定义文件选择表字段比较模板，然后用快捷键把复制的要参与比较的字段名粘贴到临时参数的临时参数01里面，例如：
    临时参数01：用户名,姓名,移动电话,身份证,电子邮箱,出生日期
4、生成表字段比较的MD文件
-->
## ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.remark}(${tableInfo.tableName})", tableInfo.tableName)}表字段比较

| 序号 | 表字段备注 | 表字段名 | 比较字段名 | 是否匹配 |
| :---: |   ---   |   ---   |   ---   | :---: |
<#if tempParamMap.tempParam1?has_content>
    <#assign index = 0 />
    <#assign comparedFieldList = FtlUtils.createEmptyList() />
    <#assign tempParamList = FtlUtils.listDistinct(tempParamMap.tempParam1) />
    <#list tempParamList as tempParam>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if !(StringUtils.contains(fieldInfo.remark, tempParam) || FtlUtils.fieldExisted(fieldInfo, tempParam)) || CollectionUtils.containsAny(comparedFieldList, fieldInfo.colName)><#continue/></#if>
            <#assign comparedFieldList = FtlUtils.listAddElement(comparedFieldList, fieldInfo.colName) />
            <#assign index = index + 1 />
| ${index} | ${fieldInfo.simpleRemark} | ${fieldInfo.colName} | ${tempParam} | 是 |
        </#list>
    </#list>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list tempParamList as tempParam>
            <#if StringUtils.contains(fieldInfo.remark, tempParam) || FtlUtils.fieldExisted(fieldInfo, tempParam) || CollectionUtils.containsAny(comparedFieldList, fieldInfo.colName)><#continue/></#if>
            <#assign comparedFieldList = FtlUtils.listAddElement(comparedFieldList, fieldInfo.colName) />
            <#assign index = index + 1 />
| ${index} | ${fieldInfo.simpleRemark} | ${fieldInfo.colName} |  | 否 |
        </#list>
    </#list>
    <#list tempParamList as tempParam>
        <#assign tempParamExisted = false />
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if StringUtils.contains(fieldInfo.remark, tempParam) || FtlUtils.fieldExisted(fieldInfo, tempParam)>
                <#assign tempParamExisted = true />
            </#if>
        </#list>
        <#if !tempParamExisted>
            <#assign index = index + 1 />
| ${index} |  |  | ${tempParam} | 否 |
        </#if>
    </#list>
</#if>
