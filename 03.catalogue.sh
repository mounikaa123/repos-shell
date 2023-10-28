source common.sh
component=catalogue

echo -e "$color DOWNLOADING NODEJS REPO $nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "$color INSTALLING NODEJS SERVICE $nocolor"
yum install nodejs -y &>>${logfile}
echo -e "$color ADDING USER AND LOCATION $nocolor"k
useradd roboshop &>>${logfile}
mkdir ${app_path} 
cd ${app_path} 
echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${logfile}
unzip $component.zip &>>${logfile}
rm -rf $component.zip &>>${logfile}
npm install &>>${logfile}
echo -e "$color CREATING $component SERVICE $nocolor"
cp /root/repos-shell/$component.service /etc/systemd/system/$component.service
echo -e "$color DOWNLOADING AND INSTALLING THE MONGODB SCHEMA $nocolor"
cp /root/repos-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>${logfile}
mongo --host mongodb-dev.mounika.site <${app_path}/schema/$component.js
echo -e "$color ENABLING AND STARTING THE $component SERVICE $nocolor"
systemctl daemon-reload
systemctl enable $component &>>${logfile}
systemctl restart $component