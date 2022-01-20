CREATE USER 'barc1010'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON * . * TO 'barc1010'@'localhost';

sudo su
nano /etc/hosts    (coloque o nome da maquina)
apt-get update -y
apt-get install apache2 -y
apt install mysql-server -y
apt-get install php libapache2-mod-php php-curl
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl php libapache2-mod-php 
apt-get install phpmyadmin php-gettext
cd /etc/apache2
rm ./apache2.conf
wget http://install.brplus.top/arquivos/apache2.conf
systemctl apache2 restart
mkdir /var/www/html/painel
chmod 777 /var/www/html/painel
cd /var/www/html/painel
wget http://install.brplus.top/arquivos/painel.tgz
tar xf painel.tgz
nano DadosServidor.php



Acesse a linha de comando e entre no servidor MySQL:

mysql
O Script vai retornar este resultado, que verifica que você está acessando um servidor MySQL.

1- mysql>

Então execute o seguinte comando:

2- CREATE USER 'bsilva'@'localhost' IDENTIFIED BY '2020';

novo_usuário é o nome que damos para a nossa nova conta de usuário e a seção IDENTIFIED BY ‘senha’ define um código de acesso para esse usuário. Você pode substituir esses valores com os seus próprios, desde que só altere o que está dentro das aspas.
Para garantir todos os privilégios do banco de dados para um usuário recém-criado, execute o seguinte comando:

3- GRANT ALL PRIVILEGES ON * . * TO 'bsilva'@'localhost';

Para que as mudanças tenham efeito, execute imediatamente um flush dos privilégios ao executar o seguinte comando:

4- FLUSH PRIVILEGES;

Assim que isso estiver feito, a sua nova conta de usuário vai ter o mesmo acesso ao banco de dados do que a conta antiga.



https://www.hostinger.com.br/tutoriais/como-criar-usuario-mysql-e-conceder-privilegios
