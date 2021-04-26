#!/bin/sh

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

function diycron(){
    # monkcoder whyour 定时任务
    for jsname in /scripts/dust_*.js /scripts/whyour_*.js /scripts/z_*.js /scripts/monk_*.js; do
        jsnamecron="$(cat $jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node $jsname >> /scripts/logs/$(echo $jsname | cut -d/ -f3).log 2>&1" >> /scripts/docker/merged_list_file.sh
    done
    # 启用京价保
    # echo "23 8 * * * node /scripts/jd_price.js >> /scripts/logs/jd_price.log 2>&1" >> /scripts/docker/merged_list_file.sh
    # 修改docker_entrypoint.sh执行频率
    ln -sf /usr/local/bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint_mix.sh
    echo "18 */1 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
    # 整点京豆雨
    echo "0 0-23/1 * * * node /scripts/jd_super_redrain.js >> /scripts/logs/jd_super_redrain.log 2>&1" >> /scripts/docker/merged_list_file.sh
    # 京喜财富岛提现
    echo "59 23 * * * sleep 59; node /scripts/l_jx_cfdtx.js >> /scripts/logs/l_jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh
    # 赚京豆(微信小程序)
    echo "10,21,32,43,56 5 * * * node /scripts/jd_syj.js >> /scripts/logs/jd_syj.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
}

function jd_diy(){
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
    
}

function jddj_diy(){
    ## 克隆jddj_diy仓库
    if [ ! -d "/jddj_diy/" ]; then
        echo "未检查到克隆jd_diy仓库，初始化下载相关脚本..."
        git clone -b main https://github.com/717785320/JDDJ.git /jddj_diy
    else
        echo "更新jd_diy脚本相关文件..."
        git -C /jddj_diy reset --hard
        git -C /jddj_diy pull origin main --rebase
    fi
    cp -f /jddj_diy/*.js /scripts
    cp -f /scripts/logs/jddj_cookie.js /scripts
    
    #京东到家鲜豆任务脚本
    echo "10 8 * * * node /scripts/jddj_bean.js >> /scripts/logs/jddj_bean.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #京东到家果园任务脚本
    echo "10 8,11,17 * * * node /scripts/jddj_fruit.js >> /scripts/logs/jddj_fruit.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    # 京东到家果园水车收水滴任务脚本
    echo "15 8,11,17 * * * node /scripts/jddj_fruit_collectWater.js >> /scripts/logs/jddj_fruit_collectWater.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #京东到家鲜豆庄园收水滴脚本
    echo "*/20 * * * * node /scripts/jddj_getPoints.js >> /scripts/logs/jddj_getPoints.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #京东到家鲜豆庄园脚本
    echo "15 8 * * * node /scripts/jddj_plantBeans.js >> /scripts/logs/jddj_plantBeans.log 2>&1" >> /scripts/docker/merged_list_file.sh 
    
}

function main(){
    jddj_diy
    jd_diy
    diycron
}

main

## 拷贝京东超市兑换脚本
#cp -f /scripts/jd_blueCoin.js /scripts/l_jd_bluecoin.js
# cat /jd_diy/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh
