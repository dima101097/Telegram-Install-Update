#!/bin/bash
pass="XXXXX" #Linux root pass
cd ~/Script/Telegram/

__sleep(){
	sleep 60
	__connectCheck
}

__dowloadInstall(){
	cat ./telegram_rel > install_t
	rm ./telegram_rel
	killall telegram
	cd /tmp
	clear
	wget https://telegram.org/dl/desktop/linux
	tar -xf linux
	rm linux
	cd Telegram
	mv Telegram telegram
	mv Updater telegram-updater
	echo "$pass"  | sudo -S  cp telegram /usr/local/bin/ 
	echo "$pass"  | sudo -S  cp telegram-updater /usr/local/bin/
	zenity --info --title="Telegram" --text "Telegram успешно обновлён" --width=200
}
__versionCheck(){
	GET https://github.com/telegramdesktop/tdesktop/releases > ./telegram_html 
	grep  -a -m 1 -h -r '<a href="/telegramdesktop/tdesktop/tree/' ./telegram_html > telegram_rel
	rm ./telegram_html

	if diff -b -B -Z ./install_t ./telegram_rel
		then {
			rm ./telegram_rel
			exit 
		}
	else 
		{
			__dowloadInstall
		}
	fi
}
__connectCheck(){
	curl -D- -o /dev/null -s http://www.google.com
	if [[ $? == 0 ]]; then
		__versionCheck 
	else 
		__sleep
	fi
}
__connectCheck
