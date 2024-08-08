package ${jsonParam.packagePath}

import java.io.Serializable;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;
import lombok.experimental.Accessors;
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 分页查询请求参数，用于继承
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Accessors(chain = true)
public abstract class BasePagingCondition implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** 每页显示多少条记录 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "每页显示多少条记录", example = "20")
</#if>
    private Long pageSize = 20L;

    /** 当前页 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "当前页", example = "1")
</#if>
    private Long page = 1L;

    /** 排序字段 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "排序字段")
</#if>
    private String sortField;

    /** 排序方式，只能是ASC或DESC */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "排序方式，只能是ASC或DESC")
</#if>
    private String sortOrder;

    /**
     * 设置每页显示多少条记录
     *
     * @param pageSize 每页显示多少条记录
     */
    public BasePagingCondition setPageSize(Long pageSize) {
        if (pageSize != null && pageSize > 0) {
            this.pageSize = pageSize;
        }
        return this;
    }

    /**
     * 设置当前页
     *
     * @param page 当前页
     */
    public BasePagingCondition setPage(Long page) {
        if (page != null && page > 0) {
            this.page = page;
        }
        return this;
    }

    /** 创建 MyBatisPlus 的分页模型 */
    public <T> Page<T> buildPage() {
        return new Page<>(page, pageSize);
    }
}