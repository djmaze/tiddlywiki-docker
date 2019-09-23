#!/bin/sh
set -e

tiddlywiki_script=$(readlink -f $(which tiddlywiki))

if [ -n "$NODE_MEM" ]; then
    # Based on rule of thumb from:
    # http://fiznool.com/blog/2016/10/01/running-a-node-dot-js-app-in-a-low-memory-environment/
    mem_node_old_space=$((($NODE_MEM*4)/5))
    NODEJS_V8_ARGS="--max_old_space_size=$mem_node_old_space $NODEJS_V8_ARGS"
fi

if [ ! -d /var/lib/tiddlywiki/mywiki ]; then
  /usr/bin/env node $NODEJS_V8_ARGS $tiddlywiki_script mywiki --init server

  mkdir /var/lib/tiddlywiki/mywiki/tiddlers
fi


# Configure the tiddlywiki to be served on a path if it is given
WEBHOST_TID=/var/lib/tiddlywiki/mywiki/tiddlers/\$__config_tiddlyweb_host.tid
if [ -n "${SERVE_URI}" ]; then
  cp /tiddlyweb_host_template ${WEBHOST_TID}
  echo '$protocol$//$host$'${SERVE_URI}"/" >> ${WEBHOST_TID}
  echo "tiddlywiki will be served at ${SERVE_URI}"
else
  if [ -e ${WEBHOST_TID} ]; then
    rm ${WEBHOST_TID}
  fi
fi

# Start the tiddlywiki server

exec /usr/bin/env node $NODEJS_V8_ARGS $tiddlywiki_script mywiki --server 8080 $:/core/save/all text/plain text/html "${USERNAME:-user}" "${PASSWORD-wiki}" 0.0.0.0 ${SERVE_URI}

