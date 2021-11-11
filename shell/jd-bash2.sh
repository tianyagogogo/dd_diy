#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/*.js /scripts
    cat /dev/null > /scripts/docker/auto_help.sh
    cat /jd_diy/shell/auto_help.sh >> /scripts/docker/auto_help.sh
}

# wuzhi_diy
function wuzhi_diy(){
    if [ ! -d "/wuzhi/" ]; then
        echo "未检查到wuzhi仓库脚本，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/wuzhi05/MyActions.git /wuzhi
    else
        echo "更新wuzhi脚本相关文件..."
        git -C /wuzhi reset --hard
        git -C /wuzhi pull origin main --rebase
    fi
  
    cp -f /wuzhi/*.js /wuzhi/package.json /scripts
    cp -f /wuzhi/utils/*.js /scripts/utils
    if [ ! -d /scripts/function  ];then
      mkdir /scripts/function
    else
      echo dir exist
    fi
    cp -f /wuzhi/function/*.js /scripts/function
    cat /dev/null > /scripts/docker/merged_list_file.sh
    #cat /wuzhi/docker/crontab_list.sh >> /scripts/docker/merged_list_file.sh
}


# faker3
function faker3_diy(){
    if [ ! -d "/faker3/" ]; then
        echo "未检查到faker3仓库脚本，初始化下载相关脚本..."
        git clone -b main https://github.com/shufflewzc/faker3.git /faker3
    else
        echo "更新faker3脚本相关文件..."
        git -C /faker3 reset --hard
        git -C /faker3 pull origin main --rebase
    fi
  
    cp -f /faker3/*.js /faker3/package.json /scripts
    cp -f /faker3/utils/*.js /scripts/utils
    cat /dev/null > /scripts/docker/merged_list_file.sh
     if [ ! -d /scripts/function  ];then
      mkdir /scripts/function
    else
      echo dir exist
    fi
    cp -f /faker3/function/*.js /scripts/function
    
    for jsname in /scripts/jd_*.js,/scripts/jddj_*.js ; do
        jsnamecron="$(cat $jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node $jsname >> /scripts/logs/$(echo $jsname | cut -d/ -f3).log 2>&1" >> /scripts/docker/merged_list_file.sh
   done

}

# 替换
function otherreplace(){
    echo " otherreplace "    
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Fruit.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Fruit.json/g" /scripts/jd_fruit.js
    sed -i "s/let helpAuthor = true/let helpAuthor = false/g" /scripts/jd_fruit.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Cash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Cash.json/g" /scripts/jd_cash.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_updateCash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_updateCash.json/g" /scripts/jd_cash.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_red.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_red.json/g" /scripts/jd_redPacket.js
    #city
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_cityShareCodes.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_city.json/g" /scripts/jd_CityNew.js
    #惊喜88红包
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_redhb.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_redhb.json/g" /scripts/jd_jxlhb.js

    # 城城分现金
    # echo "0 0 * * * node conc /scripts/jd_CityNew.js >> /scripts/logs/jd_CityNew.log 2>&1" >> /scripts/docker/merged_list_file.sh

}


 # 安装依赖插件
function npmInstall(){
      echo "npm install 安装最新依赖"
      npm install --prefix /scripts
}




function main(){
    faker3_diy
    #wuzhi_diy
    #jd_diy
    #otherreplace
    #npmInstall
}

main
