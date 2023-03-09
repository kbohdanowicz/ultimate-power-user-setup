#!/bin/sh

if [ "$#" -ne 1 ]
then
  echo "[Error]: Script name is required"
  exit 1
fi

SCRIPT_NAME="$1.sh"

touch $SCRIPT_NAME
chmod 700 $SCRIPT_NAME
