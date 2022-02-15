#!/bin/bash
mkdir -p /var/jenkins

wget --no-check-certificate https://zabbix-automation.beonup.com.br/jnlpJars/agent.jar -P /var/jenkins

bash -c 'cat > /var/jenkins/agent_beonup_startup.sh' <<-EOF
#!/bin/bash
cd /var/jenkins
/usr/bin/java -jar agent.jar -jnlpUrl $1 -secret $2 -workDir "/var/jenkins" >> /var/jenkins/agent.log 2>> /var/jenkins/agent.log
EOF

chmod +x /var/jenkins/agent_beonup_startup.sh

bash -c 'cat > /etc/systemd/system/agent_beonup_startup.service' <<-EOF
[Unit]
Description=Description for sample script goes here
After=network.target

[Service]
Type=simple
ExecStart=/var/jenkins/agent_beonup_startup.sh
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF

systemctl reload daemon
systemctl start agent_beonup_startup
systemctl enable agent_beonup_startup
