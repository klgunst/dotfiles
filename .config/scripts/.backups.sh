#!/bin/bash

# First run
if [ ! -f $HOME/.exclude-backup.txt ]; then
    touch $HOME/.exclude-backup.txt
    cat << EOF > $HOME/.exclude-backup.txt
.cache/
.Backups/
Calculations/
.mozilla/
Mail/
Calculations/
.local/share/gvfs-metadata/
.dbus/
.ssh/id*
.offlineimap/*.lock
.cfg
EOF
    echo "Created $HOME/.exclude-backup.txt"
fi

#also exclude all files in that are in my dotfiles github repo
cat $HOME/.exclude-backup.txt > /tmp/exclude-backup.txt
git --git-dir=$HOME/.cfg/ --work-tree=$HOME ls-files --full-name ~ >> /tmp/exclude-backup.txt
sed -i -e "s/^/$USER\//" /tmp/exclude-backup.txt

xbps-query -m > $HOME/.manually_installed_packages-$(hostname)
ls /var/service > $HOME/.services_activated-$(hostname)

#local backup
echo "Local Backup..."
$HOME/.config/scripts/.localbackup.sh > $HOME/.lastbackup
tail -n 16 $(ls -t /tmp/backup-* | head -n 1)

#backup on a server
echo "Remote Backup..."
$HOME/.config/scripts/.remotebackup.sh >> $HOME/.lastbackup
tail -n 16 $(ls -t /tmp/backup-* | head -n 1)



if grep -q 'quota' $HOME/.lastbackup; then
    date +"%d %b @ %R (!)" >> $HOME/.lastbackup
else
    date +"%d %b @ %R" >> $HOME/.lastbackup
fi

read -p "Finished. Press any key to close."
exit 0
