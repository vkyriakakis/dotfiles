#!/usr/bin/env bash

BLACKLIST="$HOME/.config/scripts/backup-exclude"
MEGA_HOME="SPICY"

if [[ $# -eq 0 || ( $1 != "copy" && $1 != "sync" ) ]]; then
    echo "Run with ./backup.sh [sync|copy]"
    exit 1
fi

# Backup my personal files to my mega account
find $HOME/* -prune -type d -printf "%f\n" | while read dir
do
	# Skip files in the backup blacklist
	if grep -Fxq $dir < $BLACKLIST; then
		continue
	fi 

	echo "$1 $dir"

	# Backup to MEGA by sync or copy depending on the options
	rclone $1 $HOME/$dir remote:$MEGA_HOME/$dir
done

# Deduplicate bc why not
rclone dedupe remote: