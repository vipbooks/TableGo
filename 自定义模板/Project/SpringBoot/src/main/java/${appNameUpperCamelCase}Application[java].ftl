package ${jsonParam.packagePath}

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>

import com.spring4all.swagger.EnableSwagger2Doc;
</#if>

/**
 * ${jsonParam.description!jsonParam.appName}启动类<br/>
<#if jsonParam.enableSmartDoc?? && jsonParam.enableSmartDoc>
 * Smart-Doc访问地址：http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}/doc/debug.html
<#else>
 * Swagger2访问地址：http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}/swagger-ui.html
    <#if jsonParam.enableKnife4j>
 *  Knife4j访问地址：http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}/doc.html
    </#if>
</#if>
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@SpringBootApplication
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
@EnableSwagger2Doc
</#if>
@EnableTransactionManagement
public class ${jsonParam.appNameUpperCamelCase}Application {

	public static void main(String[] args) {
		SpringApplication.run(${jsonParam.appNameUpperCamelCase}Application.class, args);
	}
}