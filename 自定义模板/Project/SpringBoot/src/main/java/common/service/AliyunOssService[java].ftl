package ${jsonParam.packagePath}

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.DeleteObjectsRequest;
import com.aliyun.oss.model.DeleteObjectsResult;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.PutObjectRequest;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.text.StrPool;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

import ${jsonParam.basePackagePath}.configuration.AliyunOssConfig;
import ${jsonParam.basePackagePath}.common.exception.BizException;
import ${jsonParam.basePackagePath}.common.util.Assert;
import ${jsonParam.basePackagePath}.common.model.OssUploadResult;

/**
 * 阿里云OSS服务接口
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
@Service
public class AliyunOssService {
    private static final String HTTPS = "https://";

    @Autowired
    private AliyunOssConfig aliyunOssConfig;

    /** OSS服务器的URL */
    private String ossServerUrl;

    @PostConstruct
    public void init() {
        this.ossServerUrl = StrUtil.builder(HTTPS, aliyunOssConfig.getBucketName(), StrPool.DOT, aliyunOssConfig.getEndpoint(), StrPool.SLASH).toString();
    }

    /**
     * 批量上传文件
     *
     * @param fileList 文件列表
     * @param basePath 基础路径，例如：images
     * @return OSS文件上传返回结果
     */
    public List<OssUploadResult> batchUploadFile(List<MultipartFile> fileList, String basePath) {
        Assert.isNotEmpty(fileList, "上传的文件列表不能为空！");
        for (MultipartFile file : fileList) {
            Assert.isNotNull(file, "文件不能为空！");
            Assert.isTrue(file.getSize() > 0, file.getOriginalFilename() + " 文件不能为空！");
        }
        List<OssUploadResult> resultList = new ArrayList<>();
        OSS ossClient = buildOssClient();
        try {
            for (MultipartFile file : fileList) {
                InputStream is = file.getInputStream();
                String fileName = file.getOriginalFilename();
                String suffix = FileUtil.getSuffix(fileName);
                String filePath = getFilePathKey(basePath, suffix);

                PutObjectRequest putObjectRequest = new PutObjectRequest(aliyunOssConfig.getBucketName(), filePath, is);
                ossClient.putObject(putObjectRequest);
                is.close();

                OssUploadResult result = OssUploadResult.builder()
                        .ossServerUrl(ossServerUrl)
                        .filePath(filePath)
                        .fileName(fileName)
                        .suffix(suffix)
                        .fileSize(file.getSize())
                        .build();
                resultList.add(result);
            }
        } catch (Exception e) {
            throw BizException.newInstance(e.getMessage(), e);
        } finally {
            ossClient.shutdown();
        }
        return resultList;
    }

    /**
     * 批量上传Base64文件
     *
     * @param base64List   Base64文件列表
     * @param fileNameList Base64文件名列表，包含文件扩展名，与base64List中的文件一一对应
     * @param basePath     基础路径，例如：images
     * @return OSS文件上传返回结果
     */
    public List<OssUploadResult> batchUploadBase64File(List<String> base64List, List<String> fileNameList, String basePath) {
        Assert.isNotEmpty(base64List, "上传的Base64文件列表不能为空！");
        Assert.isNotEmpty(fileNameList, "文件名列表不能为空！");
        Assert.isTrue(base64List.size() == fileNameList.size(), "上传的Base64文件列表与对应的文件名列表不一致！");

        List<OssUploadResult> resultList = new ArrayList<>();
        CollUtil.forEach(base64List.listIterator(), (String base64File, int index) -> {
            String fileName = fileNameList.get(index);
            Assert.isNotBlank(base64File, "上传的Base64文件不能为空！");
            Assert.isNotBlank(fileName, StrUtil.format("第 {} 个Base64文件的文件名不能为空！", index + 1));

            base64File = StrUtil.trim(base64File);
            int idx = base64File.indexOf(StrPool.COMMA);
            if (idx > 0) {
                base64File = base64File.substring(idx + 1);
            }

            OSS ossClient = buildOssClient();
            byte[] fileBytes = Base64.getDecoder().decode(base64File);
            try (ByteArrayInputStream bais = new ByteArrayInputStream(fileBytes)) {
                String suffix = FileUtil.getSuffix(fileName);
                String filePath = getFilePathKey(basePath, suffix);

                PutObjectRequest putObjectRequest = new PutObjectRequest(aliyunOssConfig.getBucketName(), filePath, bais);
                ossClient.putObject(putObjectRequest);

                OssUploadResult result = OssUploadResult.builder()
                        .ossServerUrl(ossServerUrl)
                        .filePath(filePath)
                        .fileName(fileName)
                        .suffix(suffix)
                        .fileSize((long) fileBytes.length)
                        .build();
                resultList.add(result);
            } catch (Exception e) {
                throw BizException.newInstance(fileName + e.getMessage(), e);
            } finally {
                ossClient.shutdown();
            }
        });
        return resultList;
    }

    /**
     * 下载单个文件
     *
     * @param filePath 文件路径
     * @param os       输出流
     * @return 文件不存在返回False，否则返回True
     */
    public boolean downloadFile(String filePath, OutputStream os) {
        Assert.isNotBlank(filePath, "文件路径不能为空！");
        OSS ossClient = buildOssClient();
        boolean bool = ossClient.doesObjectExist(aliyunOssConfig.getBucketName(), filePath);
        if (!bool) {
            log.debug("要下载的OSS文件不存在：{}", filePath);
            return false;
        }
        try (OSSObject ossObject = ossClient.getObject(aliyunOssConfig.getBucketName(), filePath);
             InputStream is = ossObject.getObjectContent()) {
            byte[] buff = new byte[2048];
            int read;
            while ((read = is.read(buff)) != -1) {
                os.write(buff, 0, read);
            }
            os.flush();
            os.close();
        } catch (Exception e) {
            throw BizException.newInstance(e.getMessage(), e);
        } finally {
            ossClient.shutdown();
        }
        return true;
    }

    /**
     * 生成以GET方法访问文件的签名URL，可以直接通过浏览器访问相关内容
     *
     * @param filePath   文件路径
     * @param expiration URL的过期时间
     * @return 签名URL
     */
    public URL generatePresignedUrl(String filePath, Date expiration) {
        OSS ossClient = buildOssClient();
        try {
            return ossClient.generatePresignedUrl(aliyunOssConfig.getBucketName(), filePath, expiration);
        } catch (Exception e) {
            throw BizException.newInstance(e.getMessage(), e);
        } finally {
            ossClient.shutdown();
        }
    }

    /**
     * 删除单个文件
     *
     * @param filePath 文件路径
     * @return 文件不存在返回False，否则返回True
     */
    public boolean deleteFile(String filePath) {
        Assert.isNotBlank(filePath, "文件路径不能为空！");
        OSS ossClient = buildOssClient();
        boolean bool = ossClient.doesObjectExist(aliyunOssConfig.getBucketName(), filePath);
        if (bool) {
            ossClient.deleteObject(aliyunOssConfig.getBucketName(), filePath);
            log.debug("删除单个OSS文件：{}", filePath);
        } else {
            log.debug("要删除的OSS文件不存在：{}", filePath);
        }
        ossClient.shutdown();
        return true;
    }

    /**
     * 批量删除多个文件
     *
     * @param filePathList 文件路径列表
     */
    public void batchDeleteFile(List<String> filePathList) {
        Assert.isNotEmpty(filePathList, "文件路径列表不能为空！");
        OSS ossClient = buildOssClient();
        DeleteObjectsRequest deleteObjectsRequest = new DeleteObjectsRequest(aliyunOssConfig.getBucketName()).withKeys(filePathList);
        DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(deleteObjectsRequest);
        List<String> deletedObjects = deleteObjectsResult.getDeletedObjects();
        log.debug("批量删除OSS文件：{}", deletedObjects);
        ossClient.shutdown();
    }

    /**
     * 创建OSSClient对象
     *
     * @return OSSClient
     */
    private OSS buildOssClient() {
        return new OSSClientBuilder().build(aliyunOssConfig.getEndpoint(), aliyunOssConfig.getAccessKeyId(), aliyunOssConfig.getAccessKeySecret());
    }

    /**
     * 获取文件上传路径Key，bucket里的唯一key，上传和删除时使用
     *
     * @param basePath 基础路径，例如：images
     * @param suffix   文件后缀
     * @return 路径Key
     */
    public String getFilePathKey(String basePath, String suffix) {
        // 按年月日分目录保存文件
        String today = DateUtil.formatDate(DateUtil.date());
        String path = today.replace(StrPool.DASHED, StrPool.SLASH);
        String fileName = IdUtil.getSnowflake().nextIdStr();

        if (StrUtil.isNotBlank(basePath) && StrUtil.isNotBlank(suffix)) {
            path = StrUtil.builder(basePath, StrPool.SLASH, path, StrPool.SLASH, fileName, StrPool.DOT, suffix).toString();
        } else if (StrUtil.isBlank(basePath) && StrUtil.isNotBlank(suffix)) {
            path = StrUtil.builder(path, StrPool.SLASH, fileName, StrPool.DOT, suffix).toString();
        } else {
            path = StrUtil.builder(path, StrPool.SLASH, fileName).toString();
        }
        return path;
    }
}
