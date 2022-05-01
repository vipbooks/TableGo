<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
import io.swagger.annotations.ApiModel;
    <#if searchFields?has_content>
import io.swagger.annotations.ApiModelProperty;
    </#if>
</#if>
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import ${jsonParam.basePackagePath}.common.model.BaseCondition;

/**
 * ${tableInfo.simpleRemark!tableInfo.tableName}查询条件
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Setter
@Getter
@Accessors(chain = true)
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}查询条件")
</#if>
public class ${tableInfo.upperCamelCase}Condition extends BaseCondition {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;

    /** 创建${tableInfo.simpleRemark}实例对象 */
    public static ${tableInfo.upperCamelCase}Condition newInstance() {
        return new ${tableInfo.upperCamelCase}Condition();
    }
<#if searchFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list searchFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
        <#if jsonParam.enableSmartDoc?? && jsonParam.enableSmartDoc>
    /** ${fieldInfo.remark!fieldInfo.colName}(开始) */
        <#else>
    @ApiModelProperty(value = "${fieldInfo.remark!fieldInfo.colName}(开始)")
        </#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

        <#if jsonParam.enableSmartDoc?? && jsonParam.enableSmartDoc>
    /** ${fieldInfo.remark!fieldInfo.colName}(结束) */
        <#else>
    @ApiModelProperty(value = "${fieldInfo.remark!fieldInfo.colName}(结束)")
        </#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
    <#else>
        <#if jsonParam.enableSmartDoc?? && jsonParam.enableSmartDoc>
    /** ${fieldInfo.remark} */
        <#else>
    @ApiModelProperty(value = "${fieldInfo.remark}")
        </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#if>
            </#if>
        </#list>
    </#list>
</#if>
}