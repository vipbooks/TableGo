<#-- 用于生成批量修改表数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：1,2,3
临时参数2：test1, 1
-->
-- 批量修改表数据SQL例示
<#if tempParamList?has_content>
UPDATE T_USER SET USERNAME = '${tempParamMap.tempParam2[0]}', USER_TYPE = '${tempParamMap.tempParam2[1]}' WHERE ID IN(<#list tempParamMap.tempParam1 as param>'${param}'<#if param_has_next>, </#if></#list>);
</#if>