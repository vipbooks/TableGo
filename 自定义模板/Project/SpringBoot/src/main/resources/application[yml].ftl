server:
  port: ${jsonParam.port}
  servlet:
    context-path: ${jsonParam.contextPath}
  tomcat:
    uri-encoding: UTF-8
    max-connections: 8192
    accept-count: 100
    connection-timeout: 20000
    keep-alive-timeout: 20000
    threads:
      max: 200
      min-spare: 10
    max-keep-alive-requests: 100
    max-http-form-post-size: 50MB
spring:
  profiles:
    active: "@profiles.active@"
  application:
    name: ${jsonParam.appName}
  main:
    allow-circular-references: true
    allow-bean-definition-overriding: true
  mvc:
    format:
      date: yyyy-MM-dd
      time: HH:mm:ss
      date-time: yyyy-MM-dd HH:mm:ss
<#if jsonParam.enableSwagger>
    pathmatch:
      matching-strategy: ANT_PATH_MATCHER
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
      logic-delete-value: 1
      logic-not-delete-value: 0
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