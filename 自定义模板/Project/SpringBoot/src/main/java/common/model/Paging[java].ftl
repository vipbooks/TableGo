package ${jsonParam.packagePath}

import java.io.Serializable;
import java.util.List;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
<#if jsonParam.enableSwagger>

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * 分页响应参数
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@NoArgsConstructor
@Accessors(chain = true)
<#if jsonParam.enableSwagger>
@ApiModel(description = "分页响应参数")
</#if>
public class Paging<T extends Serializable> implements Serializable {
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

    /** 总记录数 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "总记录数")
</#if>
    private Long total = 0L;

    /** 总页数 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "总页数")
</#if>
    private Long totalPage = 0L;

    /** 是否存在上一页 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "是否存在上一页")
</#if>
    private Boolean hasPrevious = false;

    /** 是否存在下一页 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "是否存在下一页")
</#if>
    private Boolean hasNext = false;

    /** 当前页的记录集 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "当前页的记录集")
</#if>
    private List<T> records;

    /**
     * Paging对象造函数
     *
     * @param pageSize  每页显示多少条记录
     * @param page      当前页
     * @param total     总记录数
     * @param totalPage 总页数
     * @param records   当前页的记录集
     */
    public Paging(Long pageSize, Long page, Long total, Long totalPage, List<T> records) {
        this.setPageSize(pageSize).setPage(page).setTotal(total).setTotalPage(totalPage).setRecords(records);
    }

    /** 创建分页对象 */
    public static <T extends Serializable> Paging<T> buildPaging() {
        return new Paging<>();
    }

    /**
     * 创建分页对象并赋值
     *
     * @param page MyBatisPlus的分页模型
     * @return 分页数据
     */
    public static <T extends Serializable> Paging<T> buildPaging(IPage<T> page) {
        return new Paging<>(page.getSize(), page.getCurrent(), page.getTotal(), page.getPages(), page.getRecords());
    }

    /**
     * 创建分页对象并赋值
     *
     * @param pageSize  每页显示多少条记录
     * @param page      当前页
     * @param total     总记录数
     * @param totalPage 总页数
     * @param records   当前页的记录集
     * @return 分页数据
     */
    public static <T extends Serializable> Paging<T> buildPaging(Long pageSize, Long page, Long total, Long totalPage, List<T> records) {
        return new Paging<>(pageSize, page, total, totalPage, records);
    }

    /**
     * 计算总页数
     *
     * @param pageSize 每页显示多少条记录
     * @param total    总记录数
     * @return 总页数
     */
    public static Long computeTotalPage(Long pageSize, Long total) {
        if (pageSize != null && pageSize > 0 && total != null && total >= 0) {
            return (total + pageSize - 1) / pageSize;
        }
        return 0L;
    }

    /**
     * 设置每页显示多少条记录
     *
     * @param pageSize 每页显示多少条记录
     * @return 分页数据
     */
    public Paging<T> setPageSize(Long pageSize) {
        if (pageSize != null && pageSize > 0) {
            this.pageSize = pageSize;
        }
        return this;
    }

    /**
     * 设置当前页
     *
     * @param page 当前页
     * @return 分页数据
     */
    public Paging<T> setPage(Long page) {
        if (page != null && page > 0) {
            this.page = page;
        }
        return this;
    }

    /**
     * 设置总记录数
     *
     * @param total 总记录数
     * @return 分页数据
     */
    public Paging<T> setTotal(Long total) {
        if (total != null && total >= 0) {
            this.total = total;
        }
        return this;
    }

    /**
     * 设置总页数
     *
     * @param totalPage 总页数
     * @return 分页数据
     */
    public Paging<T> setTotalPage(Long totalPage) {
        if (totalPage != null && totalPage >= 0) {
            this.totalPage = totalPage;
        }
        return this;
    }

    /**
     * 获取是否存在上一页
     *
     * @return 是否存在上一页
     */
    public Boolean getHasPrevious() {
        if (this.page != null) {
            this.hasPrevious = this.page > 1;
        }
        return this.hasPrevious;
    }

    /**
     * 获取是否存在下一页
     *
     * @return 是否存在下一页
     */
    public Boolean getHasNext() {
        if (this.page != null && this.totalPage != null) {
            this.hasNext = this.page < this.totalPage;
        }
        return this.hasNext;
    }
}