#!/bin/bash
#按参数自动清除Docker旧备份镜像的脚本(按备份时间保留最新的几个镜像)

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' ClearDockerBakImage.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x ClearDockerBakImage.sh
#配置脚本运行参数
bakImagePrefix=tablego
saveImageNum=6

#删除Docker旧的备份镜像
delDockerBakImage() {
    imageNum=`docker images | grep ${bakImagePrefix} | wc -l`
    echo "前缀 ${bakImagePrefix} 的备份镜像数：${imageNum}，保留备份镜像数：${saveImageNum}"
    docker images | grep ${bakImagePrefix} | sort -nr

    #判断已有备份镜像数是否超过保存备份镜像数量
    if [ ${imageNum} -gt ${saveImageNum} ]; then
        echo 已有备份镜像数超过保存备份镜像数量，开始按备份时间清理旧备份镜像

        docker rmi `docker images | grep ${bakImagePrefix} | sort -nr | tail -$((imageNum - saveImageNum)) | awk '{print $1}'`

        echo "清理后留下前缀 ${bakImagePrefix} 的备份镜像"
        docker images | grep ${bakImagePrefix} | sort -nr
    else
        echo 已有备份镜像数未超过保存备份镜像数量不予清理
    fi
}

#使用说明，用来提示输入参数
usage() {
    echo "p：对应 bakImagePrefix 参数，备份镜像的前缀"
    echo "n：对应 saveImageNum 参数，保存备份镜像数量"
    echo "例如：sh ClearDockerBakImage.sh -p tablego-admin_ -n 3"
    exit 1
}

#获取输入参数
while getopts ":p:n:" OPT; do
    case $OPT in
        p)
#          echo $OPT=$OPTARG
          if test ! -z "$OPTARG"
          then
            bakImagePrefix=$OPTARG
          fi
          ;;
        n)
#          echo $OPT=$OPTARG
          if test ! -z "$OPTARG"
          then
            saveImageNum=$OPTARG
          fi
          ;;
        *)
          usage
          ;;
    esac
done
#删除Docker旧的备份镜像
delDockerBakImage
