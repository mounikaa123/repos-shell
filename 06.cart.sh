source common.sh
component=cart


echo -e "$color DOWNLOADING NODEJS REPO $nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
echo -e "$color INSTALLING NODEJS SERVICE $nocolor"
yum install nodejs -y &>>${logfile}
echo -e "$color ADDING USER AND LOCATION $nocolor"
useradd roboshop &>>${logfile}
mkdir ${app_path}
cd ${app_path}
echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
unzip ${component}.zip &>>${logfile}
rm -rf ${component}.zip
npm install &>>${logfile}
echo -e "$color CREATING ${component} SERVICE $nocolor"
cp /root/repos-shell/${component}.service /etc/systemd/system/${component}.service
echo -e "$color ENABLING AND STARTING THE ${component} SERVICE $nocolor"
systemctl daemon-reload
systemctl enable ${component} &>>${logfile}
systemctl restart ${component}

