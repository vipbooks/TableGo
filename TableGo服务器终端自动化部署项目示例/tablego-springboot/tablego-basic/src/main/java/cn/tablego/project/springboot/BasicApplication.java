package cn.tablego.project.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.spring4all.swagger.EnableSwagger2Doc;

/**
 * TableGo-SpringBoot项目启动类<br/>
 * Swagger2访问地址：http://127.0.0.1:8822/swagger-ui.html
 *  Knife4j访问地址：http://127.0.0.1:8822/doc.html
 *
 * @author bianj
 * @version 1.0.0 2021-09-26
 */
@SpringBootApplication
@EnableSwagger2Doc
public class BasicApplication {

	public static void main(String[] args) {
		SpringApplication.run(BasicApplication.class, args);
	}
}