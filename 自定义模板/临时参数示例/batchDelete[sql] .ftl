<#-- 用于生成批量删除表数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：80666,80820,80160,80150,60226,60546,60616,60828,60886,60666,60828,60680
-->
-- 批量删除表数据SQL例示
<#if tempParamMap?has_content && tempParamMap.tempParam1?has_content>
DELETE FROM T_USER WHERE ID IN(
    <#list FtlUtils.partition(tempParamMap.tempParam1, 5) as idList>
    <#list idList as id>'${id}'<#if id_has_next>, </#if></#list><#if idList_has_next>,</#if>
    </#list>
);
</#if>