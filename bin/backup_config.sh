#!/bin/bash

HADIRECTORY=/home/homeassistant/.homeassistant
DATETIMESTAMP=$(date '+%Y%m%d%H%M%S')
BACKUPDIRECTORY="/home/graeme/Home Assistant/Automatic Backups"
FILENAME=home-assistant-config
TAREXCLUDEFILE="$HADIRECTORY/etc/backup_exclude.conf"
TAROPTIONS="--warning=no-file-changed --exclude-from=$TAREXCLUDEFILE -czf"
NOTOKEEP=10
TAR=/bin/tar

if [ -d "$HADIRECTORY" ]; then
  cd "$HADIRECTORY"
else
  echo "Home Assistant Directory does not exist"
  exit 1
fi

if [ ! -d "$BACKUPDIRECTORY" ]; then
  mkdir -p "$BACKUPDIRECTORY"
fi
$TAR $TAROPTIONS "${BACKUPDIRECTORY}/${FILENAME}-${DATETIMESTAMP}.tgz" .

ls -1tr "$BACKUPDIRECTORY" | head -n -10 | xargs -d '\n' rm -f --

exit 0
