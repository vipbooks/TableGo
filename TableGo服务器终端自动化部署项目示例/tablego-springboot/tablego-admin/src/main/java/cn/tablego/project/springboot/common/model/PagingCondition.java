package cn.tablego.project.springboot.common.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * 分页查询请求参数
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
public class PagingCondition extends OverrideBeanMethods {
    /** 版本号 */
    private static final long serialVersionUID = 8051759355564013572L;

    @ApiModelProperty(value = "每页显示多少条记录", example = "20", position = 1000)
    private Long pageSize = 20L;

    @ApiModelProperty(value = "当前页", example = "1", position = 1001)
    private Long page = 1L;

    @ApiModelProperty(value = "扩展数据")
    private String ext;
}