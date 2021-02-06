#!/bin/bash
# Получаем версии WP с наших файлов сайтов wp-includes/version.php
WPsite=`grep -E 'wp_version =' */wp-includes/version.php | tr \/ ' ' | tr = ' ' | awk '{ print $1, $NF}' | tr \'\; ' '`

# Получаем latest версию WP с сайта wordpress.org (кнопка download)
WPsource=`curl -s https://wordpress.org/ | grep -E 'download WordPress' | awk '{ print $2 }'`
WPsource1=$WPsource

# Sent message to Telegram
CountOfWPSites=`echo "$WPsite" | grep -v "$WPsource1" | wc -l`
while [ $CountOfWPSites -ne 0 ]
do
    WPsite1=`echo "$WPsite" | grep -v "$WPsource1" | nl | awk -v count="$CountOfWPSites" '{if ($1 == count) {print $2,$3}}'`
    WPsite2="$WPsite1"
    export WPsite2
    #echo $WPsite2
    curl --header 'Content-Type: application/json' --request 'POST' --data '{"chat_id":"-393190776","text":"WebserverOLD: Безопасность под угрозой, обновите WP для '`echo $WPsite2 | tr " " \==`'"}' "https://api.telegram.org/botID......./sendMessage"
    CountOfWPSites=$(( $CountOfWPSites - 1 ))
done
