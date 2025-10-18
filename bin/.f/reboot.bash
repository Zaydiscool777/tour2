PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/gnu/store
LOG=/var/log/auto-update.log
echo "reboot.bash"
date
echo "apt-get ~"
apt-get update && 
apt full-upgrade -y && 
apt-get dist-upgrade && 
apt-get autoremove --purge && 
apt-get autoclean && 
# apt-get distclean >> $LOG 2>&1
echo "snap ~"
snap refresh >> $LOG 2>&1
echo "guix ~"
guix pull && 
guix upgrade && 
guix gc >> $LOG 2>&1
curl "wttr.in?m"
echo "finished"
