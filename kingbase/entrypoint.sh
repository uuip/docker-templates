#!/bin/bash
set -euo pipefail

source /etc/profile
cp /license.dat /opt/Kingbase/ES/V8/KESRealPro/V008R006C008B0014/
KINGBASE_HOME="/opt/Kingbase/ES/V8/Server"
KINGBASE_DATA="${KINGBASE_DATA:-/opt/Kingbase/ES/V8/data}"
KINGBASE_LOG="${KINGBASE_DATA}/sys_log/startup.log"
DB_USER="${DB_USER:-system}"
PASSWORD="${PASSWORD:-12345678ab}"
DB_MODE="${DB_MODE:-pg}"
ENABLE_CI="${ENABLE_CI:-no}"

init_db() {
    echo "[$(date)] Initializing database..."
    mkdir -p "${KINGBASE_DATA}"
    chown kingbase:kingbase "${KINGBASE_DATA}"

    local init_args="-D ${KINGBASE_DATA} -U ${DB_USER} -x ${PASSWORD} -m ${DB_MODE}"
    if [ "${ENABLE_CI}" = "yes" ]; then
        init_args="${init_args} --enable-ci"
    fi

    su kingbase -c "${KINGBASE_HOME}/bin/initdb ${init_args}"

    su kingbase -c "sed -i 's/^#\(\s*archive_mode\s*=\s*\)off/\1on/' ${KINGBASE_DATA}/kingbase.conf"
    su kingbase -c "sed -i \"s|^#\(\s*archive_command\s*=\s*\)''|\1'/bin/true'|\" ${KINGBASE_DATA}/kingbase.conf"

    echo "[$(date)] Database initialized."
}

start_db() {
    echo "[$(date)] Starting database..."
    mkdir -p "$(dirname "${KINGBASE_LOG}")"
    chown kingbase:kingbase "$(dirname "${KINGBASE_LOG}")"
    su kingbase -c "${KINGBASE_HOME}/bin/sys_ctl start -w -D ${KINGBASE_DATA} -l ${KINGBASE_LOG}"
    echo "[$(date)] Database started."
}

stop_db() {
    echo "[$(date)] Stopping database..."
    su kingbase -c "${KINGBASE_HOME}/bin/sys_ctl stop -D ${KINGBASE_DATA} -m fast" || true
    echo "[$(date)] Database stopped."
}

trap stop_db SIGTERM SIGINT SIGQUIT

if [ ! -f "${KINGBASE_DATA}/SYS_VERSION" ]; then
    init_db
fi

start_db

tail -f /dev/null &
wait $!
