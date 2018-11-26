#! /bin/bash
#Autor: Adail Horst (the.spaww@gmail.com)
#Site: http://www.spinola.net.br 
### Script de integracao com o Telegram ### 
#set -x
ENTER="
";
USERID="$1";

ARQUIVO="/usr/local/share/zabbix/alertscripts/botinfo.txt";
if [ -f "$ARQUIVO" ]; then
  KEY=$(cat $ARQUIVO);
else
  KEY="CHAVE_DO_MEU_BOT";
fi

TIMEOUT="5";
TEXT=$(echo -e "*$2* $ENTER$3" |  sed 's/PROBLEM/INCIDENTE/g');

URL="https://api.telegram.org/bot$KEY/sendMessage"

echo "DATA - TIPO - USERID - TIMEOUT - URL" >> /tmp/telegram-notify.log
echo "$(date +%s) - REQUEST - $USERID $TIMEOUT $URL " >> /tmp/telegram-notify.log
RESPONSE=`curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&parse_mode=markdown&text=$TEXT" $URL`;
echo "$(date +%s) - RESPONSE - $RESPONSE" >> /tmp/telegram-notify.log

chown zabbix: /tmp/telegram-notify.log
