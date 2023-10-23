<#-- 自定义模板生成从数据库查字典表数据测试 -->

sqlQueryData: ${JsonUtils.objToJson(sqlQueryData)}

<#if sqlQueryData?has_content>
    <#if sqlQueryData.dictTypeList?has_content>
dictTypeList: ${JsonUtils.objToJson(sqlQueryData.dictTypeList)}

dictTypeStrMap: ${FtlUtils.listToStrMap(sqlQueryData.dictTypeList, "TYPE_CODE", "TYPE_NAME")}

dictTypeObjMap: ${FtlUtils.listToObjMap(sqlQueryData.dictTypeList, "TYPE_CODE")}

dictTypeNameList: ${FtlUtils.listToFieldValues(sqlQueryData.dictTypeList, "TYPE_NAME")}
    </#if>

    <#if sqlQueryData.dictList?has_content>
dictList: ${JsonUtils.objToJson(sqlQueryData.dictList)}

<#assign dictTypeGroupMap = FtlUtils.listGroup(sqlQueryData.dictList, "DICT_TYPE_CODE") />
dictTypeGroupMap: ${dictTypeGroupMap}
<#list dictTypeGroupMap.keySet() as dictTypeCode>

${dictTypeCode}:
    <#list dictTypeGroupMap[dictTypeCode] as dictType>
    dictList: ${JsonUtils.objToJson(dictType)}
    </#list>
</#list>

dictStrMap: ${FtlUtils.listToStrMap(sqlQueryData.dictList, "DICT_CODE", "DICT_NAME")}

dictObjMap: ${FtlUtils.listToObjMap(sqlQueryData.dictList, "DICT_CODE")}
    </#if>
</#if>