# Variáveis
IP="127.0.0.1"
HOSTNAMEDATAG="Data Guard"
ITEMKEY_CHECKATEND="atendimento"

#VARIAVEIS COM RESULT DE QUERYS

#RETORNA O NUMERO DO ULTIMO ATENDIMENTO NO DATA GUARD JA TRATADO
check_atendimento=`sqlplus64 -s acscadmin/acscadmin@//10.1.101.2:1521/PRDMVSTB @/etc/zabbix/Oraclesql/check_atend.sql | sed 's/[a-zA-Z]//g' | sed 's/-//g' | sed 's/_//g' | sed 's/(//g' | sed 's/)//g'` 

#ENVIAR ITENS COLETADOS PARA O ZABBIX
zabbix_sender -z $IP -s "$HOSTNAMEDATAG" -k $ITEMKEY_CHECKATEND -o $check_atendimento
