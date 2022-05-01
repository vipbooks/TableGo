# Welcome to use the TableGo tools
# 项目工程打包镜像

FROM openjdk:8-alpine

MAINTAINER bianj

WORKDIR /

COPY ["tablego-iam.jar", "tablego-iam.jar"]

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "-Duser.timezone=Asia/Shanghai", "tablego-iam.jar"]
CMD ["--spring.profiles.active=test"]