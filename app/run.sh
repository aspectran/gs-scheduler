#!/bin/sh
echo "-----------------======================="
echo "          ASPECTRAN CONSOLE             "
echo "=======================-----------------"
java -Dlog4j.configurationFile="file://$PWD/log4j2.xml" -cp "lib/*" com.aspectran.console.AspectranConsole
