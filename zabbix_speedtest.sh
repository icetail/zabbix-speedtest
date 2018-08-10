#!/bin/bash
#
# Variables
stc_cmd="/usr/bin/speedtest" 	# Path to the Speedtest-cli
stc_log="/tmp/speedtest.log"			# Path to the temporary log
zabbix_sender="/usr/bin/zabbix_sender"		# Path to zabbix-sender
zabbix_config="/etc/zabbix/zabbix_agentd.conf"	# Path to the zabbix-agentd.conf 

# run speedtest-cli and create temporary log
$stc_cmd --simple --server 3997 | egrep "Download|Upload" | awk '{OFS="\t";print $2}' > $stc_log

#--server 8211 is CDLAN Srl Milan 95.157.69.67
#--server 2824 is H3G Milan 62.13.169.228
#--server 3997 is EOLO 88.149.202.248
#--server 4318 is Tiscali Cagliari 94.32.110.92


# Extract download speed from temporary log 
#speedtest_down=$(sed -n '1p;1q' $stc_log) | awk '{printf("%.0f\n", $1)}')
down=$(sed -n '1p;1q' $stc_log)
# Send value to zabbix server
$zabbix_sender -c $zabbix_config -k speedtest.down -o $down &>> $stc_log

# Extract upload speed from temporary log
#speedtest_up=$((sed -n '2p;2q' $stc_log) | awk '{printf("%.0f\n", $1)}')
up=$(sed -n '2p;2q' $stc_log)
# Send value to zabbix server
$zabbix_sender -c $zabbix_config -k speedtest.up -o $up &>> $stc_log

