#!/bin/bash
#按参数运行Jar应用程序的脚本

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' AppService.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x AppService.sh
#使用nohup启动项目：nohup java -jar ${appName}.jar --spring.profiles.active=test > ${appName}.log 2>&1 &
#使用setsid启动项目：setsid java -jar ${appName}.jar --spring.profiles.active=test > ${appName}.log 2>&1 &
#根据名称批量终止进程：kill -9 `ps -ef | grep ${appName} | grep -v grep | awk '{print $2}'`
#配置脚本运行参数
appName=serviceName
appJarName=${appName}.jar
profile=dev
appPort=8080

#检查程序是否在运行，$1表示第一个参数
is_exist(){
    pid=`ps -ef | grep $1 | grep -v grep | awk '{print $2}'`
    #如果不存在返回1，存在返回0
    if [ -z "${pid}" ]; then
        return 1
    else
        return 0
    fi
}

#启动服务
start(){
    is_exist ${appJarName}
    if [ $? -eq "0" ]; then
        echo "${appJarName} is already running. Pid: ${pid}."
    else
        nohup java -jar ${appJarName} -Xms256m -Xmx1024m --spring.profiles.active=${profile} --server.port=${appPort} > ${appName}.log 2>&1 &
        echo "${appJarName} startup. AppPort: ${appPort}."
    fi
}

#停止服务
stop(){
    is_exist ${appJarName}
    if [ $? -eq "0" ]; then
        kill -9 $pid
        echo "${appJarName} stop."
    else
        echo "${appJarName} is not running."
    fi
}

#查看服务运行状态
status(){
    is_exist ${appJarName}
    if [ $? -eq "0" ]; then
        echo "${appJarName} is running. Pid: ${pid}."
    else
        echo "${appJarName} is not running."
    fi
}

#重启服务
restart(){
    stop
    sleep 1s
    start
}

#初始化参数
initArgs(){
    if test ! -z "$1"
    then
      appName=$1
      appJarName=${appName}.jar
    fi

    if test ! -z "$2"
    then
      profile=$2
    fi

    if test ! -z "$3"
    then
      appPort=$3
    fi
}

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh ${appName}.sh [start|stop|restart|status]"
    exit 1
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明，$1表示第一个参数
case "$1" in
  "start")
    initArgs $2 $3 $4
    start
    ;;
  "stop")
    initArgs $2
    stop
    ;;
  "status")
    initArgs $2
    status
    ;;
  "restart")
    initArgs $2 $3 $4
    restart
    ;;
   *)
    usage
    ;;
esac