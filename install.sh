#!/bin/bash

SERVICES="sshd|zabbix-agent|nginx|lion|redis|postgresql"

echo $SERVICES > /etc/zabbix/service_discovery_whitelist
cp userparameter_systemd_services.conf 	\
	/etc/zabbix/zabbix_agentd.d/userparameter_systemd_services.conf
cp ./zbx_service_restart_check.sh  /usr/local/bin/zbx_service_restart_check.sh
cp ./zbx_service_discovery.sh      /usr/local/bin/zbx_service_discovery.sh
chmod +x /usr/local/bin/zbx_service*.sh 
restorecon -v /usr/local/bin/zbx_service*.sh
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
setenforce permissive
systemctl restart zabbix-agent

