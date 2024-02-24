<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>${jsonParam.version.springBootStarterParent}</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <groupId>${jsonParam.groupId}</groupId>
    <artifactId>${jsonParam.artifactId}</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>${jsonParam.appName}</name>
    <description>${jsonParam.description}</description>
    <url>http://www.tablego.cn</url>

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
		<java.version>${jsonParam.version.java}</java.version>
        <skipTests>true</skipTests>

        <mysql-connector-java.version>${jsonParam.version.mysqlConnectorJava}</mysql-connector-java.version>
        <mybatis-plus-boot-starter.version>${jsonParam.version.mybatisPlusBootStarter}</mybatis-plus-boot-starter.version>
        <commons-lang3.version>${jsonParam.version.commonsLang3}</commons-lang3.version>
        <lombok.version>${jsonParam.version.lombok}</lombok.version>
        <hutool-all.version>${jsonParam.version.hutoolAll}</hutool-all.version>
<#if jsonParam.enableSwagger>
        <swagger-spring-boot-starter.version>${jsonParam.version.swaggerSpringBootStarter}</swagger-spring-boot-starter.version>
        <knife4j.version>${jsonParam.version.knife4j}</knife4j.version>
        <snakeyaml.version>${jsonParam.version.snakeyaml}</snakeyaml.version>
</#if>
<#if jsonParam.enableSmartDoc>
        <smart-doc-maven-plugin.version>${jsonParam.version.smartDocMavenPlugin}</smart-doc-maven-plugin.version>
</#if>
<#if jsonParam.enableRedis>
        <redisson.version>${jsonParam.version.redisson}</redisson.version>
</#if>
<#if jsonParam.enableAliyunOss>
        <aliyun-sdk-oss.version>${jsonParam.version.aliyunSdkOss}</aliyun-sdk-oss.version>
</#if>
<#if jsonParam.enableEasyExcel>
        <easyexcel.version>${jsonParam.version.easyexcel}</easyexcel.version>
</#if>

        <maven-compiler-plugin.version>${jsonParam.version.mavenCompilerPlugin}</maven-compiler-plugin.version>
        <maven-source-plugin.version>${jsonParam.version.mavenSourcePlugin}</maven-source-plugin.version>
	</properties>

	<dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <version>${"$"}{mysql-connector-java.version}</version>
            <scope>runtime</scope>
        </dependency>

        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>${"$"}{mybatis-plus-boot-starter.version}</version>
        </dependency>

        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>${"$"}{commons-lang3.version}</version>
        </dependency>

        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${"$"}{lombok.version}</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
            <version>${"$"}{hutool-all.version}</version>
        </dependency>
<#if jsonParam.enableSwagger>

        <dependency>
            <groupId>com.spring4all</groupId>
            <artifactId>swagger-spring-boot-starter</artifactId>
            <version>${"$"}{swagger-spring-boot-starter.version}</version>
        </dependency>

        <dependency>
            <groupId>com.github.xiaoymin</groupId>
            <artifactId>knife4j-openapi2-ui</artifactId>
            <version>${"$"}{knife4j.version}</version>
        </dependency>

        <dependency>
            <groupId>org.yaml</groupId>
            <artifactId>snakeyaml</artifactId>
            <version>${"$"}{snakeyaml.version}</version>
        </dependency>
</#if>
<#if jsonParam.enableEhCache || jsonParam.enableRedis>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-cache</artifactId>
        </dependency>
</#if>
<#if jsonParam.enableEhCache>

        <dependency>
            <groupId>net.sf.ehcache</groupId>
            <artifactId>ehcache</artifactId>
        </dependency>
</#if>
<#if jsonParam.enableRedis>

        <dependency>
            <groupId>org.redisson</groupId>
            <artifactId>redisson-spring-boot-starter</artifactId>
            <version>${"$"}{redisson.version}</version>
        </dependency>
</#if>
<#if jsonParam.enableMongoDB>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
        </dependency>
</#if>
<#if jsonParam.enableAliyunOss>

        <dependency>
            <groupId>com.aliyun.oss</groupId>
            <artifactId>aliyun-sdk-oss</artifactId>
            <version>${"$"}{aliyun-sdk-oss.version}</version>
        </dependency>
</#if>
<#if jsonParam.enableEasyExcel>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>easyexcel</artifactId>
            <version>${"$"}{easyexcel.version}</version>
        </dependency>
</#if>

	</dependencies>

	<build>
        <finalName>${"$"}{project.name}</finalName>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<version>${"$"}{project.parent.version}</version>
			</plugin>

            <!-- 设置Maven的编译参数 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${"$"}{maven-compiler-plugin.version}</version>
                <configuration>
                    <skip>true</skip>
                    <source>${"$"}{java.version}</source>
                    <target>${"$"}{java.version}</target>
                    <encoding>${"$"}{project.build.sourceEncoding}</encoding>
                    <compilerArgument>-Xlint:deprecation</compilerArgument>
                </configuration>
            </plugin>

            <!-- Maven打包时自动打包工程源代码 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
                <version>${"$"}{maven-source-plugin.version}</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>jar-no-fork</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
<#if jsonParam.enableSmartDoc>

            <!-- https://gitee.com/smart-doc-team/smart-doc -->
            <plugin>
                <groupId>com.github.shalousun</groupId>
                <artifactId>smart-doc-maven-plugin</artifactId>
                <version>${"$"}{smart-doc-maven-plugin.version}</version>
                <configuration>
                    <!-- 指定生成文档的使用的配置文件，配置文件放在自己的项目中 -->
                    <configFile>./src/main/resources/smart-doc.json</configFile>
                    <!-- 指定项目名称 -->
                    <projectName>${"$"}{project.name}</projectName>
                    <!-- smart-doc实现自动分析依赖树加载第三方依赖的源码，如果一些框架依赖库加载不到导致报错，这时请使用excludes排除掉 -->
                    <excludes>
                        <!--格式为：groupId:artifactId 参考如下，也可以支持正则式如：com.alibaba:.*-->
                        <exclude>com.alibaba:fastjson</exclude>
                    </excludes>
                    <!-- includes配置用于配置加载外部依赖源码，配置后插件会按照配置项加载外部源代码而不是自动加载所有，因此使用时需要注意 -->
                    <!-- smart-doc能自动分析依赖树加载所有依赖源码，原则上会影响文档构建效率，因此你可以使用includes来让插件加载你配置的组件 -->
                    <includes>
                        <!-- 格式为：groupId:artifactId 参考如下，也可以支持正则式如：com.alibaba:.* -->
                        <include>com.alibaba:fastjson</include>
                    </includes>
                </configuration>
                <executions>
                    <execution>
                        <!-- 如果不需要在执行编译时启动smart-doc，则将phase注释掉 -->
                        <phase>compile</phase>
                    </execution>
                </executions>
            </plugin>
</#if>
		</plugins>
	</build>

    <profiles>
        <!-- 每次在Maven窗口中切换不同的环境时都要手动刷新一下Maven，不然 @profiles.active@ 变量可能取不到值报错 -->
        <!-- 打包开发环境：mvn clean package -Dmaven.test.skip=true -P dev -->
        <!-- 开发环境 -->
        <profile>
            <id>dev</id>
            <properties>
                <profiles.active>dev</profiles.active>
            </properties>
            <!-- 默认激活 -->
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
        </profile>

        <!-- 测试环境 -->
        <profile>
            <id>test</id>
            <properties>
                <profiles.active>test</profiles.active>
            </properties>
        </profile>

        <!-- 生产环境 -->
        <profile>
            <id>prod</id>
            <properties>
                <profiles.active>prod</profiles.active>
            </properties>
        </profile>
    </profiles>
</project>
