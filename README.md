# Zabbix Speedtest Sender

With this method is the Zabbix agent that send the value to the server

Monitoring the speedtest on one preferred ISP server by send value to Zabbix server

# How is work

In the zabbix_speedtest.sh there is set the id on which made the speedtest.

On the agent the file zabbix_speedtest.sh is runned every 10 minutes and it send the data (upload and download speed) to Zabbix server.


# Install instruction

- Install the speedtest-cli (pip install speedtest-cli)
- Copy the `zabbix_speedtest.sh` to `/etc/zabbix/script` and make executable: `chmod +x /etc/zabbix/script/zabbix_speedtest.sh`
- Set the crontab by copy the `speedtest.cron` to `/etc/cron.d`
- Import `template_speedtest_sender.xml` on your Zabbix server