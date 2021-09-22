#!/bin/sh

function diycron(){

  # 修改docker_entrypoint.sh执行频率
  ln -sf /usr/local/bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint_mix.sh
  echo "18 */1 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
  echo "18 */1 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
  #收集助力码
  echo "30 * * * * sh +x /scripts/docker/auto_help.sh collect |ts >> /scripts/logs/auto_help_collect.log 2>&1" >> /scripts/docker/merged_list_file.sh
  # 京东月资产变动通知
  echo "10 7 1-31/7 * * node /scripts/jd_all_bean_change.js >> /scripts/logs/jd_all_bean_change.log 2>&1" >> /scripts/docker/merged_list_file.sh
  # 领现金兑换红包
  echo "59 23 * * 4,5 sleep 59.7; node conc /scripts/jd_cash_exchange.js >> /scripts/logs/jd_cash_exchange.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
}


function jd_diy(){
   # cp -f /scripts/logs/jdJxncTokens.js /scripts
    cp -f /jd_diy/scripts/*.js /scripts
    cat /dev/null > /scripts/docker/auto_help.sh
    cat /jd_diy/shell/auto_help.sh >> /scripts/docker/auto_help.sh
}



function jddj_diy(){
    ## 克隆jddj_diy仓库
    if [ ! -d "/jddj_diy/" ]; then
        echo "未检查到克隆jddj_diy仓库，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/717785320/JDDJ.git /jddj_diy
    else
        echo "更新jddj_diy脚本相关文件..."
        git -C /jddj_diy reset --hard
        git -C /jddj_diy pull origin main --rebase
    fi  
    cp -f /jddj_diy/jddj_*.js /scripts
}




# wuzhi_diy
function wuzhi_diy(){
    if [ ! -d "/wuzhi/" ]; then
        echo "未检查到wuzhi仓库脚本，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/wuzhi04/MyActions.git /wuzhi
    else
        echo "更新wuzhi脚本相关文件..."
        git -C /wuzhi reset --hard
        git -C /wuzhi pull origin main --rebase
    fi
  
    cp -f /wuzhi/*.js /wuzhi/package.json /scripts
    cp -f /wuzhi/utils/*.js /scripts/utils
    cat /dev/null > /scripts/docker/merged_list_file.sh
    cat /wuzhi/docker/crontab_list.sh >> /scripts/docker/merged_list_file.sh
    sed -i "s/jx_cfdtx.js/jx_cfdtx_bak.js/g" /scripts/docker/merged_list_file.sh
}



# 替换
function otherreplace(){
    echo " otherreplace "    
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Fruit.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Fruit.json/g" /scripts/jd_fruit.js
    sed -i "s/let helpAuthor = true/let helpAuthor = false/g" /scripts/jd_fruit.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Cash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Cash.json/g" /scripts/jd_cash.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_updateCash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_updateCash.json/g" /scripts/jd_cash.js
    
    #惊喜88红包
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_redhb.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_redhb.json/g" /scripts/jd_jxlhb.js
    
    # 注释jd_bean_change_clean.js 不执行
    sed -ie '/jd_bean_change_clean.js/d' /scripts/docker/merged_list_file.sh
    
    # 注释jd_redPacket.js 不执行
    sed -ie '/jd_redPacket.js/d' /scripts/docker/merged_list_file.sh
    echo "12 0-23/4 * * * node /scripts/jd_redPacket.js >> /scripts/logs/jd_redPacket.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    # 注释京东试用 不执行
    sed -i "s/jd_try_new.js/jd_try_new_back.js/g" /scripts/docker/merged_list_file.sh
    
    # 注释京喜财富岛提现
    sed -ie '/jx_cfdtx.js/d' /scripts/docker/merged_list_file.sh
    
    #京豆变化
    sed -ie '/jd_bean_change.js/d' /scripts/docker/merged_list_file.sh
    echo "0 9,20 * * * node /scripts/jd_bean_change.js >> /scripts/logs/jd_bean_change.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #东东工厂
    sed -ie '/jd_jdfactory.js/d' /scripts/docker/merged_list_file.sh
    echo "26 * * * * node /scripts/jd_bean_change.js >> /scripts/logs/jd_bean_change.log 2>&1" >> /scripts/docker/merged_list_file.sh
 
}



function main(){
  
    wuzhi_diy
    jd_diy
    diycron
    otherreplace
}

main
