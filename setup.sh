#!/bin/bash
mkdir -p /var/jenkins

wget https://zabbix-automation.beonup.com.br/jnlpJars/agent.jar -P /var/jenkins

echo "#!/bin/bash \
cd /var/jenkins \
/usr/bin/java -jar agent.jar -jnlpUrl $1 -secret $2 -workDir "/var/jenkins" >> /var/jenkins/agent.log 2>> /var/jenkins/agent.log" >> /var/jenkins/agent_beonup_startup.sh

chmod +x /var/jenkins/agent_beonup_startup.sh

echo "[Unit] \
Description=Description for sample script goes here \
After=network.target \
 \
[Service] \
Type=simple \
ExecStart=/var/jenkins/agent_beonup_startup.sh \
TimeoutStartSec=0 \
 \
[Install] \
WantedBy=default.target" > /etc/systemd/system/agent_beonup_startup.service

systemctl reload daemon
systemctl start agent_beonup_startup
systemctl enable agent_beonup_startup
