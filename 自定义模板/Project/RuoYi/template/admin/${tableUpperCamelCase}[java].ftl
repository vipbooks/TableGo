<#-- 用于生成MyBatis数据模型的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.batchSearchFields) />
<#-- 初始化全局忽略验证的字段 -->
<#assign globalIgnoreValidFields = jsonParam.globalIgnoreValidFields />
<#-- 初始化需要导入导出Excel的字段 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.importAndExportFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(tableInfo, "Date") || FtlUtils.fieldTypeExisted(searchFields, "Date")>
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
<#if FtlUtils.fieldAtListExisted(tableInfo, importAndExportFields)>
import com.ruoyi.common.annotation.Excel;
</#if>
<#if batchSearchFields?has_content>
import java.util.List;
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
 * ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.remark}(${tableInfo.tableName})", tableInfo.tableName)}
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
public class ${tableInfo.upperCamelCase} <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>extends BaseEntity<#else>implements Serializable</#if> {
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
        <#if FtlUtils.fieldEquals(fieldInfo, "remark")><#continue></#if>

    @ApiModelProperty(value = "${fieldInfo.remark}")
    <#if FtlUtils.fieldExisted(fieldInfo, importAndExportFields)>
    @Excel(name = "${fieldInfo.simpleRemark}")
    </#if>
    <#if !fieldInfo.primaryKey && fieldInfo.isNotNull && !FtlUtils.fieldExisted(fieldInfo, globalIgnoreValidFields)>
        <#if fieldInfo.isStringType>
    @NotBlank(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        <#else>
    @NotNull(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        </#if>
    </#if>
    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateTimeType>"yyyy-MM-dd HH:mm:ss"<#else>"yyyy-MM-dd"</#if>)
    <#elseif fieldInfo.javaType == "Long">
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
    </#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>

    @ApiModelProperty(value = "${fieldInfo.remark}(开始)")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

    @ApiModelProperty(value = "${fieldInfo.remark}(结束)")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
            </#if>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>

    /** ${fieldInfo.simpleRemark}列表 */
    @ApiModelProperty(value = "${fieldInfo.simpleRemark}列表")
    private List<${fieldInfo.javaType}> ${fieldInfo.proName}List;
        </#list>
    </#if>
    <#if searchFields?has_content>
        <#list searchFields as fieldInfo>
            <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>

    /**
     * 获取${fieldInfo.remark}(开始)
     * 
     * @return ${fieldInfo.remark}(开始)
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}Begin() {
        return this.${fieldInfo.proName}Begin;
    }

    /**
     * 设置${fieldInfo.remark}(开始)
     * 
     * @param ${fieldInfo.proName}Begin ${fieldInfo.remark}(开始)
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}Begin(${fieldInfo.javaType} ${fieldInfo.proName}Begin) {
        this.${fieldInfo.proName}Begin = ${fieldInfo.proName}Begin;
        return this;
    }

    /**
     * 获取${fieldInfo.remark}(结束)
     * 
     * @return ${fieldInfo.remark}(结束)
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}End() {
        return this.${fieldInfo.proName}End;
    }

    /**
     * 设置${fieldInfo.remark}(结束)
     * 
     * @param ${fieldInfo.proName}End ${fieldInfo.remark}(结束)
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}End(${fieldInfo.javaType} ${fieldInfo.proName}End) {
        this.${fieldInfo.proName}End = ${fieldInfo.proName}End;
        return this;
    }
            </#if>
        </#list>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>

    /**
     * 获取${fieldInfo.simpleRemark}列表
     * 
     * @return ${fieldInfo.simpleRemark}列表
     */
    public List<${fieldInfo.javaType}> get${fieldInfo.upperCamelCase}List() {
        return this.${fieldInfo.proName}List;
    }

    /**
     * 设置${fieldInfo.simpleRemark}列表
     * 
     * @param ${fieldInfo.proName}List ${fieldInfo.simpleRemark}列表
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}List(List<${fieldInfo.javaType}> ${fieldInfo.proName}List) {
        this.${fieldInfo.proName}List = ${fieldInfo.proName}List;
        return this;
    }
        </#list>
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
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}(${fieldInfo.javaType} ${fieldInfo.proName}) {
        this.${fieldInfo.proName} = ${fieldInfo.proName};
        return this;
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