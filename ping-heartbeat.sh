#!/bin/bash

COUNT=1
# step1: change this to target ip or FQDN
IPADDR="localhost"
# step2: change this to slack WebHook URL
URL='http://hogehoge...'
# step3: change this to slack channel name (option)
CHANNEL=${CHANNEL:-'#okutani-dev'}
# step4: change this to bot name (option)
BOTNAME=${BOTNAME:-'ping heartbeat'}
# step4: set emoji (option)
EMOJI=${EMOJI:-':sushi:'}
# step5: set head (option)
HEAD=${HEAD:-"[ping monitoring]\n"}
# step6: change message
MESSAGE='```PING reachable NOW!!!```'

while :
do
  ping ${IPADDR} -c ${COUNT}
  if [ $? -eq 0 ];then
    echo "success"
    # formatting json
    payload="payload={
        \"channel\": \"${CHANNEL}\",
        \"username\": \"${BOTNAME}\",
        \"icon_emoji\": \"${EMOJI}\",
        \"text\": \"${HEAD}${MESSAGE}\"
    }"

    # send
    curl -s -S -X POST --data-urlencode "${payload}" ${URL} > /dev/null
    break
  else
    echo "false"
  fi
done

exit 0
