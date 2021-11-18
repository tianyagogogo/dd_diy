#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/*.js /scripts
    cat /dev/null > /scripts/docker/auto_help.sh
    cat /jd_diy/shell/auto_help.sh >> /scripts/docker/auto_help.sh
}


function main(){
   jd_diy
   cat /dev/null > /scripts/docker/merged_list_file.sh
   
   # 极速版签到
   echo "25 12 * * * sh +x /scripts/logs/synck.sh node /scripts/jd_speed_sign.js >> /scripts/logs/jd_speed_sign.log 2>&1" >> /scripts/docker/merged_list_file.sh
   
   # 极速版红包
   echo "25 6 * * * sh +x /scripts/logs/synck.sh node /scripts/jd_speed_redpocke.js >> /scripts/logs/jd_speed_redpocke.log 2>&1" >> /scripts/docker/merged_list_file.sh
   
}

main
