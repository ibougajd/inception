#!/bin/bash

# Configure vsftpd
# Create empty config directory to prevent error
mkdir -p /var/run/vsftpd/empty

# Create FTP user
# If user doesn't exist, create it
if ! id "$FTP_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    # Add to www-data group to access website files if needed, mostly we just read/write own files but we might want to write to /var/www/html
fi

# Create vsftpd.conf
cat << EOF > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=21100
pasv_max_port=21110
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
allow_writeable_chroot=YES
EOF

# Add user to userlist
echo "$FTP_USER" > /etc/vsftpd.userlist

# Start vsftpd
echo "Starting VSFTPD..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf
