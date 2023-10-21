color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"

echo -e "$color INSTALLING NGINX SERVICE $nocolor"
yum install nginx -y &>>${logfile}
echo -e "$color REMOVING DEFAULT NGINX CONTENT $nocolor"
cd /usr/share/nginx/html
rm -rf * &>>${logfile}
echo -e  "$color DOWNLOADING NEW CONTENT TO NGINX $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
unzip frontend.zip &>>${logfile}
rm -rf frontend.zip
echo -e  "$color CONFIGURING REVERSE PROXY SERVER $nocolor"
cp /root/repos-shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf
echo -e "$color ENABLING AND RESTARTING NGINX $nocolor"
systemctl enable nginx &>>${logfile}
systemctl restart nginx




