package ${jsonParam.packagePath}

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 分页查询请求参数，用于继承
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public abstract class BasePagingCondition extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 8051759355564013572L;

    /** 每页显示多少条记录 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "每页显示多少条记录", example = "20")
</#if>
    protected Long pageSize = 20L;

    /** 当前页 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "当前页", example = "1")
</#if>
    protected Long page = 1L;

    /** 排序字段 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "排序字段")
</#if>
    protected String sortField;

    /** 排序方式，只能是ASC或DESC */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "排序方式，只能是ASC或DESC")
</#if>
    protected String sortOrder;

    /**
     * 获取每页显示多少条记录
     *
     * @return 每页显示多少条记录
     */
    public Long getPageSize() {
        return this.pageSize;
    }

    /**
     * 设置每页显示多少条记录
     *
     * @param pageSize
     *          每页显示多少条记录
     */
    public BasePagingCondition setPageSize(Long pageSize) {
        if (pageSize != null && pageSize > 0) {
            this.pageSize = pageSize;
        }
        return this;
    }

    /**
     * 获取当前页
     *
     * @return 当前页
     */
    public Long getPage() {
        return this.page;
    }

    /**
     * 设置当前页
     *
     * @param page
     *          当前页
     */
    public BasePagingCondition setPage(Long page) {
        if (page != null && page > 0) {
            this.page = page;
        }
        return this;
    }

    /**
     * 获取排序字段
     *
     * @return 排序字段
     */
    public String getSortField() {
        return this.sortField;
    }

    /**
     * 设置排序字段
     *
     * @param sortField
     *          排序字段
     */
    public BasePagingCondition setSortField(String sortField) {
        this.sortField = sortField;
        return this;
    }

    /**
     * 获取排序方式，只能是ASC或DESC
     *
     * @return 排序方式
     */
    public String getSortOrder() {
        return this.sortOrder;
    }

    /**
     * 设置排序方式，只能是ASC或DESC
     *
     * @param sortOrder
     *          排序方式
     */
    public BasePagingCondition setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
        return this;
    }

    /** 创建简单分页模型 */
    public <T> Page<T> buildPage() {
        return new Page<>(page, pageSize);
    }
}