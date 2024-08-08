<#-- 用于生成JSON数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：id, username, phone
临时参数2：1, test, 18666668888
临时参数3：xxx[all]
-->
<#if tempParamMap?has_content>
[
    <#list tempParamMap?values as tempParamList>
        <#if tempParamList_index == 0><#continue></#if>
    {
        <#list tempParamMap.tempParam1 as key>
      "${key}": "${tempParamList[key_index]}"<#if key_has_next>,</#if>
        </#list>
    }<#if tempParamList_has_next>,</#if>
    </#list>
]
</#if>