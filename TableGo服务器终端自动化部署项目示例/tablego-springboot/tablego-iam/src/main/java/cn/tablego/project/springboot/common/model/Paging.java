package cn.tablego.project.springboot.common.model;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 分页响应参数
 * 
 * @author bianj
 * @version 1.0.0 2021-09-23
 */
@ApiModel(description = "分页响应参数")
public class Paging<T extends Serializable> extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 6242056024283004874L;

    @ApiModelProperty(value = "每页显示多少条记录", example = "20", position = 1)
    @JsonProperty(index = 1)
    private Long pageSize = 20L;

    @ApiModelProperty(value = "当前页", example = "1", position = 2)
    @JsonProperty(index = 2)
    private Long page = 1L;

    @ApiModelProperty(value = "总记录数", position = 3)
    @JsonProperty(index = 3)
    private Long total = 0L;

    @ApiModelProperty(value = "总页数", position = 4)
    @JsonProperty(index = 4)
    private Long totalPage = 0L;

    @ApiModelProperty(value = "是否存在上一页", position = 5)
    @JsonProperty(index = 5)
    private Boolean hasPrevious;

    @ApiModelProperty(value = "是否存在下一页", position = 6)
    @JsonProperty(index = 6)
    private Boolean hasNext;

    @ApiModelProperty(value = "当前页的记录集", position = 7)
    @JsonProperty(index = 7)
    private List<T> records;

    public Paging() {
    }

    public Paging(Long pageSize, Long page, Long total, Long totalPage, List<T> records) {
        this.setPageSize(pageSize).setPage(page).setTotal(total).setTotalPage(totalPage).setRecords(records);
        this.setHasPrevious(page > 1);
        this.setHasNext(page < totalPage);
    }

    /**
     * 获取每页显示多少条记录
     *
     * @return 每页显示多少条记录
     */
    public Long getPageSize() {
        return pageSize;
    }

    /**
     * 设置每页显示多少条记录
     *
     * @param pageSize
     *          每页显示多少条记录
     * @return 分页数据
     */
    public Paging<T> setPageSize(Long pageSize) {
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
        return page;
    }

    /**
     * 设置当前页
     *
     * @param page
     *          当前页
     * @return 分页数据
     */
    public Paging<T> setPage(Long page) {
        if (page != null && page > 0) {
            this.page = page;
        }
        return this;
    }

    /**
     * 获取总记录数
     *
     * @return 总记录数
     */
    public Long getTotal() {
        return total;
    }

    /**
     * 设置总记录数
     *
     * @param total
     *          总记录数
     * @return 分页数据
     */
    public Paging<T> setTotal(Long total) {
        if (total != null && total >= 0) {
            this.total = total;
        }
        return this;
    }

    /**
     * 获取总页数
     *
     * @return 总页数
     */
    public Long getTotalPage() {
        return totalPage;
    }

    /**
     * 设置总页数
     *
     * @param totalPage
     *          总页数
     * @return 分页数据
     */
    public Paging<T> setTotalPage(Long totalPage) {
        if (totalPage != null && totalPage >= 0) {
            this.totalPage = totalPage;
        }
        return this;
    }

    /**
     * 获取当前页的记录集
     *
     * @return 当前页的记录集
     */
    public List<T> getRecords() {
        return records;
    }

    /**
     * 设置当前页的记录集
     *
     * @param records
     *          当前页的记录集
     * @return 分页数据
     */
    public Paging<T> setRecords(List<T> records) {
        this.records = records;
        return this;
    }

    /**
     * 获取是否存在上一页
     *
     * @return 是否存在上一页
     */
    public Boolean getHasPrevious() {
        return hasPrevious;
    }

    /**
     * 设置是否存在上一页
     *
     * @param hasPrevious
     *          是否存在上一页
     * @return 分页数据
     */
    public Paging<T> setHasPrevious(Boolean hasPrevious) {
        this.hasPrevious = hasPrevious;
        return this;
    }

    /**
     * 获取是否存在下一页
     *
     * @return 是否存在下一页
     */
    public Boolean getHasNext() {
        return hasNext;
    }

    /**
     * 设置是否存在下一页
     *
     * @param hasNext
     *          是否存在下一页
     * @return 分页数据
     */
    public Paging<T> setHasNext(Boolean hasNext) {
        this.hasNext = hasNext;
        return this;
    }
}