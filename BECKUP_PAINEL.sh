#!/bin/bash
# 
# Autor: Aristides Neto
# Email: falecom@brasilplus
#
# Data: 09/06/2019
#
# Realiza o backup de bancos de dados MySQL
#

# Define usuario e senha do banco
USER='root'
PASS='senha aqui'

# Datas
DIA=`date +%d`
MES=`date +%m`
ANO=`date +%Y`
DATA_ATUAL=`date +%Y-%m-%d-%H-%M`

# Data de Inicio do Backup
DATA_INICIO=`date +%d/%m/%Y-%H:%M:%S`

# Caminho do arquivo de log
LOG_DIR=/var/log/backup
LOG=$LOG_DIR/backup_db_$ANO$MES$DIA.log

# Diretorio onde ser?o salvos os backups
DIR_BK=/opt/backups/

# Lista dos bancos de dados que ser?o realizados o backup
DATABASES=(painel_acessos painel_geral painel_user)

# Verifica se existe o diretorio para armazenar os logs
if [ ! -d $LOG_DIR ]; then
    mkdir $LOG_DIR
fi

# Verifica se existe o diretorio para o backup
if [ ! -d $DIR_BK ]; then
    mkdir -p $DIR_BK
fi

# Inicio do backup
echo "MYSQLDUMP Iniciado em $DATA_INICIO" >> $LOG

# Loop para backupear todos os bancos
for db in "${DATABASES[@]}"; do
    # Mysql DUMP
    # Para backupear procedures e functions foi adicionado o --routines
    mysqldump --routines -u$USER -p$PASS $db > $DIR_BK/$db'_'$DATA_ATUAL.sql

    echo "Realizando backup do banco ...............[ $db ]" >> $LOG

    # Compacta o arquivo sql em BZ2
    bzip2 $DIR_BK/$db'_'$DATA_ATUAL.sql
done

DATA_FINAL=`date +%d/%m/%Y-%H:%M:%S`
echo "MYSQLDUMP Finalizado em $DATA_FINAL" >> $LOG

# Remove arquivos de backups antigos - 5 dias
find $DIR_BK -type f -mtime +5 -exec rm -rf {} \;