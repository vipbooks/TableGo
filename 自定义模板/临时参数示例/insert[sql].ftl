<#-- 用于生成从Excel中横向复制过来的数据生成新增表数据的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：1,test1,1
临时参数2：2,test2,2
临时参数3：3,test3,1
-->
-- 新增表数据SQL例示
<#if tempParamMap?has_content>
    <#list tempParamMap?values as tempParamList>
INSERT INTO T_USER(ID, USERNAME, USER_TYPE) VALUES (<#list tempParamList as param>'${param}'<#if param_has_next>, </#if></#list>);
    </#list>
</#if>