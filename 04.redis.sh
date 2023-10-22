color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"

echo -e  "$color DOWNLOADING REDIS REPO $nocolor"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${logfile}
echo -e "$color ENABLING REDIS 6.2 $nocolor"
yum module list &>>${logfile}
yum module enable redis:remi-6.2 -y &>>${logfile}
echo -e "$color INSTALLING REDIS SERVICE $nocolor"
yum install redis -y &>>${logfile}
echo -e  "$color CHANGING THE LISTEN ADDRESS $nocolor"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf 
echo -e  "$color CHANGING THE ANOTHER LISTEN ADDRESS $nocolor"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
echo -e "$color ENABLING AND RESTARTING REDIS $nocolor"
systemctl enable redis &>>${logfile}
systemctl restart redis



