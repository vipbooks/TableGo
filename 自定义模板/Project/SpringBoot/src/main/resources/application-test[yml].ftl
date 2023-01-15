spring:
  datasource:
    url: ${jsonParam.projectConfig.dbUrl}
    username: ${jsonParam.projectConfig.dbUsername}
    password: ${jsonParam.projectConfig.dbPassword}
<#if jsonParam.enableRedis>
  redis:
    host: ${jsonParam.projectConfig.redisHost}
    port: ${jsonParam.projectConfig.redisPort}
    database: ${jsonParam.projectConfig.redisDatabase}
</#if>
<#if jsonParam.enableMongoDB>
  data:
    mongodb:
      uri: ${jsonParam.projectConfig.mongodbUri}
</#if>
<#if jsonParam.enableSwagger>
swagger:
  enabled: true
</#if>