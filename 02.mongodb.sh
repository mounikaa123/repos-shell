color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"

echo -e  "$color DOWNLOADING MONGODB REPO $nocolor"
cp /root/repos-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "$color INSTALLING MONGODB SERVICE $nocolor"
yum install mongodb-org -y &>>${logfile}
echo -e  "$color CHANGING THE LISTEN ADDRESS $nocolor"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "$color ENABLING AND RESTARTING MONGODB SERVICE $nocolor"
systemctl enable mongod &>>${logfile}
systemctl restart mongod
