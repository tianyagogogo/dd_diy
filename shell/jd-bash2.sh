#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/*.js /scripts
    cat /dev/null > /scripts/docker/auto_help.sh
    cat /jd_diy/shell/auto_help.sh >> /scripts/docker/auto_help.sh
}


function main(){
   jd_diy
   cat /dev/null > /scripts/docker/merged_list_file.sh
   echo "25 16 * * * node /scripts/jd_speed_sign.js >> /scripts/logs/jd_speed_sign.log 2>&1" >> /scripts/docker/merged_list_file.sh
}

main
