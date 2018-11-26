#!/bin/bash
# Variáveis
IP="127.0.0.1"
HOSTNAMEDATAZ="Banco PRDMV"
#ITENS ZABBIX
ITEMKEY_CHECKATEND="atendimento"
ITEMKEY_LOGINBANCOPRDMV="loginbancoprdmv"
HOST_BANCO="10.1.235.11"
PORTA_BANCO="1521"
SID="PRDMV"
USER_BANCO="ACSCADMIN"
PASS_BANCO="ACSCADMIN"

#VARIAVEIS COM RESULT DE QUERYS

#RETORNA O NUMERO DO ULTIMO ATENDIMENTO NO DATA GUARD JA TRATADO
CHECK_ATENDIMENTO=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/check_atend.sql | sed 's/[a-zA-Z]//g' | sed 's/-//g' | sed 's/_//g' | sed 's/(//g' | sed 's/)//g'`

#RETORNA USUÁRIOS LOGADOS NO ULTIMO MINUTO
CHECK_USER_LOG=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/check_log.sql | sed 's/-//g'` 
#echo $CHECK_ATENDIMENTO

#echo $CHECK_USER_LOG

#CONTA LINHAS VINDAS DO BANCO
X=$(echo $CHECK_USER_LOG | wc -l)

if [ $X -eq 1 ]
then
   echo "sem logins"
#echo $X
else
   echo "com logins"
fi



#ENVIAR ITENS COLETADOS PARA O ZABBIX
#zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k $ITEMKEY_CHECKATEND -o $CHECK_ATENDIMENTO

#zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k $ITEMKEY_LOGINBANCOPRDMV -o "$CHECK_USER_LOG"
