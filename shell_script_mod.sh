#!/bin/sh



function diycron(){
    for jsname in /scripts/ddo_*.js /scripts/jddj_*.js /scripts/long_*.js; do
        jsnamecron="$(cat $jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node $jsname >> /scripts/logs/$(echo $jsname | cut -d/ -f3).log 2>&1" >> /scripts/docker/merged_list_file.sh
    done
    # 启用京价保
    echo "40 9 1/3 * * node /scripts/jd_price.js >> /scripts/logs/jd_price.log 2>&1" >> /scripts/docker/merged_list_file.sh
    # 修改docker_entrypoint.sh执行频率
    ln -sf /usr/local/bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint_mix.sh
    echo "18 */1 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
   
    # 京喜财富岛提现
    echo "59 23 * * * sleep 59.9; node /scripts/jx_cfdtx.js >> /scripts/logs/jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
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
    cp -f /scripts/logs/jdJxncTokens.js /scripts
    cp -f /jd_diy/scripts/*.js /scripts
}

function monk_diy(){
    ## 克隆monk-coder仓库
    if [ ! -d "/monk/" ]; then
        echo "未检查到monk-coder仓库脚本，初始化下载相关脚本..."
        #git clone -b monk https://github.com/l107868382/dd_syc.git /monk
        git clone -b dust https://github.com/monk-coder/dust.git /monk
        
    else
        echo "更新monk-coder脚本相关文件..."
        git -C /monk reset --hard
        git -C /monk pull origin dust --rebase
    fi
    cp -f /monk/car/*_*.js /scripts
    cp -f /monk/i-chenzhe/*_*.js /scripts
    cp -f /monk/member/*_*.js /scripts
    cp -f /monk/normal/*_*.js /scripts
}


function hyzaw_diy(){
    ## 克隆hyzawr仓库
    if [ ! -d "/hyzaw/" ]; then
        echo "未检查到hyzaw仓库脚本，初始化下载相关脚本..."
        #git clone -b monk https://github.com/l107868382/dd_syc.git /monk
        git clone -b main https://github.com/hyzaw/scripts.git /hyzaw
        
    else
        echo "更新hyzawr脚本相关文件..."
        git -C /hyzaw reset --hard
        git -C /hyzaw pull origin main --rebase
    fi
    cp -f /hyzaw/*_*.js /scripts
}

function jddj_diy(){
    ## 克隆jddj_diy仓库
    if [ ! -d "/jddj_diy/" ]; then
        echo "未检查到克隆jddj_diy仓库，初始化下载相关脚本..."
        git clone -b main https://github.com/717785320/JDDJ.git /jddj_diy
    else
        echo "更新jddj_diy脚本相关文件..."
        git -C /jddj_diy reset --hard
        git -C /jddj_diy pull origin main --rebase
    fi
    
    # 判断外网IP
    ip = 'curl icanhazip.com'
    echo $ip
    result= $(echo $ip | grep "43.129")
    echo $result
    if [ "$result" != "" ]; then
        rm -rf /jddj_diy/sendNotify.js
        cp -f /jddj_diy/*.js /scripts
        cp -f /scripts/logs/jddj_cookie.js /scripts
     else 
        echo '非l107868382服务器，不复制个性化代码'
    fi
    
}

# 下载龙猪猪 红包雨脚本
function longzhuzhu_diy(){
    if [ ! -d "/longzhuzhu/" ]; then
        echo "未检查到longzhuzhu仓库脚本，初始化下载相关脚本..."
        git clone -b main https://github.com/longzhuzhu/nianyu.git /longzhuzhu
    else
        echo "更新longzhuzhu脚本相关文件..."
        git -C /longzhuzhu reset --hard
        git -C /longzhuzhu pull origin main --rebase
    fi
    cp -f /longzhuzhu/qx/*_*.js /scripts
}

# yangtingxiao jd_zoo
function yangtingxiao_diy(){
    if [ ! -d "/yangtingxiao/" ]; then
        echo "未检查到yangtingxiao仓库脚本，初始化下载相关脚本..."
        git clone -b master https://github.com/yangtingxiao/QuantumultX.git /yangtingxiao
    else
        echo "更新yangtingxiao脚本相关文件..."
        git -C /yangtingxiao reset --hard
        git -C /yangtingxiao pull origin master --rebase
    fi
    cp -f /yangtingxiao/scripts/jd/jd_starStore.js /scripts
    
    # 京东星店长
    echo "5 9 * * * node /scripts/jd_starStore.js >> /scripts/logs/jd_starStore.log 2>&1" >> /scripts/docker/merged_list_file.sh
}


# 删除和lxk重复的脚本
function removeJs(){
    rm -rf /scripts/ddo_joy_reward.js
}

# 替换
function otherreplace(){
    # 注释掉 lxk jd_xtg的启动时间,新建启动时间
    sed -i "s/jd_xtg.js/jd_xtg_bak.js/g" /scripts/docker/merged_list_file.sh
    echo "0 6 * * * node /scripts/jd_xtg.js >> /scripts/logs/jd_xtg.log 2>&1" >> /scripts/docker/merged_list_file.sh
    sed -i "s/jd_xtg_help.js/jd_xtg_help_bak.js/g" /scripts/docker/merged_list_file.sh
    echo "0 6 * * * node /scripts/jd_xtg_help.js >> /scripts/logs/jd_xtg_help.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    # 重新设置手机狂欢城的启动时间---
    #sed -i "s/jd_carnivalcity.js/jd_carnivalcity_bak.js/g" /scripts/docker/merged_list_file.sh
    #echo "28 0,12,18,21 * * * node /scripts/jd_carnivalcity.js >> /scripts/logs/jd_carnivalcity.log 2>&1" >> /scripts/docker/merged_list_file.sh
    #sed -i "s/inviteCodes\[tempIndex\].split('@')/[]/g" /scripts/jd_city.js
    #sed -i "s/http:\/\/share.turinglabs.net\/api\/v3\/city\/query\/10\//https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_city.json/g" /scripts/jd_city.js
    
    
        
}


function main(){
    jddj_diy
    jd_diy
    # monk_diy
    longzhuzhu_diy
    # yangtingxiao_diy
    hyzaw_diy
    removeJs
    diycron
    otherreplace
}

main

## 拷贝京东超市兑换脚本
#cp -f /scripts/jd_blueCoin.js /scripts/l_jd_bluecoin.js
# cat /jd_diy/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

