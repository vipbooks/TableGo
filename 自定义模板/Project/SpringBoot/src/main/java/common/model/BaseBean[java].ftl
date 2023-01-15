package ${jsonParam.packagePath}

import java.util.Date;
import org.hibernate.validator.constraints.Range;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import cn.hutool.core.date.DatePattern;
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 实体公共字段基础类，用于实体JavaBean继承
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public abstract class BaseBean extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 6101499067277733665L;

    /** 创建人，保存用户ID值 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "创建人，保存用户ID值", position = 1000)
</#if>
    @JsonProperty(index = 1000)
    @TableField(fill = FieldFill.INSERT)
    private String createdBy;

    /** 创建日期 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "创建日期", position = 1001)
</#if>
    @JsonProperty(index = 1001)
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATETIME_PATTERN)
    @TableField(fill = FieldFill.INSERT)
    private Date creationDate;

    /** 最后修改人，保存用户ID值 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "最后修改人，保存用户ID值", position = 1002)
</#if>
    @JsonProperty(index = 1002)
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String lastUpdatedBy;

    /** 最后修改日期 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "最后修改日期", position = 1003)
</#if>
    @JsonProperty(index = 1003)
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATETIME_PATTERN)
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date lastUpdateDate;

    /** 删除标记，字典数据，例如：0：已删除、1：未删除 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "删除标记，字典数据，例如：0：已删除、1：未删除", example = "1", position = 1004)
</#if>
    @JsonProperty(index = 1004)
    @Range(min = 0, max = 1, message = "删除标记必需是{min}或{max}的一位正整数！")
    @TableLogic
    private Integer deleteFlag;

    /**
     * 获取记录创建人，保存用户ID值
     *
     * @return 记录创建人
     */
    public String getCreatedBy() {
        return this.createdBy;
    }

    /**
     * 设置记录创建人，保存用户ID值
     *
     * @param createdBy 记录创建人，保存用户ID值
     */
    public BaseBean setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
        return this;
    }

    /**
     * 获取记录创建日期
     *
     * @return 记录创建日期
     */
    public Date getCreationDate() {
        return this.creationDate;
    }

    /**
     * 设置记录创建日期
     *
     * @param creationDate 记录创建日期
     */
    public BaseBean setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
        return this;
    }

    /**
     * 获取记录最后修改人，保存用户ID值
     *
     * @return 记录最后修改人
     */
    public String getLastUpdatedBy() {
        return this.lastUpdatedBy;
    }

    /**
     * 设置记录最后修改人，保存用户ID值
     *
     * @param lastUpdatedBy 记录最后修改人，保存用户ID值
     */
    public BaseBean setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
        return this;
    }

    /**
     * 获取记录最后修改日期
     *
     * @return 记录最后修改日期
     */
    public Date getLastUpdateDate() {
        return this.lastUpdateDate;
    }

    /**
     * 设置记录最后修改日期
     *
     * @param lastUpdateDate 记录最后修改日期
     */
    public BaseBean setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
        return this;
    }

    /**
     * 获取删除标记，字典数据，例如：0：已删除、1：未删除
     *
     * @return 删除标记
     */
    public Integer getDeleteFlag() {
        return this.deleteFlag;
    }

    /**
     * 设置删除标记，字典数据，例如：0：已删除、1：未删除
     *
     * @param deleteFlag 删除标记
     */
    public BaseBean setDeleteFlag(Integer deleteFlag) {
        this.deleteFlag = deleteFlag;
        return this;
    }
}