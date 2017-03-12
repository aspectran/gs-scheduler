@ECHO OFF
ECHO -----------------=======================
ECHO            ASPECTRAN CONSOLE
ECHO =======================-----------------
java -Dlog4j.configurationFile="file:/%CD%\log4j2.xml" -cp "lib/*" com.aspectran.console.AspectranConsole
