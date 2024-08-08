package ${jsonParam.packagePath}

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.Range;
import com.fasterxml.jackson.annotation.JsonFormat;
import cn.hutool.core.date.DatePattern;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;

import lombok.Data;
import lombok.experimental.Accessors;
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 实体公共字段基础类，用于实体JavaBean继承
 * 
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Accessors(chain = true)
public abstract class BaseBean implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** 创建人 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "创建人")
</#if>
    @TableField(fill = FieldFill.INSERT)
    private String createdBy;

    /** 创建时间 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "创建时间")
</#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATETIME_PATTERN)
    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;

    /** 最后修改人 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "最后修改人")
</#if>
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String lastUpdatedBy;

    /** 最后修改时间 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "最后修改时间")
</#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATETIME_PATTERN)
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date lastUpdatedTime;

    /** 是否删除，0：未删除；1：已删除 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "是否删除，0：未删除；1：已删除", example = "0")
</#if>
    @Range(min = 0, max = 1, message = "删除标记必需是 {min} 或 {max} 的一位正整数")
    @TableLogic
    private Integer isDeleted;
}