#!/bin/bash

function get_rev() {
  wget -qO - "${1}${API}" | grep "\"rev\":\"" | perl -nle 'print $1 if( /"rev":"([0-9a-zA-Z\-]+)"/ )' 2>/dev/null
}

if [ $# -ne 2 ]; then
  cat <<__EOT__
usage:
  ./repl_check.sh URL1 URL2
__EOT__
  exit 1
fi

URL1="$1"
URL2="$2"
API="/_changes?limit=1&descending=true"

rev1=`get_rev $1`
rev2=`get_rev $2`

if [ ${rev1} != ${rev2} ]; then
  exit 1
fi
exit 0
