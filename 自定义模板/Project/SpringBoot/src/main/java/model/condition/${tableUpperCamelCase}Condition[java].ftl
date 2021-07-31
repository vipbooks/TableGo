<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(jsonParam.searchFeilds, tableInfo.tableName) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFeilds, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFeilds, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
<#if searchFeilds?has_content>
import io.swagger.annotations.ApiModelProperty;
</#if>
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import ${jsonParam.basePackagePath}.common.BaseCondition;

/**
 * ${tableInfo.simpleRemark!tableInfo.tableName}查询条件
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Setter
@Getter
@Accessors(chain = true)
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}查询条件")
public class ${tableInfo.upperCamelCase}Condition extends BaseCondition {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;

    /** 创建${tableInfo.simpleRemark}实例对象 */
    public static ${tableInfo.upperCamelCase}Condition newInstance() {
        return new ${tableInfo.upperCamelCase}Condition();
    }
<#if searchFeilds?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list searchFeilds as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @ApiModelProperty(value = "${fieldInfo.remark}(开始)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

    @ApiModelProperty(value = "${fieldInfo.remark}(结束)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
    <#else>
    @ApiModelProperty(value = "${fieldInfo.remark}")
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#if>
            </#if>
        </#list>
    </#list>
</#if>
}