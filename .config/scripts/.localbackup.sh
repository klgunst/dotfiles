#!/bin/bash

# How many backups should I keep? Note that we don't store a unchanged file twice,
# so you can have a high number here without having to worry about diskspace
NUMBACKUPS=31

# Where should I put my backups? Login to the moldyn58 and run the quota command to
# see where you quota is allocated.
WHEREBACKUPS=$HOME/.Backups

# Put this cron in a cronjob to run it automatically. Use the command "crontab -e" for this
# To run daily at 17h00, add: 17 * * * * /path/to/script
# Change the path to you situation
# Or for daily execution
# add in "crontab -e

# In the file $HOME/.exclude-backup.txt you can add any files that should not be backuped. This
# file will be created first time you run this script.


# The rest is just the actual script.

# Treat unset variables as an error
set -o nounset

TEMPLOGNAME="backup-$(date +"%F_%T").log"

# The actual backup
rsync --stats -v -h -a -b --exclude-from=/tmp/exclude-backup.txt --backup-dir=../backup.0/ --link-dest=../backup.0/ $HOME ${WHEREBACKUPS}/backup.cur/ > "/tmp/${TEMPLOGNAME}"

retval=$?

if [[ $retval != 0 ]]; then
    echo "Something went wrong with the rsync."
    echo "Please take action as your backups are no longer working!"
    echo "Please check /tmp/backup.log to see what went wrong."
    exit 1
fi

cp /tmp/${TEMPLOGNAME} ${WHEREBACKUPS}/backup.cur/

# Rotate the backups

cd ${WHEREBACKUPS}
if [ ! -d backup.cur ]; then
    echo "No current backup found, exiting..."
    exit 1
fi

if [ -d backup.${NUMBACKUPS} ]; then
    mv backup.${NUMBACKUPS} backup.old
    # give write permission needed to delete the directory
    find backup.old -type d -not -perm -u+w -print0 | xargs -0 chmod u+w
    rm -rf backup.old
fi

for I in $(seq ${NUMBACKUPS} -1 0); do
    if [ -d "backup.$I" ]; then
	let k=I+1
	mv "backup.$I" "backup.$k"
    fi
done

gzip backup.cur/${TEMPLOGNAME}

mv backup.cur backup.0

tail -n 100 latest-backup.txt > .tmp
echo $(date) >> .tmp
mv .tmp latest-backup.txt
