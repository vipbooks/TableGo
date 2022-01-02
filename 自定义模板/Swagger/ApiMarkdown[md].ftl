<#-- 用于生成Markdown的SwaggerAPI文档的自定义模板 -->
<#if swaggerApiData?has_content>
    <#if swaggerApiData.info?has_content>
## ${swaggerApiData.info.description!swaggerApiData.info.title}

[toc]

### 1、概述

#### &emsp;&emsp;1.1、项目信息

&emsp;&emsp;&emsp;&emsp;标题：${swaggerApiData.info.title}

&emsp;&emsp;&emsp;&emsp;描述：${swaggerApiData.info.description}

&emsp;&emsp;&emsp;&emsp;版本：${swaggerApiData.info.version}

&emsp;&emsp;&emsp;&emsp;域名：${swaggerApiData.info.host}

&emsp;&emsp;&emsp;&emsp;项目路径：${swaggerApiData.info.basePath}
    </#if>

#### &emsp;&emsp;1.2、功能模块

<#if swaggerApiData.tagList?has_content>
    <#list swaggerApiData.tagList as tag>
&emsp;&emsp;&emsp;&emsp;${tag_index + 1}、${tag.name}<#if StringUtils.isNotBlank(tag.description)>：${tag.description}</#if>

    </#list>
</#if>
### 2、API接口

<#if swaggerApiData.tagList?has_content>
    <#list swaggerApiData.tagList as tag>
#### &emsp;&emsp;2.${tag_index + 1}、<#if StringUtils.isNotBlank(tag.description)>${tag.name}（${tag.description}）<#else>${tag.name}</#if>

        <#if tag.pathList?has_content>
            <#list tag.pathList as path>
##### &emsp;&emsp;&emsp;&emsp;2.${tag_index + 1}.${path_index + 1}、${path.summary}

&emsp;&emsp;&emsp;&emsp;${path.method}&emsp;&emsp;${path.path}

&emsp;&emsp;&emsp;&emsp;**参数：**

| 序号 | 操作类型 | 参数名称 | 参数类型 | 是否必填 | 参数说明 |
|:---:|  :---:  |   ---   |   ---   |  :---:  |   ---   |
                <#if path.parameterList?has_content>
                    <#list path.parameterList as parameter>
| ${parameter_index + 1} | ${parameter.in} | ${parameter.name} | ${parameter.type} | ${parameter.must} | ${parameter.description} |
                    </#list>
                </#if>

&emsp;&emsp;&emsp;&emsp;**响应：**

| HTTP代码 | 说明 | 类型 |
|  :---:  |  --- | --- |
                <#if path.responseList?has_content>
                    <#list path.responseList as response>
| ${response.code} | ${response.description} | ${response.type} |
                    </#list>
                </#if>

&emsp;&emsp;&emsp;&emsp;**HTTP请求示例：**

&emsp;&emsp;&emsp;&emsp;请求Path：${path.path}

                <#if path.httpRequestExample?has_content>
&emsp;&emsp;&emsp;&emsp;请求参数：

                    <#list path.httpRequestExample as example>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${example}

                    </#list>
                </#if>
                <#if path.httpResponseExample?has_content>
&emsp;&emsp;&emsp;&emsp;**HTTP响应示例：**

&emsp;&emsp;&emsp;&emsp;响应 200：

                    <#list path.httpResponseExample as example>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${example}

                    </#list>
                </#if>
            </#list>
        </#if>
    </#list>
</#if>
<#if swaggerApiData.modelList?has_content>
### 3、数据模型

    <#list swaggerApiData.modelList as model>
**&emsp;&emsp;3.${model_index + 1}、<#if StringUtils.isNotBlank(model.description)>${model.description}（${model.name}）<#else>${model.name}</#if>**

| 序号 | 名称 | 类型 | 说明 |
| :---:|  --- |  --- |  --- |
        <#if model.propertyList?has_content>
            <#list model.propertyList as property>
| ${property_index + 1} | ${property.name} | ${property.type} | ${property.description} |
            </#list>
        </#if>

    </#list>
</#if>
</#if>