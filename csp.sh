#!/bin/bash

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "[+] ATUALIZANDO O SISTEMA"
apt-get -y update
apt-get install zip

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "[+] INSTALANDO JAVA"
apt-get -y update
sudo apt-get install python-software-properties software-properties-common
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get -y update
apt-get install oracle-java8-installer

echo "[+] INSTALANDO CSP"
cd /usr/local
wget http://Entrarpainel.16mb.com/ssh/csp_228.zip
unzip csp_288.zip
chmod 777 * -R /opt/csp
rm -rf csp_228.zip

echo "[+] REINICIANDO A CSP"
cd /etc/init.d
wget http://Entrarpainel.16mb.com/ssh/checksrv.sh
wget http://Entrarpainel.16mb.com/ssh/checkcsp.log
chmod +x checksrv.sh
chmod +x checkcsp.log
chmod -R 777 checksrv.sh
chmod -R 777 checkcsp.log
update-rc.d checksrv.sh defaults

echo "[+] PROTEGENDO A CSP"
cd /opt/csp
wget http://Entrarpainel.16mb.com/ssh/protecao.zip
unzip protecao.zip
chmod 777 -R cd /opt/
rm -rf protecao.zip

echo "[+] INICIANDO A CSP AUTOMATICAMENTE"
sed --in-place '/exit 0/d' /etc/rc.local
echo "sleep 10" >> /etc/rc.local
echo "/opt/csp/cardproxy.sh start &" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
cd /opt/csp
/opt/csp/cardproxy.sh start
./cardproxy.sh start
apt-get -y update
apt-get -y upgrade

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "CSP INSTALADO"
echo "Entre http://ipservidor:8082 abra o navegador o coloque o dominio informado"
echo "Seu Usuario/Senha |-> Usuario: admin | Senha: secret"
echo "[+] INICIANDO A PAINEL  AUTOMATICAMENTE"
cd /tmp/
chmod 777 painel.sh
./painel.sh
exit 0
fi

