<#-- 用于生成MyBatis数据模型的自定义模板 -->
<#-- 初始化全局忽略验证的字段 -->
<#assign globalIgnoreValidFields = jsonParam.globalIgnoreValidFields />
<#-- 初始化表要忽略验证的字段 -->
<#assign tableIgnoreValidFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.tableIgnoreValidFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(tableInfo, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
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
import ${jsonParam.basePackagePath}.common.model.BaseBean;
<#else>
import ${jsonParam.basePackagePath}.common.model.OverrideBeanMethods;
</#if>
<#assign importNotBlank = false />
<#assign importNotNull = false />
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey && fieldInfo.isNotNull && !FtlUtils.fieldExisted(fieldInfo, globalIgnoreValidFields) && !FtlUtils.fieldExisted(fieldInfo, tableIgnoreValidFields)>
            <#if !importNotBlank && fieldInfo.isStringType>
                <#assign importNotBlank = true />
import javax.validation.constraints.NotBlank;
            <#elseif !importNotNull && !fieldInfo.isStringType>
                <#assign importNotNull = true />
import javax.validation.constraints.NotNull;
            </#if>
        </#if>
    </#list>
</#if>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.remark}(${tableInfo.tableName})", tableInfo.tableName)}
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@ApiModel(description = "${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}")}")
public class ${tableInfo.upperCamelCase} extends <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>BaseBean<#else>OverrideBeanMethods</#if> {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;

    /** 创建${tableInfo.simpleRemark}实例对象 */
    public static ${tableInfo.upperCamelCase} newInstance() {
        return new ${tableInfo.upperCamelCase}();
    }
<#if tableInfo.fieldInfos?has_content>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 1)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>

    @ApiModelProperty(value = "${fieldInfo.remark}")
        <#if !fieldInfo.primaryKey && fieldInfo.isNotNull && !FtlUtils.fieldExisted(fieldInfo, globalIgnoreValidFields) && !FtlUtils.fieldExisted(fieldInfo, tableIgnoreValidFields)>
            <#if fieldInfo.isStringType>
    @NotBlank(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空")
            <#else>
    @NotNull(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空")
            </#if>
        </#if>
        <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateTimeType>DatePattern.NORM_DATETIME_PATTERN<#else>DatePattern.NORM_DATE_PATTERN</#if>)
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

    /**
     * 获取${fieldInfo.remark!fieldInfo.proName}
     * 
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}() {
        return this.${fieldInfo.proName};
    }

    /**
     * 设置${fieldInfo.remark!fieldInfo.proName}
     * 
     * @param ${fieldInfo.proName}<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)> ${fieldInfo.simpleRemark}</#if>
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}(${fieldInfo.javaType} ${fieldInfo.proName}) {
        this.${fieldInfo.proName} = ${fieldInfo.proName};
        return this;
    }
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 2)} */
    </#if>
</#if>
}