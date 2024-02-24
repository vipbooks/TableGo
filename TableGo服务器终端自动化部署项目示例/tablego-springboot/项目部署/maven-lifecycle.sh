#!/bin/bash

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' maven-lifecycle.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x maven-lifecycle.sh

#操作命令
options=$1
#项目路径
projectPath=$2

#执行Maven命令
lifecycle(){
    if test -z "${options}"
    then
        echo Maven options cannot be empty.
        exit 1
    fi
    if test -z "${projectPath}"
    then
        echo Maven project path cannot be empty.
        exit 1
    fi
    if [ ! -d "${projectPath}" ]; then
        echo Maven project path is not exist: ${projectPath}
        exit 1
    fi
    echo Maven options: ${options}
    echo Maven project path: ${projectPath}
    cd ${projectPath}
    mvn ${options} -Dmaven.test.skip=true
}
lifecycle
