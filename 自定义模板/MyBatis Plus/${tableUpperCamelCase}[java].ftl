<#-- 用于生成MyBatisPlus数据模型的自定义模板 -->
<#-- 初始化全局忽略验证的字段 -->
<#assign globalIgnoreValidFields = jsonParam.globalIgnoreValidFields />
<#-- 初始化表要忽略验证的字段 -->
<#assign tableIgnoreValidFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.tableIgnoreValidFields) />
<#-- 初始化表的模糊查询字段 -->
<#assign likeFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.likeFields) />
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
<#if FtlUtils.fieldAtListExisted(tableInfo, likeFields)>
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.SqlCondition;
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
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

<#if tableInfo.fieldInfos?has_content>
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
</#if>
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
import lombok.EqualsAndHashCode;
</#if>
import lombok.Data;
import lombok.Builder;
import lombok.experimental.Accessors;

<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
import ${jsonParam.basePackagePath}.common.model.BaseBean;
<#else>
import ${jsonParam.basePackagePath}.common.model.OverrideBeanMethods;
</#if>

/**
 * ${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.remark}(${tableInfo.tableName})", tableInfo.tableName)}
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Builder
<#if tableInfo.fieldInfos?has_content>
@NoArgsConstructor
@AllArgsConstructor
</#if>
@Accessors(chain = true)
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
@EqualsAndHashCode(callSuper = true)
</#if>
@ApiModel(description = "${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}")}")
@TableName("${tableInfo.tableName}")
public class ${tableInfo.upperCamelCase} extends <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>BaseBean<#else>OverrideBeanMethods</#if> {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
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
    <#if fieldInfo.primaryKey>
    @TableId
    </#if>
    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateTimeType>DatePattern.NORM_DATETIME_PATTERN<#else>DatePattern.NORM_DATE_PATTERN</#if>)
    <#elseif fieldInfo.javaType == "Long">
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    </#if>
    <#if FtlUtils.fieldExisted(likeFields, fieldInfo.colName)>
    @TableField(condition = SqlCondition.LIKE)
    </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
    </#if>
</#if>
}