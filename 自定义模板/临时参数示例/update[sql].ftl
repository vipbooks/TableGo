<#-- 用于生成从Excel中纵向复制过来的数据生成修改表数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：1,2,3
临时参数2：test1,test2,test3
临时参数3：1[all]
-->
-- 修改表数据SQL例示
<#if tempParamList?has_content>
    <#list tempParamList as param>
UPDATE T_USER SET USERNAME = '${param.tempParam2}', USER_TYPE = '${param.tempParam3}' WHERE ID = '${param.tempParam1}';
    </#list>
</#if>