#!/bin/bash

# Slack incoming web-hook URL and user name
url='https://hooks.slack.com/services/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'
# example: https://hooks.slack.com/services/QW3R7Y/D34DC0D3/BCADFGabcDEF123
username='Zabbix'

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY/OK)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")
# url = $4 (optional url to replace the hardcoded one. useful when multiple groups have seperate slack environments)
# proxy = $5 (optional proxy, including port)

# Get the Slack channel or user ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY/OK)
to="$1"
subject="$2"

# Change message emoji depending on the subject - smile (RECOVERY/OK), frowning (PROBLEM), or ghost (for everything else)
recoversub='^RECOVER(Y|ED)?$'
if [[ "$subject" =~ ${recoversub} ]]; then
	emoji=':smile'
elif [ "$subject" == 'OK' ]; then
	emoji=':smile'
elif [ "$subject" == 'PROBLEM' ]; then
	emoji=':frowning'
else
	emoji=':ghost'
fi

# The message that we want to send to Slack is the "subject" value ($2 / $subject - that we got earlier)
#  followed by the message that Zabbix actually sent us ($3)
message="${subject}: $3"

# in case a 4th parameter is set, we will use it for the url
url=${4-$url}
# in case a 5th parameter is set, we will us it for the proxy settings
proxy=${5-""}
if [[ "$proxy" != "" ]] ; then
  proxy=" -x $proxy "
fi

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"channel\": \"${to//\"/\\\"}\", \"username\": \"${username//\"/\\\"}\", \"text\": \"${message//\"/\\\"}\", \"icon_emoji\": \"${emoji}\"}"
curl $proxy -m 5 --data-urlencode "${payload}" $url -A 'zabbix-slack-alertscript / https://github.com/ericoc/zabbix-slack-alertscript'
