package ${jsonParam.packagePath}

import java.io.Serializable;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * OSS文件上传返回结果
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class OssUploadResult implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** OSS服务器地址 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "OSS服务器地址")
</#if>
    private String ossServerUrl;

    /** 文件路径 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "文件路径")
</#if>
    private String filePath;

    /** 原始文件名 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "原始文件名")
</#if>
    private String fileName;

    /** 文件后缀 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "文件后缀")
</#if>
    private String suffix;

    /** 文件大小 */
<#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "文件大小")
</#if>
    private Long fileSize;
}
