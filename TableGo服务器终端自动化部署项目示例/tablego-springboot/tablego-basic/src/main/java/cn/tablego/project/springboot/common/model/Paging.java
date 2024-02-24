package cn.tablego.project.springboot.common.model;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * 分页响应参数
 * 
 * @author bianj
 * @version 1.0.0 2022-09-26
 */
@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
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

    @ApiModelProperty(value = "当前页的记录集", position = 5)
    @JsonProperty(index = 5)
    private List<T> records;

    @ApiModelProperty(value = "扩展数据", position = 6)
    @JsonProperty(index = 6)
    private String ext;

    public static <T extends Serializable> Paging<T> buildPaging(Long pageSize, Long page) {
        return new Paging<>(pageSize, page, null, null, null, null);
    }
}