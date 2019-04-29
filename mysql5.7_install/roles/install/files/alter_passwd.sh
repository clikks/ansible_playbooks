#!/bin/bash

# Modify initial password to specify password

passwd_file=/tmp/mysql_output.txt
passwd='pa$$w0rd'
init_passwd=`awk 'END{print $NF}' $passwd_file`

mysql -uroot -p"$init_passwd" --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY \"$passwd\";"
mysql -uroot -p"$passwd" <<EOF
USE mysql;
UPDATE user SET host='%' WHERE user='root' AND host='localhost';
FLUSH PRIVILEGES;
EOF

