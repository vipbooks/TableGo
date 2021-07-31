<#-- 用于生成JavaBean的Getter、Setter方法的自定义模板 -->
<#if tableInfoList?has_content>
    <#list tableInfoList as tableInfo>
    /****************************** <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if> ******************************/
        <#if tableInfo.fieldInfos?has_content>
            <#list tableInfo.fieldInfos as fieldInfo>
    ${tableInfo.lowerCamelCase}1.set${fieldInfo.upperCamelCase}(${tableInfo.lowerCamelCase}2.get${fieldInfo.upperCamelCase}());
            </#list>
            
            
            <#list tableInfo.fieldInfos as fieldInfo>
    ${fieldInfo.javaType} ${fieldInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}();
            </#list>
        </#if>
        
    </#list>
</#if>