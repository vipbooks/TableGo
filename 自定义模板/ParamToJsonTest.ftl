<#-- 自定义模板参数转JSON字符串测试 -->
dbConfig: ${JsonUtils.objToJson(dbConfig)}

paramConfig: ${JsonUtils.objToJson(paramConfig)}

jsonParam: ${JsonUtils.objToJson(jsonParam)}

tableInfo: ${JsonUtils.objToJson(tableInfo)}

swaggerApiData: ${JsonUtils.objToJson(swaggerApiData)}

tempParamMap: ${JsonUtils.objToJson(tempParamMap)}

tempParamList: ${JsonUtils.objToJson(tempParamList)}

excelDataList: ${JsonUtils.objToJson(excelDataList)}

sqlQueryData: ${JsonUtils.objToJson(sqlQueryData)}
<#if sqlQueryData?has_content && sqlQueryData.dictList?has_content>

dictList: ${JsonUtils.objToJson(sqlQueryData.dictList)}

dictTypeGroup: ${FtlUtils.listGroup(sqlQueryData.dictList, "DICT_TYPE_CODE")}

dictStrMap: ${FtlUtils.listToStrMap(sqlQueryData.dictList, "DICT_CODE", "DICT_NAME")}

dictObjMap: ${FtlUtils.listToObjMap(sqlQueryData.dictList, "DICT_CODE")}
</#if>

<#if tableInfoList?has_content>
tableInfoList: ${JsonUtils.objToJson(tableInfoList)}

    <#list tableInfoList as tableInfo>
    tableInfo: ${JsonUtils.objToJson(tableInfo)}
    <#if tableInfo.sqlQueryData?has_content>

        sqlQueryData: ${JsonUtils.objToJson(tableInfo.sqlQueryData)}
    </#if>
    <#if tableInfo.sqlQueryDataList?has_content>

        sqlQueryDataList: ${JsonUtils.objToJson(tableInfo.sqlQueryDataList)}
    </#if>

        <#if tableInfo.fieldInfos?has_content>
            <#list tableInfo.fieldInfos as fieldInfo>
        fieldInfo: ${JsonUtils.objToJson(fieldInfo)}

            </#list>
        </#if>
    </#list>
</#if>