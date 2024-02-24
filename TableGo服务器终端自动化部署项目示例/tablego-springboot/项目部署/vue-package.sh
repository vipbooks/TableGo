#!/bin/bash

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' vue-package.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x vue-package.sh

#操作命令
options=$1
#项目路径
projectPath=$2

#执行Maven命令
package(){
    if test -z "${options}"
    then
        echo NPM options cannot be empty.
        exit 1
    fi
    if test -z "${projectPath}"
    then
        echo Vue project path cannot be empty.
        exit 1
    fi
    if [ ! -d "${projectPath}" ]; then
        echo Vue project path is not exist: ${projectPath}
        exit 1
    fi
    echo NPM options: ${options}
    echo Vue project path: ${projectPath}
    cd ${projectPath}
    npm run ${options}
}
package
