<#-- 初始化表的模糊查询字段 -->
<#assign likeFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.likeFeilds) />
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
<#if FtlUtils.fieldAtListExisted(tableInfo, likeFeilds)>
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.SqlCondition;
</#if>
<#assign importNotBlank = false />
<#assign importNotNull = false />
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#if !fieldInfo.primaryKey && fieldInfo.isNotNull>
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
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.logFields)>
import ${jsonParam.basePackagePath}.common.model.BaseBean;
<#else>
import ${jsonParam.basePackagePath}.common.model.OverrideBeanMethods;
</#if>

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Setter
@Getter
@Accessors(chain = true)
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
</#if>
@TableName("${tableInfo.tableName}")
public class ${tableInfo.upperCamelCase} extends <#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.logFields)>BaseBean<#else>OverrideBeanMethods</#if> {
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

        <#if jsonParam.enableSmartDoc?? && jsonParam.enableSmartDoc>
    /** ${fieldInfo.remark} */
        <#else>
    @ApiModelProperty(value = "${fieldInfo.remark}", position = ${fieldInfo_index + 1})
        </#if>
    @JsonProperty(index = ${fieldInfo_index + 1})
    <#if !fieldInfo.primaryKey && fieldInfo.isNotNull>
        <#if fieldInfo.javaType == "String">
    @NotBlank(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        <#else>
    @NotNull(message = "${fieldInfo.simpleRemark!fieldInfo.proName}不能为空！")
        </#if>
    </#if>
    <#if fieldInfo.primaryKey>
    @TableId
    </#if>
    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateType>DatePattern.NORM_DATE_PATTERN<#else>DatePattern.NORM_DATETIME_PATTERN</#if>)
    <#elseif fieldInfo.javaType == "Long">
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    </#if>
    <#if FtlUtils.fieldExisted(likeFeilds, fieldInfo.colName)>
    @TableField(condition = SqlCondition.LIKE)
    </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
    </#if>
</#if>
}