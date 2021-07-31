<#-- 自定义模板生成导出数据生成数据字典SQL -->
TRUNCATE TABLE T_DICT_TYPE;
TRUNCATE TABLE T_DICTIONARY;
<#if CollectionUtils.isNotEmpty(tableInfoList)>
    <#list tableInfoList as tableInfo>
        <#if tableInfo.sqlQueryDataList?has_content>
            <#list tableInfo.sqlQueryDataList as dictType>

INSERT INTO T_DICT_TYPE VALUES (UUID(), '${dictType.TYPE_NAME}', '${dictType.TYPE_CODE}', null, '-1', NOW(), '-1', NOW(), 1);

                <#if dictType.sqlQueryDataList?has_content>
                    <#list dictType.sqlQueryDataList as dict>
INSERT INTO T_DICTIONARY VALUES (UUID(), '${dict.DICT_TYPE_CODE}', '${dict.DICT_NAME}', '${dict.DICT_CODE}', ${dict_index + 1}, null, '-1', NOW(), '-1', NOW(), 1);
                    </#list>
                </#if>

            </#list>
        </#if>
    </#list>
</#if>