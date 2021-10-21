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


# 替换
function otherreplace(){
    # 城城分现金
    echo "0 0 * * * node conc /scripts/jd_CityNew.js >> /scripts/logs/jd_CityNew.log 2>&1" >> /scripts/docker/merged_list_file.sh

}


 # 安装依赖插件
function npmInstall(){
      echo "npm install 安装最新依赖"
      npm install --prefix /scripts
}

function main(){
    wuzhi_diy
    jd_diy
    otherreplace
    npmInstall
}

main
