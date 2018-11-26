# Variáveis
BACKUPDIR="/bkp"
DATA=`date +%d%m%Y_%H:%M:%S`
LOG="/var/log/backup.zabbix.mysql.log"
LOGERRO=".backup.err"
USER="root"
PASSWORD="root"
DATABASE="zabbix"
IP="10.1.235.19"
HOSTNAME="ZB-DBMV01"
ITEMKEY="backup.zabbix.mysql.status"
ITEMKEYERRO="backup.zabbix.mysql.status.erro"
SUCESSO="OK"
ERROPASSO1="erro.criacao.arquivo"
ERROPASSO2="erro.compactacao"
ERROPASSO3="erro.rotacao"
 
# Verificando existência do diretório
if [ -e $BACKUPDIR ]
   then
   echo "Diretorio ja existe"
else
   mkdir $BACKUPDIR
   echo "Diretorio criado com sucesso"
   echo "Diretorio criado com sucesso: $DATA" >> $LOG
   continue
fi
 
# PASSO 01 - Iniciando Backup Dump MySQL
echo "Iniciando Backup: $DATA" >> $LOG
mysqldump -u"$USER" --password="$PASSWORD" --single-transaction --routines $DATABASE > $BACKUPDIR/$DATABASE.$DATA.sql 2> $BACKUPDIR/$LOGERRO
 
if [ "$?" -eq 0 ]; then
   echo "Backup criado com sucesso"
   echo "Backup criado com sucesso: $DATA" >> $LOG
else
   zabbix_sender -z $IP -s "$HOSTNAME" -k $ITEMKEYERRO -o $ERROPASSO1
   echo "Erro encontrado na criacao do arquivo.sql PASSO 01"
   echo "Erro encontrado na criacao do arquivo.sql PASSO 01: $DATA" >> $LOG
   exit 0
fi
 
# PASSO 02 - Compacta Backup
echo "Compactando Backup: $DATA" >> $LOG
bzip2 $BACKUPDIR/$DATABASE.$DATA.sql 2> /dev/null
if [ "$?" -eq 0 ]; then
   echo "Backup compactado com sucesso"
   echo "Backup compactado com sucesso: $DATA" >> $LOG
else
   zabbix_sender -z $IP -s "$HOSTNAME" -k $ITEMKEYERRO -o $ERROPASSO2
   echo "Erro na compactacao do backup PASSO 02"
   echo "Erro na compactacao do backup PASSO 02: $DATA" >> $LOG
   exit 0
fi
 
# PASSO 03 - Remove Backups mais antigos 7 dias
echo "Removendo Backups Antigos: $DATA" >> $LOG
ls -td1 $BACKUPDIR/* | sed -e '1,7d' | xargs -d '\n' rm -rif
numero=`ls $BACKUPDIR | wc -w`
if [ $numero -eq 7 ]; then
    echo "Backup Local rotacionado com sucesso, Total 07"
    echo "Backup Local rotacionado com sucesso, Total 07: $DATA" >> $LOG
else
    zabbix_sender -z $IP -s "$HOSTNAME" -k $ITEMKEYERRO -o $ERROPASSO3
    echo "Erro na rotacao do backup PASSO 03"
    echo "Erro na rotacao do backup PASSO 03: $DATA" >> $LOG
    exit 0
fi
 
# PASSO 04 - Zabbix Sender Final - Apenas se o backup for realizado com sucesso
zabbix_sender -z $IP -s "$HOSTNAME" -k $ITEMKEY -o $SUCESSO
echo "Backup finalizado com sucesso:"
echo "Backup finalizado com sucesso: $DATA" >> $LOG
