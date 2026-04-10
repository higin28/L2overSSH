#!/bin/sh
# Run L2SSH.sh via cron every 10 minutes.
# */10 * * * * /path_to_file/L2SSH11.sh
r_host=xxx.xxx.xxx.xxx
r_port=20070
r_user=username
r_gw=yyy.yyy.yyy.yyy

tapstat=$(ps aux |grep Tunnel=ethernet |awk '{print$16}' |grep 10:2)
pingstat=$(ping -c 2 ${r_gw} |grep time=)

if [ -z ${tapstat} ]; then
        echo "L2 tunnel is missing"
        ssh -o Tunnel=ethernet -f -w 10:2 ${r_user}@${r_host} -p ${r_port} true
elif [ -z ${pingstat} ]; then
        echo "PING on L2 tunnel is missing"
        ssh -o Tunnel=ethernet -f -w 10:2 ${r_user}@${r_host} -p ${r_port} true
else
	echo "L2 tunnel is UP"
fi
