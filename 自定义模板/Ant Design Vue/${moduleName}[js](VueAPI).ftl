<#-- 用于生成Vue后台JS接口的自定义模板 -->
<#if jsonParam?has_content && jsonParam.contextPath?has_content>
    <#assign contextPath = jsonParam.contextPath />
</#if>
import {axios} from '@/utils/request'

<#if swaggerApiData?has_content && swaggerApiData.tagList?has_content>
<#if paramConfig.showMergeUpdateMark>
/* ${String.format(paramConfig.mergeFileMarkBegin, 1)} */

</#if>
    <#list swaggerApiData.tagList as tag>
/**
 * ${tag.name}
 * Author: ${paramConfig.author}
 * DateTime: ${dateTime}
 */
        <#if !tag.pathList?has_content><#continue></#if>
        <#list tag.pathList as path>
            <#if path.parameterList?has_content>
                <#assign paramsExisted = false />
                <#list path.parameterList as parameter>
                    <#if parameter.in == "Body">
                        <#assign paramsExisted = true />
                        <#assign paramsType = "data: parameter" />
                        <#break>
                    <#elseif parameter.in == "Query">
                        <#assign paramsExisted = true />
                        <#assign paramsType = "params: parameter" />
                        <#break>
                    <#elseif parameter.in == "Path">
                        <#assign paramsExisted = true />
                        <#assign paramsType = "path" />
                        <#break>
                    </#if>
                </#list>
            </#if>
// ${path.summary}
export function ${path.name} (<#if paramsExisted>parameter</#if>) {
    return axios({
        method: '${path.method?lower_case}',
        <#if paramsType?? && paramsType == "path">
        url: '${contextPath}${path.path?substring(0, StringUtils.lastIndexOf(path.path,"/"))}/' + parameter
        <#else>
        url: '${contextPath}${path.path}'<#if paramsExisted && paramsType != "path">,</#if>
        </#if>
        <#if paramsExisted && paramsType != "path">
        ${paramsType}
        </#if>
    })
}

        </#list>
    </#list>
<#if paramConfig.showMergeUpdateMark>
/* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
</#if>
</#if>