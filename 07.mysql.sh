color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"


echo -e "$color DISABLING MySql SERVICE $nocolor"
yum module disable mysql -y &>>${logfile}
echo -e  "$color SETTING MySql REPO $nocolor"
cp /root/repos-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "$color INSTALLING MySql SERVER $nocolor"
yum install mysql-community-server -y &>>${logfile}
echo -e "$color CHANGING THE DEFAULT ROOT PASSWORD $nocolor"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${logfile}
echo -e "$color ENABLING AND STARTING THE MYSQL SERVICE $nocolor"
systemctl enable mysqld &>>${logfile}
systemctl restart mysqld
