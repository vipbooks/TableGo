<#-- Swagger2自定义模板参数转JSON字符串测试 -->
jsonParam: ${JsonUtils.objToJson(jsonParam)}

swaggerApiData: ${JsonUtils.objToJson(swaggerApiData)}

<#if swaggerApiData?has_content>
    <#list swaggerApiData?keys as key>
key: ${key}
value: ${JsonUtils.objToJson(swaggerApiData[key])}

    </#list>
modelList.forEach:
    <#if swaggerApiData.modelList?has_content>
        <#list swaggerApiData.modelList as model>
            <#if model.name?index_of("Enum") != -1>
                <#continue>
            </#if>
    model.name: ${model.name}, model.description: ${model.description}, model.type: ${model.type}
    model.propertyList: ${JsonUtils.objToJson(model.propertyList)}

        </#list>
    </#if>
tagList.forEach:
    <#if swaggerApiData.tagList?has_content>
        <#list swaggerApiData.tagList as tag>
    tag.name: ${tag.name}, tag.description: ${tag.description}, tag.module: ${tag.module}
    tag.pathList: ${JsonUtils.objToJson(tag.pathList)}

        </#list>
    </#if>
tag.pathList.forEach:
    <#if swaggerApiData.tagList?has_content>
        <#list swaggerApiData.tagList as tag>
    tag.name: ${tag.name}, tag.description: ${tag.description}, tag.module: ${tag.module}
            <#if tag.pathList?has_content>
                <#list tag.pathList as path>
        path.summary: ${path.summary}, path.path: ${path.path}, path.name: ${path.name}, path.method: ${path.method}, path.consumes: ${JsonUtils.objToJson(path.consumes)}
        path.parameterList: ${JsonUtils.objToJson(path.parameterList)}
        path.responseList: ${JsonUtils.objToJson(path.responseList)}
        path.httpRequestExample: ${JsonUtils.objToJson(path.httpRequestExample)}
        path.httpResponseExample: ${JsonUtils.objToJson(path.httpResponseExample)}

                </#list>
            </#if>
        </#list>
    </#if>
</#if>