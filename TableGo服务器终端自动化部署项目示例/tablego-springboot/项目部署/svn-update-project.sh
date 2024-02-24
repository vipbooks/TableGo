#!/bin/bash

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' svn-update-project.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x svn-update-project.sh

#项目路径
projectPath=$1

#更新文件
update(){
    if test -z "${projectPath}"
    then
        echo SVN project path cannot be empty.
        exit 1
    fi
    if [ ! -d "${projectPath}" ]; then
        echo SVN project path is not exist: ${projectPath}
        exit 1
    fi
    echo SVN project path: ${projectPath}
    svn update ${projectPath}
}
update
