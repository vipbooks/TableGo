<#-- 用于生成MyBatisPlus链式数据模型的自定义模板 -->
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
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonProperty;
import ${jsonParam.basePackagePath}.common.BaseBean;

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
@TableName("${tableInfo.tableName}")
public class ${tableInfo.upperCamelCase} extends BaseBean {
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

    @ApiModelProperty(value = "${fieldInfo.remark}", position = ${fieldInfo_index + 1})
    @JsonProperty(index = ${fieldInfo_index + 1})
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
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 2)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>

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
     * @param ${fieldInfo.proName}
<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)>
     *          ${fieldInfo.simpleRemark}
</#if>
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}
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
}