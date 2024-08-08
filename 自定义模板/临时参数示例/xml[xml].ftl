<#-- 用于生成XML数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：id, username, phone
临时参数2：1, test, 18666668888
临时参数3：xxx[all]
-->
<?xml version="1.0" encoding="UTF-8"?>

<#if tempParamMap?has_content>
<list>
    <#list tempParamMap?values as tempParamList>
        <#if tempParamList_index == 0><#continue></#if>
    <item>
        <#list tempParamMap.tempParam1 as key>
        <${key}>${tempParamList[key_index]}</${key}>
        </#list>
    </item>
    </#list>
</list>
</#if>