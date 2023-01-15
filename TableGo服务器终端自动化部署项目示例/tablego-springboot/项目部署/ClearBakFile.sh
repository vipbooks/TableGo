#!/bin/bash
#按参数自动清除旧的备份文件的脚本(按修改时间保留最新的几个文件)

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' ClearBakFiles.sh
#给文件夹添加最高权限：chmod -R 777 项目目录
#添加可执行权限：sudo chmod +x ClearBakFiles.sh
#配置脚本运行参数
bakDir=/bak
fileExt=jar
saveFileNum=10

#删除旧的备份文件
delBakFile() {
    #检查bakDir目录是否存在
    if [ ! -d ${bakDir} ]; then
        echo "${bakDir} 目录不存在"
        exit 1
    fi

    cd ${bakDir}
    echo 当前目录：`pwd`
    fileNum=`ls -l *.${fileExt} | grep "^-" | wc -l`
    echo "*.${fileExt} 扩展名文件数：${fileNum}，保留文件数：${saveFileNum}"
    ls -ltr *.${fileExt}

    #判断文件数是否超过保存文件数量
    if [ ${fileNum} -gt ${saveFileNum} ]; then
        echo 文件数超过文件保存数量，开始按修改时间清理旧文件

        saveFiles=`ls -tr *.${fileExt} | tail -${saveFileNum}`
        rm -vf `ls -tr *.${fileExt} | grep -v "${saveFiles}"`

        echo 清理后留下的文件
        ls -ltr *.${fileExt}
    else
        echo 文件数未超过文件保存数量不予清理
    fi
}

#使用说明，用来提示输入参数
usage() {
    echo "d：对应 bakDir 参数，备份文件目录"
    echo "e：对应 fileExt 参数，备份文件扩展名"
    echo "n：对应 saveFileNum 参数，文件保存数量"
    echo "例如：sh ClearBakFile.sh -d /nginx/bak -e conf -n 3"
    exit 1
}

#获取输入参数
while getopts ":d:e:n:" OPT; do
    case $OPT in
        d)
#          echo $OPT=$OPTARG
          if test ! -z "$OPTARG"
          then
            bakDir=$OPTARG
          fi
          ;;
        e)
#          echo $OPT=$OPTARG
          if test ! -z "$OPTARG"
          then
            fileExt=$OPTARG
          fi
          ;;
        n)
#          echo $OPT=$OPTARG
          if test ! -z "$OPTARG"
          then
            saveFileNum=$OPTARG
          fi
          ;;
        *)
          usage
          ;;
    esac
done
#删除旧的备份文件
delBakFile
