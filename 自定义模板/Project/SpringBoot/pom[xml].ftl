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

        <mysql-connector-java.version>${jsonParam.version.mysqlConnectorJava}</mysql-connector-java.version>
        <mybatis-plus-boot-starter.version>${jsonParam.version.mybatisPlusBootStarter}</mybatis-plus-boot-starter.version>
        <swagger-spring-boot-starter.version>${jsonParam.version.swaggerSpringBootStarter}</swagger-spring-boot-starter.version>
        <hibernate-validator.version>${jsonParam.version.hibernateValidator}</hibernate-validator.version>
        <commons-lang3.version>${jsonParam.version.commonsLang3}</commons-lang3.version>
        <knife4j.version>${jsonParam.version.knife4j}</knife4j.version>
        <snakeyaml.version>${jsonParam.version.snakeyaml}</snakeyaml.version>
        <lombok.version>${jsonParam.version.lombok}</lombok.version>
        <hutool-all.version>${jsonParam.version.hutoolAll}</hutool-all.version>

        <maven-compiler-plugin.version>${jsonParam.version.mavenCompilerPlugin}</maven-compiler-plugin.version>
        <maven-source-plugin.version>${jsonParam.version.mavenSourcePlugin}</maven-source-plugin.version>
        <maven-surefire-plugin.version>${jsonParam.version.mavenSurefirePlugin}</maven-surefire-plugin.version>
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
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>${"$"}{mysql-connector-java.version}</version>
            <scope>runtime</scope>
        </dependency>

        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>${"$"}{mybatis-plus-boot-starter.version}</version>
        </dependency>

        <dependency>
            <groupId>com.spring4all</groupId>
            <artifactId>swagger-spring-boot-starter</artifactId>
            <version>${"$"}{swagger-spring-boot-starter.version}</version>
        </dependency>

        <dependency>
            <groupId>com.github.xiaoymin</groupId>
            <artifactId>knife4j-spring-ui</artifactId>
            <version>${"$"}{knife4j.version}</version>
        </dependency>

        <dependency>
            <groupId>org.hibernate.validator</groupId>
            <artifactId>hibernate-validator</artifactId>
            <version>${"$"}{hibernate-validator.version}</version>
        </dependency>

        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>${"$"}{commons-lang3.version}</version>
        </dependency>

        <dependency>
            <groupId>org.yaml</groupId>
            <artifactId>snakeyaml</artifactId>
            <version>${"$"}{snakeyaml.version}</version>
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
	</dependencies>

	<build>
        <finalName>${"$"}{project.name}</finalName>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
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

            <!-- Maven打包时跳过单元测试的运行，也跳过测试代码的编译 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>${"$"}{maven-surefire-plugin.version}</version>
                <configuration>
                    <skip>true</skip>
                </configuration>
            </plugin>
		</plugins>
	</build>
</project>
