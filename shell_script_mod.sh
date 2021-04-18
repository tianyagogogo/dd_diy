#!/bin/sh

## 克隆jd_diy仓库
if [ ! -d "/jd_diy/" ]; then
    echo "未检查到克隆jd_diy仓库，初始化下载相关脚本..."
    git clone -b lxk0301_shell https://github.com/l107868382/dd_diy.git /jd_diy
else
    echo "更新jd_diy脚本相关文件..."
    git -C /jd_diy reset --hard
    git -C /jd_diy pull origin lxk0301_shell --rebase
fi
cp -f /jd_diy/scripts/*.js /scripts

## 克隆monk-coder仓库
#if [ ! -d "/monk/" ]; then
#    echo "未检查到monk-coder仓库脚本，初始化下载相关脚本..."
#    git clone -b monk https://github.com/l107868382/dd_syc.git /monk
#else
#    echo "更新monk-coder脚本相关文件..."
#    git -C /monk reset --hard
#    git -C /monk pull origin monk --rebase
#fi
#cp -f /monk/car/*_*.js /scripts
#cp -f /monk/i-chenzhe/*_*.js /scripts
#cp -f /monk/member/*_*.js /scripts
#cp -f /monk/normal/*_*.js /scripts

## 拷贝京东超市兑换脚本
#cp -f /scripts/jd_blueCoin.js /scripts/l_jd_bluecoin.js
cat /jd_diy/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh
