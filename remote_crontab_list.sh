# 惊喜财富岛体现
0 0 * * * node conc /scripts/l_jx_cfdtx.js |ts >> /scripts/logs/l_jx_cfdtx.log 2>&1

# 京东超市兑换
59 23 * * * sleep 59; node conc /scripts/l_jd_bluecoin.js |ts >> /scripts/logs/l_jd_bluecoin.log 2>&1

# monk_inter_shop_sign
0 0 * * * node /scripts/monk_inter_shop_sign.js |ts >> /scripts/logs/monk_inter_shop_sign.log 2>&1

#母婴-跳一跳
5 8,14,20 6-13 4 * node /scripts/z_mother_jump.js |ts >> /scripts/logs/z_mother_jump.log 2>&1

