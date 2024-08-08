package ${jsonParam.packagePath}

<#if jsonParam.enableSwagger>
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
</#if>
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import ${jsonParam.basePackagePath}.common.model.Result;
import ${jsonParam.basePackagePath}.common.model.OssUploadResult;
import ${jsonParam.basePackagePath}.common.service.AliyunOssService;

/**
 * 阿里云OSS服务
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
<#if jsonParam.enableSwagger>
@Api(tags = "阿里云OSS服务")
</#if>
@RestController
@RequestMapping("/aliyunOss")
public class AliyunOssController extends BaseController {
    @Autowired
    private AliyunOssService aliyunOssService;

<#if !jsonParam.enableSwagger>
    /**
     * 上传单个文件
     *
     * @param file     文件
     * @param basePath 基础路径，例如：images或test/images
     * @return 结果数据
     */
<#else>
    @ApiOperation("上传单个文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "file", value = "文件", required = true, dataType = "__file"),
            @ApiImplicitParam(name = "basePath", value = "基础路径，例如：images或test/images")
    })
</#if>
    @PostMapping("/uploadFile")
    public Result<OssUploadResult> uploadFile(MultipartFile file, String basePath) {
        List<OssUploadResult> resultList = aliyunOssService.batchUploadFile(Collections.singletonList(file), basePath);
        return Result.ok(resultList.get(0));
    }

<#if !jsonParam.enableSwagger>
    /**
     * 批量上传文件
     *
     * @param fileList  文件列表
     * @param basePath  基础路径，例如：images或test/images
     * @return 结果数据
     */
<#else>
    @ApiOperation("批量上传文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "fileList", value = "文件列表", required = true, allowMultiple = true, dataType = "__file"),
            @ApiImplicitParam(name = "basePath", value = "基础路径，例如：images或test/images")
    })
</#if>
    @PostMapping("/batchUploadFile")
    public Result<List<OssUploadResult>> batchUploadFile(List<MultipartFile> fileList, String basePath) {
        List<OssUploadResult> resultList = aliyunOssService.batchUploadFile(fileList, basePath);
        return Result.ok(resultList);
    }

<#if !jsonParam.enableSwagger>
    /**
     * 上传单个Base64文件
     *
     * @param base64File Base64文件
     * @param fileName   文件名，包含文件扩展名
     * @param basePath   基础路径，例如：images或test/images
     * @return 结果数据
     */
<#else>
    @ApiOperation("上传单个Base64文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "base64File", value = "Base64文件", required = true),
            @ApiImplicitParam(name = "fileName", value = "文件名，包含文件扩展名", required = true),
            @ApiImplicitParam(name = "basePath", value = "基础路径，例如：images或test/images")
    })
</#if>
    @PostMapping("/uploadBase64File")
    public Result<OssUploadResult> uploadBase64File(String base64File, String fileName, String basePath) {
        List<OssUploadResult> resultList = aliyunOssService.batchUploadBase64File(Collections.singletonList(base64File), Collections.singletonList(fileName), basePath);
        return Result.ok(resultList.get(0));
    }

<#if !jsonParam.enableSwagger>
    /**
     * 批量上传Base64文件
     *
     * @param base64List     Base64文件列表
     * @param fileNameList   文件名列表，包含文件扩展名，与base64List中的文件一一对应
     * @param basePath       基础路径，例如：images或test/images
     * @return 结果数据
     */
<#else>
    @ApiOperation("批量上传Base64文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "base64List", value = "Base64文件列表", required = true, allowMultiple = true),
            @ApiImplicitParam(name = "fileNameList", value = "文件名列表，包含文件扩展名，与base64List中的文件一一对应", required = true, allowMultiple = true),
            @ApiImplicitParam(name = "basePath", value = "基础路径，例如：images或test/images")
    })
</#if>
    @PostMapping("/batchUploadBase64File")
    public Result<List<OssUploadResult>> batchUploadBase64File(@RequestParam List<String> base64List, @RequestParam List<String> fileNameList, String basePath) {
        List<OssUploadResult> resultList = aliyunOssService.batchUploadBase64File(base64List, fileNameList, basePath);
        return Result.ok(resultList);
    }

<#if !jsonParam.enableSwagger>
    /**
     * 下载单个文件
     *
     * @param fileName  文件名，包含文件扩展名
     * @param basePath  基础路径，例如：images或test/images
     * @return 结果数据
     */
<#else>
    @ApiOperation("下载单个文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "fileName", value = "文件名，包含文件扩展名", required = true),
            @ApiImplicitParam(name = "filePath", value = "文件路径", required = true)
    })
</#if>
    @RequestMapping(value = "/downloadFile", method = {RequestMethod.GET, RequestMethod.POST})
    public Result<Boolean> downloadFile(@RequestParam String fileName, @RequestParam String filePath) throws Exception {
        response.reset();
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, StandardCharsets.UTF_8.name()));

        boolean bool = aliyunOssService.downloadFile(filePath, response.getOutputStream());
        if (bool) {
            return null;
        }
        response.reset();
        return Result.failed("OSS文件不存在！");
    }

<#if !jsonParam.enableSwagger>
    /**
     * 删除单个文件
     *
     * @param filePath  文件路径
     * @return 结果数据
     */
<#else>
    @ApiOperation("删除单个文件")
    @ApiImplicitParam(name = "filePath", value = "文件路径", required = true)
</#if>
    @PostMapping("/deleteFile")
    public Result<Boolean> deleteFile(@RequestParam String filePath) {
        boolean bool = aliyunOssService.deleteFile(filePath);
        if (bool) {
            return Result.ok();
        }
        return Result.failed("OSS文件不存在！");
    }

<#if !jsonParam.enableSwagger>
    /**
     * 批量删除多个文件
     *
     * @param filePathList  文件路径列表
     * @return 结果数据
     */
<#else>
    @ApiOperation("批量删除多个文件")
    @ApiImplicitParam(name = "filePathList", value = "文件路径列表", required = true, allowMultiple = true, paramType = "body")
</#if>
    @PostMapping("/batchDeleteFile")
    public Result<Boolean> batchDeleteFile(@RequestBody List<String> filePathList) {
        aliyunOssService.batchDeleteFile(filePathList);
        return Result.ok();
    }
}
