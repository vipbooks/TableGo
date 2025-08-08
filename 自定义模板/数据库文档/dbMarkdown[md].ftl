<#-- 用于生成Markdown数据库设计文档的自定义模板 -->
## ${docTitle}

[toc]
<#list tableInfoList as tableInfo>

### ${tableInfo_index + 1}、<#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}（${tableInfo.tableName}）<#else>${tableInfo.tableName}</#if>

| 序号 | 字段名 | 数据类型 | 主键 | 非空 | 默认值 | 注释 |
| :---: |  ---  |   ---   | :---:|:---:| :---: |  --- |
    <#if tableInfo.fieldInfos?has_content>
        <#list tableInfo.fieldInfos as fieldInfo>
| ${fieldInfo_index + 1} | ${fieldInfo.colName} | ${fieldInfo.dataTypeStr} | <#if fieldInfo.primaryKey>是<#else>否</#if> | <#if fieldInfo.primaryKey>是<#elseif fieldInfo.nullable == "false">是<#else>否</#if> | ${fieldInfo.defaultValue} | ${fieldInfo.remark} |
        </#list>
    </#if>
</#list>