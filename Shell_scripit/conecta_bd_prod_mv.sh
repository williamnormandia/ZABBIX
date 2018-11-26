#!/bin/bash
# Variáveisi
#set -xv
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
NOROWS="no rows selected"

 
#####################################################VARIAVEIS COM RESULT DE QUERYS#####################################################

#RETORNA O NUMERO DO ULTIMO ATENDIMENTO NO DATA GUARD JA TRATADO
CHECK_ATENDIMENTO=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/check_atend.sql | sed 's/[a-zA-Z]//g' | sed 's/-//g' | sed 's/_//g' | sed 's/(//g' | sed 's/)//g'`

#RETORNA USUÁRIOS LOGADOS NO ULTIMO MINUTO
CHECK_USER_LOG=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/check_log.sql | sed 's/-//g'| sed 's/no rows selected//g' | sed 's/AUD_USERNAMEAUD_OSUSER//g'`
########################################################################################################################################
##############################################################################################################################################################################################CONTA CONEXÕES POR SERVIDOR#######################################################
VAR_COUNT_BLCT=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_blct.sql | sed s/-//g | sed -n '4p' | awk '{print $2}'`


VAR_COUNT_BL03=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_bl03.sql | sed s/-//g | sed -n '4p' | awk '{print $2}'`


VAR_COUNT_ERP03=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp03.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP04=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp04.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP05=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp05.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP06=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp06.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP07=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp07.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP08=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp08.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP09=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp09.sql | sed -n '4p' | awk '{print $2}'`

VAR_COUNT_ERP10=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/count_pfullerp10.sql | sed -n '4p' | awk '{print $2}'`

echo $VAR_COUNT_ERP04

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullblct -o "$VAR_COUNT_BLCT" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullbl03 -o "$VAR_COUNT_BL03" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp03 -o "$VAR_COUNT_ERP03" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp04 -o "$VAR_COUNT_ERP04" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp05 -o "$VAR_COUNT_ERP05" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp06 -o "$VAR_COUNT_ERP06" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp07 -o "$VAR_COUNT_ERP07" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp08 -o "$VAR_COUNT_ERP08" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp09 -o "$VAR_COUNT_ERP09" > /dev/null

zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k conect_dcsp-pfullerp10 -o "$VAR_COUNT_ERP10" > /dev/null

########################################################################################################################################


#######################################################BANCO DE DADOS ORACLE STATUS####################################################
VAR_INVALID_OBJECTS=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/invalid_objects.sql | sed -n '4p' | cut -c 10-10`

VAR_LOCK_5M=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/locks_5min.sql| sed -n '4p' | cut -c 16-16`

VAR_AUDIT_PGA=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/audit_pga.sql | awk '{print $2}' | sed -n '4p'`

VAR_STATISTICS=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/statistics.sql | awk '{print $2}' | sed -n '4p'`

VAR_STANDBY_CHECK=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/standby_check.sql | awk '{print $2}' | sed -n '4p'`

VAR_LOCK_OF_PARTITION=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/lock_of_partition.sql| awk '{print $2}' | sed -n '4p'`

VAR_SECURITY_DBA=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/Security_DBA.sql| awk '{print $2}' | sed -n '4p'`

VAR_SECURITY_ANY=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/Security_any.sql| awk '{print $2}' | sed -n '4p'`

VAR_SECURITY_RISK_TABLES=`sqlplus64 -s $USER_BANCO/$PASS_BANCO@//$HOST_BANCO:$PORTA_BANCO/$SID @/etc/zabbix/Oraclesql/Security_any.sql| awk '{print $2}' | sed -n '4p'`


zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k invalid_objects -o "$VAR_INVALID_OBJECTS" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k locks_5min -o "$VAR_LOCK_5M" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k audit_pga -o "$VAR_AUDIT_PGA" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k Statistics -o "$VAR_STATISTICS" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k standby_check -o "$VAR_STANDBY_CHECK" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k lock_of_partition -o "$VAR_LOCK_OF_PARTITION" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k security_DBA -o "$VAR_SECURITY_DBA" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k security_any -o "$VAR_SECURITY_ANY" > /dev/null
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k ecurity_risk_tables.sql -o "$VAR_SECURITY_RISK_TABLES" > /dev/null




#ENVIAR ITENS COLETADOS PARA O ZABBIX
zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k $ITEMKEY_CHECKATEND -o $CHECK_ATENDIMENTO > /dev/null

#TRATA CHECK_USER-LOG
sq=`echo $CHECK_USER_LOG|wc -c`

if [ $sq -gt 1 ] 

then
	zabbix_sender -z $IP -s "$HOSTNAMEDATAZ" -k $ITEMKEY_LOGINBANCOPRDMV -o "$CHECK_USER_LOG"
#        echo "$CHECK_USER_LOG"
else 
echo " "
fi

#################################################ENVIA COUNT PARA O ZABBIX#############################################################



#echo "$VAR_COUNT_BLCT"
