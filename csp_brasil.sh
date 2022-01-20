#!/bin/bash
echo ""
echo -e "\033[1;31m Definindo Data/Hora. \033[0m"
echo ""
echo -e "\033[1;31m Selecionado SAO PAULO. \033[0m"
echo America/Sao_Paulo > /etc/timezone && rm /etc/localtime && ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
clear
echo ""
echo -e "\033[1;31m Instalação da CSP GhostCS. \033[0m"
echo -e "\033[1;31m Aguarde o processo e demorado! \033[0m"
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
apt-get update > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1
sleep 1s
apt-get install unzip unrar -y > /dev/null 2>&1
sleep 1s
apt-get install python-software-properties software-properties-common -y > /dev/null 2>&1
apt-get install default-jdk -y > /dev/null 2>&1
apt-get update > /dev/null 2>&1
cd /tmp
wget http://cspainel.ddns.net/cs/scriptcs-painel2020/wget/jdk-8u162-linux-x64.tar.gz > /dev/null 2>&1
tar -xvzf jdk-8u162-linux-x64.tar.gz > /dev/null 2>&1
mv jdk1.8.0_162 /jre-oracle > /dev/null 2>&1
mv /jre-oracle /usr/lib > /dev/null 2>&1
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jre-oracle/bin/java" 1 > /dev/null 2>&1
update-alternatives --set java /usr/lib/jre-oracle/bin/java > /dev/null 2>&1
cd /opt 
sleep 1s
wget http://cspainel.ddns.net/cs/scriptcs-painel2020/wget/csp2.zip > /dev/null 2>&1
sleep 20s
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
unzip csp2.zip > /dev/null 2>&1
sleep 1s
chmod -R 7777 /opt/iniciarcsp
sleep 1s
chmod 775 /opt/csp/*.* 
sleep 1s
chmod 775 /opt/csp/cardproxy.sh
sleep 1s
rm -rvf csp2.zip
sleep 1s
rm -rvf /root/installcsp
sleep 1s
cd /opt/csp
sleep 1s
chmod -R 7777 cardproxy.sh
sleep 1s
chmod -R 7777 cluster
sleep 1s
cd /opt/csp
sleep 1s
./cardproxy.sh start
clear
printf '%s\n' '#!/bin/bash' 'exit 0' | sudo tee -a /etc/rc.local
sed --in-place '/exit 0/d' /etc/rc.local
echo "cd /opt/csp" >> /etc/rc.local
echo "./cardproxy.sh start" >> /etc/rc.local
echo "chown root:syslog /var/log" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
systemctl enable rc-local > /dev/null 2>&1
cd /etc/systemd/system
echo -e "\033[1;31m Caso o arquivo rc.local.service já existir ele perguntara se quer substituir coloque a letra n e aperte enter. \033[0m"
wget http://cspainel.ddns.net/cs/scriptcs-painel2020/conf/rc-local.zip > /dev/null 2>&1
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