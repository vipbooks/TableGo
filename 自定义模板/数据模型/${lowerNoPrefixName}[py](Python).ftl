<#-- 用于生成Python数据模型的自定义模板 -->

# <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
# Created by ${paramConfig.author} on ${today}.
class ${tableInfo.upperCamelCase}(models.Model):
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if fieldInfo.javaType == "Date">
    ${fieldInfo.lowerColName} = models.DateTimeField(
            <#if fieldInfo.unique>
        unique=True,
            <#elseif fieldInfo.isNotNull>
        null=True, blank=True,
            </#if>
        default=timezone.datetime.now,
        verbose_name="${fieldInfo.simpleRemark}",
        help_text="${fieldInfo.remark}"
    )
        <#elseif fieldInfo.javaType == "BigDecimal">
    ${fieldInfo.lowerColName} = models.DecimalField(
            <#if fieldInfo.unique>
        unique=True,
            <#elseif fieldInfo.isNotNull>
        null=True, blank=True,
            </#if>
        max_digits=${fieldInfo.length}, decimal_places=${fieldInfo.decimalDigits},
        verbose_name="${fieldInfo.simpleRemark}",
        help_text="${fieldInfo.remark}"
    )
        <#elseif fieldInfo.javaType == "Integer">
    ${fieldInfo.lowerColName} = models.IntegerField(
            <#if fieldInfo.unique>
        unique=True,
            <#elseif fieldInfo.isNotNull>
        null=True, blank=True,
            </#if>
        default=0,
        verbose_name="${fieldInfo.simpleRemark}",
        help_text="${fieldInfo.remark}"
    )
        <#else>
    ${fieldInfo.lowerColName} = models.CharField(
            <#if fieldInfo.unique>
        unique=True,
            <#elseif fieldInfo.isNotNull>
        null=True, blank=True,
            </#if>
        max_length=${fieldInfo.length},
        verbose_name="${fieldInfo.simpleRemark}",
        help_text="${fieldInfo.remark}"
    )
        </#if>
    </#list>
</#if>
