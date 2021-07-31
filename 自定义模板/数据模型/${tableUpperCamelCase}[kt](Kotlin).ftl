<#-- 用于生成Kotlin数据模型的自定义模板 -->
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(tableInfo, "Date")>
import java.util.Date
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigDecimal")>
import java.math.BigDecimal
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
import io.swagger.annotations.ApiModel
import io.swagger.annotations.ApiModelProperty
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
class ${tableInfo.upperCamelCase} : java.io.Serializable {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>

    @ApiModelProperty(value = "${fieldInfo.remark}", position = ${fieldInfo_index + 1})
    @JsonProperty(index = ${fieldInfo_index + 1})
    <#if fieldInfo.javaType == "Integer">
    var ${fieldInfo.proName}: Int? = 0
    <#elseif fieldInfo.javaType == "Long">
    var ${fieldInfo.proName}: ${fieldInfo.javaType}? = 0L
    <#elseif fieldInfo.javaType == "Float">
    var ${fieldInfo.proName}: ${fieldInfo.javaType}? = 0.0F
    <#elseif fieldInfo.javaType == "Double">
    var ${fieldInfo.proName}: ${fieldInfo.javaType}? = 0.0
    <#else>
    var ${fieldInfo.proName}: ${fieldInfo.javaType}? = null
    </#if>
    </#list>
</#if>
}