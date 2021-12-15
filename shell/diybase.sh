#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/sendNotify.js /ql/scripts
    cp -f /jd_diy/scripts/* /ql/scripts/shufflewzc_faker2
}

function main(){
    jd_diy
}

main
