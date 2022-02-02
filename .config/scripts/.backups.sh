#!/bin/bash

# First run
if [ ! -f "$HOME/.exclude-backup.txt" ]; then
    cat << EOF > "$HOME/.exclude-backup.txt"
.cache/
.Backups/
Calculations/
Downloads/
.mozilla/
Mail/
Calculations/
.dbus/
.ssh/id*
.offlineimap/*.lock
.cfg
.xsession-*
.zcompdump-*
.zsh_history
.Xauthority
.lesshst
.local
*.h5
EOF
    echo "Created $HOME/.exclude-backup.txt"
fi

#also exclude all files in that are in my dotfiles github repo
cat "$HOME/.exclude-backup.txt" > /tmp/exclude-backup.txt
git --git-dir="$HOME/.cfg/" --work-tree="$HOME" ls-files --full-name ~ >> /tmp/exclude-backup.txt
sed -i -e "s/^/$USER\//" /tmp/exclude-backup.txt

xbps-query -m > "$HOME/.manually_installed_packages-$(hostname)"
ls /var/service > "$HOME/.services_activated-$(hostname)"

#local backup
echo "Local Backup..."
if "$HOME/.config/scripts/.localbackup.sh" > "$HOME/.lastbackup"; then
    tail -n16 "$(find /tmp -name backup-\* -exec head -n1 {} \;)"
fi

if grep -q 'quota' "$HOME/.lastbackup"; then
    date +"%d %b @ %R (!)" >> "$HOME/.lastbackup"
else
    date +"%d %b @ %R" >> "$HOME/.lastbackup"
fi

read -rp "Finished. Press any key to close."
exit 0
