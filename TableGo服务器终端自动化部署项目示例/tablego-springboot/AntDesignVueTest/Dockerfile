# Welcome to use the TableGo tools
# 项目工程打包镜像

FROM nginx

MAINTAINER TableGo<www.tablego.cn>

LABEL tablego-host="www.tablego.cn"

WORKDIR /etc/nginx

COPY ["./dist", "/usr/share/nginx/html"]
COPY ["./nginx.conf", "/etc/nginx/conf.d/default.conf"]

RUN chmod -R 555 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]