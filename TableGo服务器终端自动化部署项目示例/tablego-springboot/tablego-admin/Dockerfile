# Welcome to use the TableGo tools
# 项目工程打包镜像

FROM openjdk:8-alpine

MAINTAINER TableGo<www.tablego.cn>

LABEL tablego-host="www.tablego.cn"

WORKDIR /

COPY ["tablego-admin.jar", "tablego-admin.jar"]

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "-Duser.timezone=Asia/Shanghai", "tablego-admin.jar"]
CMD ["--spring.profiles.active=test"]