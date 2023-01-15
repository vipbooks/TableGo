server:
  port: ${jsonParam.port}
  servlet:
    context-path: ${jsonParam.contextPath}
  tomcat:
    uri-encoding: UTF-8
    max-connections: 10000
    acceptCount: 2000
    threads:
      max: 1000
      min-spare: 20
    max-http-form-post-size: 50MB
spring:
  profiles:
    active: dev
  application:
    name: ${jsonParam.appName}
  main:
    allow-bean-definition-overriding: true
  mvc:
    format:
      date: yyyy-MM-dd
      time: HH:mm:ss
      date-time: yyyy-MM-dd HH:mm:ss
<#if jsonParam.enableSwagger>
    pathmatch:
      matching-strategy: ant_path_matcher
</#if>
  servlet:
    multipart:
      max-file-size: 50MB
      max-request-size: 50MB
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    locale: zh
    time-zone: GMT+8
    default-property-inclusion: non_null
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: ${jsonParam.projectConfig.dbDriverClassName}
    hikari:
      minimum-idle: 1
      maximum-pool-size: 10
      idle-timeout: 30000
      max-lifetime: 1800000
      connection-timeout: 30000
      connection-test-query: SELECT 1
<#if jsonParam.enableEhCache>
  cache:
    ehcache:
      config: classpath:ehcache.xml
</#if>
mybatis-plus:
  mapper-locations: classpath*:mapper/**/*Mapper.xml
  global-config:
    db-config:
      id-type: assign_id
      logic-delete-value: 0
      logic-not-delete-value: 1
      where-strategy: not_empty
      insert-strategy: not_empty
      update-strategy: not_empty
  configuration:
    map-underscore-to-camel-case: true
    cache-enabled: false
<#if jsonParam.enableSwagger>
swagger:
  title: ${"$"}{spring.application.name}
  description: "@project.description@API文档"
  version: 1.0.0
  contact:
    name: bianj
    email: tablego@qq.com
    url: http://www.tablego.cn
  base-package: ${jsonParam.basePackagePath}
  authorization:
    key-name: token
    type: None
</#if>
<#if jsonParam.enableAliyunOss>
aliyun:
  oss:
    endpoint: oss-cn-hangzhou.aliyuncs.com
    access-key-id: key-id
    access-key-secret: key-secret
    bucket-name: bucket
</#if>