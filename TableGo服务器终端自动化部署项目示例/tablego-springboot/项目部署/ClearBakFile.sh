#!/bin/bash
#按参数自动清理旧备份文件的脚本(按备份时间保留最新的几个文件)

#Welcome to use the TableGo tools
#把Window中编辑产生的 \r 替换成空白：sed -i 's/\r$//' ClearBakFiles.sh
#给文件夹添加权限：sudo chmod -R 755 目标目录   或   sudo chmod -R 777 目标目录
#添加可执行权限：sudo chmod +x ClearBakFiles.sh
#配置脚本运行参数
bakDir=/bak
fileExt=jar
saveFileNum=10

#清理旧备份文件
delBakFile() {
    echo 自动清理旧备份文件开始
    #检查 bakDir 目录是否存在
    if [ ! -d ${bakDir} ]; then
        echo "${bakDir} 目录不存在"
        exit 1
    fi

    cd ${bakDir}
    echo 当前目录：`pwd`
    fileNum=`ls -l *.${fileExt} | grep "^-" | wc -l`
    echo "*.${fileExt} 扩展名备份文件数：${fileNum}，保存备份文件数：${saveFileNum}"
    ls -lhtr *.${fileExt}

    #判断已有备份文件数是否超过保存备份文件数量
    if [ ${fileNum} -gt ${saveFileNum} ]; then
        echo 已有备份文件数超过保存备份文件数量，开始按备份时间清理旧备份文件

        saveFiles=`ls -tr *.${fileExt} | tail -${saveFileNum}`
        rm -vf `ls -tr *.${fileExt} | grep -v "${saveFiles}"`

        echo "清理后留下扩展名 *.${fileExt} 的备份文件"
        ls -lhtr *.${fileExt}
    else
        echo 已有备份文件数未超过保存备份文件数量不予清理
    fi
    echo 自动清理旧备份文件结束
}

#使用说明，用来提示输入参数
usage() {
    echo "d：对应 bakDir 参数，备份文件目录"
    echo "e：对应 fileExt 参数，备份文件扩展名"
    echo "n：对应 saveFileNum 参数，保存备份文件数量"
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
#清理旧备份文件
delBakFile
