#!/bin/bash

set -o errexit

readonly RSYSLOG_PID="/var/run/rsyslogd.pid"

main() {
  start_rsyslog_in_background
  start_haproxy
}

ensure_environment_variable_set() {
  test -z "$CONTAINERS_ADDRESS" \
    && {
      echo "Error:
    Environment variable 'CONTAINERS_ADDRESS' not set.
    Make sure you have initiated the container with the
    right set of environment variables.
    
Aborting.
    "
      exit 1
    }
}

template_haproxy_cfg() {
  cat /etc/haproxy/haproxy.tmpl.cfg \
    | envsubst \
      >/etc/haproxy/haproxy.cfg

  cat /etc/haproxy/haproxy.cfg | grep .
}

start_rsyslog_in_background() {
  rm -f $RSYSLOG_PID
  rsyslogd -n &
}

start_haproxy() {
  exec haproxy -f /etc/haproxy/haproxy.cfg
}

main "$@"
