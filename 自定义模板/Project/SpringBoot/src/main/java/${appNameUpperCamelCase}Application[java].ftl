package ${jsonParam.packagePath}

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.spring4all.swagger.EnableSwagger2Doc;

/**
 * ${jsonParam.description!jsonParam.appName}启动类<br/>
 * Swagger2访问地址：http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}/swagger-ui.html
 *  Knife4j访问地址：http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}/doc.html
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@SpringBootApplication
@EnableSwagger2Doc
@EnableTransactionManagement
public class ${jsonParam.appNameUpperCamelCase}Application {

	public static void main(String[] args) {
		SpringApplication.run(${jsonParam.appNameUpperCamelCase}Application.class, args);
	}
}