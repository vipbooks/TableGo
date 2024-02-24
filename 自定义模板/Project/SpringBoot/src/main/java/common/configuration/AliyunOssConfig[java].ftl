package ${jsonParam.packagePath}

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

/**
 * 阿里云OSS参数配置
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Data
@Configuration
@ConfigurationProperties("aliyun.oss")
public class AliyunOssConfig {
    /** 外网访问节点域名 */
    private String endpoint;

    /** 授权ID */
    private String accessKeyId;

    /** 授权密钥 */
    private String accessKeySecret;

    /** 桶名称，用户用来管理所存储对象的存储空间 */
    private String bucketName;
}
