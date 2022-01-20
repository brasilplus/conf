#!/bin/bash
echo ""
echo -e "\033[1;31m Definindo Data/Hora. \033[0m"
echo ""
echo -e "\033[1;31m Selecionado SAO PAULO. \033[0m"
echo America/Sao_Paulo > /etc/timezone && rm /etc/localtime && ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
clear
echo ""
echo -e "\033[1;31m Instalação da CSP BRPLUS. \033[0m"
echo -e "\033[1;31m Aguarde o processo e demorado! \033[0m"
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
apt-get update  -y 
apt-get upgrade -y 
sleep 1s
apt-get install unzip unrar -y > /dev/null 2>&1
sleep 1s
apt-get install python-software-properties software-properties-common -y > /dev/null 2>&1
apt-get install default-jdk -y > /dev/null 2>&1
apt-get update > /dev/null 2>&1
cd /tmp
apt-get update
apt-get upgrade
cd /var
apt-get install zip
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
wget https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242980_a4634525489241b9a9e1aa73d9e118e6
cd /usr/lib/jvm
tar -xvzf AutoDL?BundleId=242980_a4634525489241b9a9e1aa73d9e118e6
mv jre1.8.0_261*/ jre-oracle
sudo mv jre-oracle/ /usr/lib
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jre-oracle/bin/java" 1
sudo update-alternatives --set java /usr/lib/jre-oracle/bin/java
cd /opt 
sleep 1s
wget http://brplus.top/cs/scriptcs-painel1010/wget/iniciarcsp > /dev/null 2>&1
cd /opt 
sleep 1s
wget http://brplus.top/cs/scriptcs-painel1010/wget/restartcsp > /dev/null 2>&1
cd /usr/local 
sleep 1s
wget http://brplus.top/cs/scriptcs-painel1010/wget/csp228.zip > /dev/null 2>&1
sleep 10s
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
unzip csp228.zip > /dev/null 2>&1
sleep 1s
chmod -R 7777 /opt/iniciarcsp
sleep 1s
chmod -R 7777 /opt/restartcsp
sleep 1s
chmod 777 cd /usr/local/csp/*.* 
cd /usr/local/csp/
sleep 1s
chmod 777 cd /usr/local/csp/cardproxy.sh
sleep 1s
rm -rvf csp228.zip
sleep 1s
rm -rvf /root/installcsp
sleep 1s
cd /usr/local/csp
sleep 1s
chmod -R 7777 cardproxy.sh
sleep 1s
chmod -R 7777 cluster
sleep 1s
cd /usr/local/csp
sleep 1s
./cardproxy.sh stop
./cardproxy.sh start
clear
printf '%s\n' '#!/bin/bash' 'exit 0' | sudo tee -a /etc/rc.local
sed --in-place '/exit 0/d' /etc/rc.local
echo "cd /usr/local/csp" >> /etc/rc.local
echo "./cardproxy.sh start" >> /etc/rc.local
echo "chown root:syslog /var/log" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
systemctl enable rc-local > /dev/null 2>&1
cd /etc/systemd/system
echo -e "\033[1;31m Caso o arquivo rc.local.service já existir ele perguntara se quer substituir coloque a letra n e aperte enter. \033[0m"
wget http://brplus.top/cs/scriptcs-painel1010/conf/rc-local.zip > /dev/null 2>&1
unzip rc-local.zip > /dev/null 2>&1
rm rc-local.zip > /dev/null 2>&1
chmod +x /etc/systemd/system/rc-local.service > /dev/null 2>&1
chmod +x /etc/rc.local > /dev/null 2>&1
systemctl enable rc-local > /dev/null 2>&1
cd /root
rm installcsp > /dev/null 2>&1
sleep 1s
echo -e "\033[1;31m COMPLETADO COM SUCESSO \033[0m"
echo -e "\033[1;31m Acesso: http://ipvps:8080 \033[0m"
echo -e "\033[1;31m Usuario: root senha: root \033[0m"
sleep 5s
reboot