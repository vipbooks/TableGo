<#-- 用于生成MyBatis数据模型的自定义模板 -->
<#-- 初始化全局忽略验证的字段 -->
<#assign globalIgnoreValidFields = jsonParam.globalIgnoreValidFields />
<#-- 初始化需要导出Excel的字段 -->
<#assign exportFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.exportFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(tableInfo, "Date")>
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
<#elseif FtlUtils.fieldTypeExisted(tableInfo, "Long")>
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
import com.ruoyi.common.core.domain.BaseEntity;
<#else>
import java.io.Serializable;
</#if>
<#if FtlUtils.fieldAtListExisted(tableInfo, exportFields)>
import com.ruoyi.common.annotation.Excel;
</#if>
<#assign importNotBlank = false />
<#assign importNotNull = false />
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey && fieldInfo.isNotNull && !FtlUtils.fieldExisted(fieldInfo, globalIgnoreValidFields)>
            <#if !importNotBlank && fieldInfo.javaType == "String">
                <#assign importNotBlank = true />
import javax.validation.constraints.NotBlank;
            <#elseif !importNotNull && fieldInfo.javaType != "String">
                <#assign importNotNull = true />
import javax.validation.constraints.NotNull;
            </#if>
        </#if>
    </#list>
</#if>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 *
* @author ${paramConfig.author}
* @version 1.0.0 ${today}
 */
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
public class ${tableInfo.upperCamelCase} <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>extends BaseEntity<#else>implements Serializable</#if> {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
<#if tableInfo.fieldInfos?has_content>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 1)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if FtlUtils.fieldEquals(fieldInfo, "remark")><#continue></#if>

    @ApiModelProperty(value = "${fieldInfo.remark}")
    <#if FtlUtils.fieldExisted(fieldInfo, exportFields)>
    @Excel(name = "${fieldInfo.simpleRemark}")
    </#if>
    <#if !fieldInfo.primaryKey && fieldInfo.isNotNull && !FtlUtils.fieldExisted(fieldInfo, globalIgnoreValidFields)>
        <#if fieldInfo.javaType == "String">
    @NotBlank(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        <#else>
    @NotNull(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        </#if>
    </#if>
    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateType>"yyyy-MM-dd"<#else>"yyyy-MM-dd HH:mm:ss"</#if>)
    <#elseif fieldInfo.javaType == "Long">
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
    </#if>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 2)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if FtlUtils.fieldEquals(fieldInfo, "remark")><#continue></#if>

    <#if paramConfig.buildFieldRemark == 0>
    /**
     * 获取${fieldInfo.remark!fieldInfo.proName}
     * 
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}
     */
    </#if>
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}() {
        return this.${fieldInfo.proName};
    }

    <#if paramConfig.buildFieldRemark == 0>
    /**
     * 设置${fieldInfo.remark!fieldInfo.proName}
     * 
     * @param ${fieldInfo.proName}<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)> ${fieldInfo.simpleRemark}</#if>
     */
    </#if>
    public void set${fieldInfo.upperCamelCase}(${fieldInfo.javaType} ${fieldInfo.proName}) {
        this.${fieldInfo.proName} = ${fieldInfo.proName};
    }
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 2)} */
    </#if>
</#if>

    @Override
    public boolean equals(Object obj) {
        return EqualsBuilder.reflectionEquals(obj, this);
    }

    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}