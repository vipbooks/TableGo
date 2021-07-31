package ${jsonParam.packagePath}

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.spring4all.swagger.EnableSwagger2Doc;

/**
 * ${jsonParam.description!jsonParam.artifactId}启动类<br/>
 * Swagger2访问地址：http://127.0.0.1:8080/${jsonParam.artifactId}/swagger-ui.html
 *  Knife4j访问地址：http://127.0.0.1:8080/${jsonParam.artifactId}/doc.html
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@SpringBootApplication
@EnableSwagger2Doc
@EnableTransactionManagement
public class ${jsonParam.artifactIdUpperCamelCase}Application {

	public static void main(String[] args) {
		SpringApplication.run(${jsonParam.artifactIdUpperCamelCase}Application.class, args);
	}
}