source common.sh
component=nginx

echo -e "$color INSTALLING $component SERVICE $nocolor"
yum install $component -y &>>${logfile}
echo -e "$color REMOVING DEFAULT $component CONTENT $nocolor"
cd /usr/share/$component/html
rm -rf * &>>${logfile}
echo -e  "$color DOWNLOADING NEW CONTENT TO $component $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
unzip frontend.zip &>>${logfile}
rm -rf frontend.zip
echo -e  "$color CONFIGURING REVERSE PROXY SERVER $nocolor"
cp /root/repos-shell/roboshop.conf  /etc/$component/default.d/roboshop.conf
echo -e "$color ENABLING AND RESTARTING $component $nocolor"
systemctl enable $component &>>${logfile}


systemctl restart $component




