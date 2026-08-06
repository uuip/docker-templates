#!/bin/zsh

export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=$JAVA_HOME/bin:$PATH

export APP_DAEMON=false
export TZ=Asia/Shanghai

PROJECT_DIR="/Users/sharp/Desktop/project/debot/debot"

cd $PROJECT_DIR/target/aiLink-debot-console
cp $PROJECT_DIR/application-prod.yml conf/

# Detect this machine's external (LAN) IP and rewrite the host in
# debotUIUrl / debotUIInnerUrl so browser-facing URLs point back here.
EXTERNAL_IP=""
for interface in en10 en0; do
    ip=$(ipconfig getifaddr "$interface" 2>/dev/null)
    if [ -n "$ip" ]; then
        EXTERNAL_IP="$ip"
        break
    fi
done
if [ -n "$EXTERNAL_IP" ]; then
    perl -i -pe 's{^(\s*debotUI(?:Inner)?Url:) http://[^:/]+:}{$1 http://'"$EXTERNAL_IP"':}' conf/application-prod.yml
    echo "debotUIUrl / debotUIInnerUrl host -> $EXTERNAL_IP"
else
    echo "WARNING: could not detect external IP; debotUIUrl / debotUIInnerUrl left unchanged"
fi

# Patch run_app.sh: GNU find's -printf is unsupported by macOS BSD find, yielding
# an empty classpath and ClassNotFoundException. Rewrite to portable -exec basename.
# Idempotent — reruns are no-ops. chr(92) avoids backslash-escape hell in the script.
perl -i -pe 'BEGIN{$m=chr(92) x 2; $r=chr(92)} s/-printf "%f${m}n"/-exec basename {} ${r};/g' bin/run_app.sh

./bin/startup.sh
