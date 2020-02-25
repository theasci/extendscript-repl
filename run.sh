#/bin/bash

trap '' SIGINT
trap '' SIGQUIT
trap '' SIGTSTP # display message and pause

DIRECTORY=$(cd `dirname $0` && pwd)

if [ "$1" != '' ] && ( [ "$1" = '-h' ] || [ "$1" = '--help' ] || [ "$1" = 'help' ] ); then
	echo "USAGE: $0 [-h|help]"
	echo "Type ExtendScript and hit Enter to execute."
	echo "To quit, type quit or exit or stop."
	exit 0;
fi

APP=$(echo "${1:-indesign}" | awk '{print tolower($0)}')

while true;
do
	read -p "> " EXTENDSCRIPT

	if [ "$EXTENDSCRIPT" == "quit" ] || [ "$EXTENDSCRIPT" == "exit" ] || [ "$EXTENDSCRIPT" == "stop" ]; then
		break;
	fi
	# echo $EXTENDSCRIPT

	osascript -l "JavaScript" -e "var app = new Application('com.adobe.${APP}'); app.doScript('$EXTENDSCRIPT', {language: 'javascript'});"
done
