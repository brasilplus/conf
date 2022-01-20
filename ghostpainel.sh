#!/bin/bash
echo ""
clear
echo -e "\033[1;31m INSTALANDO PAINEL CSPADMIN + MARIADB GHOSTCS UBUNTU 16. \033[0m"
echo -e "\033[1;31m AGUARDE A INSTALAÇÃO É DEMORADA! \033[0m"
apt-get update -y > /dev/null
sleep 1s
apt-get install -y software-properties-common > /dev/null
sleep 1s
echo -e "\033[1;31m APERTE ENTER PARA COMEÇAR INSTALAR. \033[0m"
add-apt-repository ppa:nginx/stable > /dev/null
apt-get update > /dev/null
echo -e "\033[1;31m AGUARDE..... \033[0m"
apt-get install -y curl iputils-ping nginx unzip memcached php7.0-fpm php7.0-cli php7.0-gd php7.0-mcrypt php7.0-mysql php7.0-zip php7.0-mbstring php7.0-curl php7.0-pdo-mysql php7.0-sockets php7.0-fileinfo php7.0-exif php7.0-opcache php7.0-xml php7.0-intl php-memcache > /dev/null 2>&1
apt-get clean && rm -rf /var/lib/apt/lists/* >> /dev/null 2>&1
apt-get install -y tzdata && mkdir -p /var/run/php && usermod -u 1000 www-data && chown -R www-data:www-data /usr/share/nginx/html > /dev/null 2>&1
sleep 1s
echo America/Sao_Paulo > /etc/timezone && rm /etc/localtime && ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
sleep 1s
echo -e "\033[1;31m AGUARDE........ \033[0m"
cd /etc/php/7.0/fpm/conf.d 
sleep 1s
rm custom.ini > /dev/null 2>&1
sleep 1s
wget  http://www.infonetbr.com.br/cs/scriptcs-painel2020/conf/custom.zip > /dev/null 2>&1
unzip custom.zip > /dev/null 2>&1
rm custom.zip > /dev/null 2>&1
sleep 1s
cd /etc/php/7.0/fpm/pool.d
sleep 1s
rm custom.pool.conf > /dev/null 2>&1
echo -e "\033[1;31m AGUARDE............... \033[0m"
sleep 1s
wget http://www.infonetbr.com.br/cs/scriptcs-painel2020/conf/custom.pool.zip > /dev/null 2>&1
unzip custom.pool.zip > /dev/null 2>&1
rm custom.pool.zip > /dev/null 2>&1
sleep 1s
cd /etc/nginx
sleep 1s
rm nginx.conf > /dev/null 2>&1
echo -e "\033[1;31m AGUARDE.................... \033[0m"
sleep 1s
wget http://www.infonetbr.com.br/cs/scriptcs-painel2020/conf/nginx.zip > /dev/null 2>&1
unzip nginx.zip > /dev/null 2>&1
rm nginx.zip > /dev/null 2>&1
sleep 1s
cd /usr/share/nginx/html
rm -f /usr/share/nginx/html/index.html > /dev/null 2>&1
sleep 1s
wget http://www.infonetbr.com.br/cs/scriptcs-painel2020/wget/painel2.7.zip > /dev/null 2>&1
sleep 1s
unzip painel2.7.zip > /dev/null 2>&1
rm painel2.7.zip > /dev/null 2>&1
sleep 1s
chown -R www-data /usr/share/nginx/html/ > /dev/null 2>&1
cd /root
printf '%s\n' '#!/bin/bash' 'exit 0' | sudo tee -a /etc/rc.local
sed --in-place '/exit 0/d' /etc/rc.local
echo "sleep 1" >> /etc/rc.local
echo "/etc/init.d/php7.0-fpm stop" >> /etc/rc.local
echo "sleep 5" >> /etc/rc.local
echo "/usr/sbin/php-fpm7.0 & nginx" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
systemctl enable rc-local > /dev/null 2>&1
cd /etc/systemd/system
echo -e "\033[1;31m Caso o arquivo rc.local.service já existir ele perguntara se quer substituir coloque a letra n e aperte enter. \033[0m"
wget http://www.infonetbr.com.br/cs/scriptcs-painel2020/conf/rc-local.zip > /dev/null 2>&1
unzip rc-local.zip 
rm rc-local.zip > /dev/null 2>&1
chmod +x /etc/systemd/system/rc-local.service > /dev/null 2>&1
chmod +x /etc/rc.local > /dev/null 2>&1
systemctl enable rc-local > /dev/null 2>&1
cd /root
sleep 1s
echo -e "\033[1;31m AGUARDE............................ \033[0m"
apt -y install software-properties-common dirmngr > /dev/null 2>&1
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 > /dev/null 2>&1
sleep 1s
add-apt-repository 'deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/10.3/ubuntu xenial main' > /dev/null 2>&1
apt update > /dev/null 2>&1
sleep 1s
apt -y install mariadb-server mariadb-client 
sleep 1s
echo -e "\033[1;31m Digite sua senha do mysql. \033[0m" ; read -s senha
mysql -u root -p$senha  mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$senha' WITH GRANT OPTION; FLUSH PRIVILEGES;" > /dev/null 2>&1
mysql -u root -p$senha -e "DROP DATABASE IF EXISTS painel_acessos; CREATE DATABASE IF NOT EXISTS painel_acessos;" > /dev/null 2>&1
mysql -u root -p$senha -e "DROP DATABASE IF EXISTS painel_geral; CREATE DATABASE IF NOT EXISTS painel_geral;" > /dev/null 2>&1
mysql -u root -p$senha -e "DROP DATABASE IF EXISTS painel_user; CREATE DATABASE IF NOT EXISTS painel_user;" > /dev/null 2>&1
mysql -u root -p$senha painel_acessos < /usr/share/nginx/html/db/painel_acessos.sql > /dev/null 2>&1
mysql -u root -p$senha painel_geral < /usr/share/nginx/html/db/painel_geral.sql > /dev/null 2>&1
mysql -u root -p$senha painel_user < /usr/share/nginx/html/db/painel_user.sql > /dev/null 2>&1
sed -i "/senha/ s/123456/$senha/" /usr/share/nginx/html/DadosServidor.php > /dev/null 2>&1
sleep 1s
sed -i "/bind-address/ s/127.0.0.1/0.0.0.0/" /etc/mysql/my.cnf > /dev/null 2>&1
sleep 1s
/etc/init.d/mysql restart > /dev/null 2>&1
echo -e "\033[1;31m Instalação do Painel e MYSQL Concluido. \033[0m"
echo -e "\033[1;31m Usuario: Administrador \033[0m"
echo -e "\033[1;31m Senha: administrador \033[0m"
echo -e "\033[1;31m A maquina foi reiniciada quando voltar já estara tudo online! \033[0m"
rm installpainel > /dev/null 2>&1
reboot

