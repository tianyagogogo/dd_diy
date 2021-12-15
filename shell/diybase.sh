#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/sendNotify.js /ql/scripts
    cp -f /jd_diy/scripts/* /ql/scripts/shufflewzc_faker2
}

function replace(){
    sed -i "s/http:\/\/transfer.nz.lu\/farm/https:\/\/ghproxy.com\/https:\/\/github.com\/l107868382\/sharcode\/blob\/main\/v1\/JD_Fruit.json/g" /ql/scripts/shufflewzc_faker2/jd_fruit.js
}

function main(){
    jd_diy
    replace
}

main
