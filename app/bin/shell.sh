#!/bin/sh

ARG0="$0"
while [ -h "$ARG0" ]; do
  ls=$(ls -ld "$ARG0")
  link=$(expr "$ls" : '.*-> \(.*\)$')
  if expr "$link" : '/.*' >/dev/null; then
    ARG0="$link"
  else
    ARG0=$(dirname "$ARG0")/"$link"
  fi
done
PRG_DIR=$(dirname "$ARG0")
BASE_DIR="$PRG_DIR/.."
BASE_DIR="$(
  cd "$BASE_DIR" || exit
  pwd
)"

set -a
. "$BASE_DIR/bin/run.options"
set +a

if [ -z "$JAVA_HOME" ]; then
  JAVA_BIN="$(command -v java 2>/dev/null || type java 2>&1)"
  while [ -h "$JAVA_BIN" ]; do
    ls=$(ls -ld "$JAVA_BIN")
    link=$(expr "$ls" : '.*-> \(.*\)$')
    if expr "$link" : '/.*' >/dev/null; then
      JAVA_BIN="$link"
    else
      JAVA_BIN="$(dirname "$JAVA_BIN")/$link"
    fi
  done
  [ -x "$JAVA_BIN" ] && JAVA_HOME="$(dirname "$JAVA_BIN")"
  [ ! -z "$JAVA_HOME"] && JAVA_HOME=$(
    cd "$JAVA_HOME/.." >/dev/null || exit
    pwd
  )
else
  JAVA_BIN="$JAVA_HOME/bin/java"
fi

if [ ! -z "$JVM_MS" ]; then
  JVM_MS_OPT="-Xms${JVM_MS}m"
fi
if [ ! -z "$JVM_MX" ]; then
  JVM_MX_OPT="-Xmx${JVM_MX}m"
fi
if [ ! -z "$JVM_SS" ]; then
  JVM_SS_OPT="-Xss${JVM_SS}k"
fi

CLASSPATH="$BASE_DIR/lib/*"
TMP_DIR="$BASE_DIR/temp"
ASPECTRAN_CONFIG="$BASE_DIR/config/aspectran-config.apon"

while [ ".$1" != . ]; do
  case "$1" in
  --debug)
    LOGGING_CONFIG="$BASE_DIR/config/logging/logback-debug.xml"
    shift
    continue
    ;;
  *)
    break
    ;;
  esac
done
if [ -z "$LOGGING_CONFIG" ] || [ ! -f "$LOGGING_CONFIG" ]; then
  LOGGING_CONFIG="$BASE_DIR/config/logging/logback.xml"
fi

"$JAVA_BIN" \
  $JVM_MS_OPT \
  $JVM_MX_OPT \
  $JVM_SS_OPT \
  -server \
  -classpath "$CLASSPATH" \
  -Djava.io.tmpdir="$TMP_DIR" \
  -Djava.awt.headless=true \
  -Djava.net.preferIPv4Stack=true \
  -Dlogback.configurationFile="$LOGGING_CONFIG" \
  -Daspectran.basePath="$BASE_DIR" \
  $ASPECTRAN_OPTS \
  com.aspectran.shell.jline.JLineAspectranShell \
  "$ASPECTRAN_CONFIG"
