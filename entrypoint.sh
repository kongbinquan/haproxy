#!/bin/bash
set -e
[[ $DEBUG == true ]] && set -x

if [ -n "$TIMEZONE" ]; then
	rm -rf /etc/localtime && \
	ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime
fi

[[ -n "${SUPERVISORD_PORT}" ]] && sed -i "s/^port.*/port = 0.0.0.0:$SUPERVISORD_PORT/" /etc/supervisord.conf

#[ "${1:0:1}" = '-' ] && set -- nginx "$@"
[ ! -d /var/log/supervisor ] && mkdir -p /var/log/supervisor
supervisord -n -c /etc/supervisord.conf
