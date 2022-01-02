server:
  port: ${jsonParam.port}
  servlet:
    context-path: ${jsonParam.contextPath}
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
<#if !jsonParam.enableSmartDoc?? || !jsonParam.enableSmartDoc>
swagger:
  title: ${"$"}{spring.application.name}
  description: "@project.description@API文档"
  version: 1.0.0
  contact:
    name: bianj
    email: tablego@qq.com
    url: http://www.tablego.cn
  base-package: ${jsonParam.basePackagePath}.controller
</#if>