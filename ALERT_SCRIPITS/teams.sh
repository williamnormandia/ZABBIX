#!/bin/bash

# Teams incoming web-hook URL and user name
url='https://outlook.office.com/webhook/f9746d60-799e-4d05-b879-68935b9056ef@35a68775-d144-447e-bb1e-d1915d4fa5e8/IncomingWebhook/d41c88c62ece4aab8b538a60828e9fe2/d4b00d12-0997-4306-bd8f-1d13f43d6e24'                # https://dev.outlook.com/Connectors/GetStarted#posting-more-complex-cards
curlheader='-H "Content-Type: application/json"'
agent='-A "zabbix-teams-alertscript / https://github.com/ericoc/zabbix-slack-alertscript"'
curlmaxtime='-m 60'
# username='Zabbix' # dont need this anymore

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

# Get the Slack channel or user ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY)
# to="$1" #dont need this
subject="$2"

# Change message themeColor depending on the subject - green (RECOVERY), red (PROBLEM), or grey (for everything else)
recoversub='^RECOVER(Y|ED)?$'
if [[ "$subject" =~ ${recoversub} ]]; then
        THEMECOLOR='43EA00'
elif [ "$subject" == 'PROBLEM' ]; then
        THEMECOLOR='EA4300'
else
        THEMECOLOR='555555'
fi

# The message that we want to send to Slack is the "subject" value ($2 / $subject - that we got earlier)
#  followed by the message that Zabbix actually sent us ($3)
message="${subject}: $3"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL

payload=\""{\\\"title\\\": \\\"${subject} \\\", \\\"text\\\": \\\"${message} \\\", \\\"themeColor\\\": \\\"${THEMECOLOR}\\\"}"\"

curldata=$(echo -d "$payload")

eval curl $curlmaxtime $curlheader $curldata $url $agent
