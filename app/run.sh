#!/bin/sh
echo
echo "╔═╗╔═╗╔═╗╔═╗╔═╗╔╦╗╦═╗╔═╗╔╗╔  ╔═╗╔═╗╔╗╔╔═╗╔═╗╦  ╔═╗"
echo "╠═╣╚═╗╠═╝║╣ ║   ║ ╠╦╝╠═╣║║║  ║  ║ ║║║║╚═╗║ ║║  ║╣ "
echo "╩ ╩╚═╝╩  ╚═╝╚═╝ ╩ ╩╚═╩ ╩╝╚╝  ╚═╝╚═╝╝╚╝╚═╝╚═╝╩═╝╚═╝"
echo
java -Dlog4j.configurationFile="file://$PWD/log4j2.xml" -cp "lib/*" com.aspectran.console.Application
