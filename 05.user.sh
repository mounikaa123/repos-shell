color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

echo -e "${color} DOWNLOADING NODEJS REPO ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
echo -e "${color} INSTALLING NODEJS SERVICE ${nocolor}"
yum install nodejs -y &>>${logfile}
echo -e "${color} ADDING USER AND LOCATION ${nocolor}"
useradd roboshop &>>${logfile}
rm -rf ${app_path} 
mkdir ${app_path}
cd ${app_path}
echo -e "${color} DOWNLOADING NEW CONTENT AND DEPENDENCIES ${nocolor}"
curl -O https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${logfile}
unzip user.zip &>>${logfile}
rm -rf user.zip
npm install &>>${logfile}
echo -e "${color} CREATING user SERVICE ${nocolor}"
cp /root/repos-shell/user.service /etc/systemd/system/user.service
systemctl daemon-reload
echo -e "${color} DOWNLOADING AND INSTALLING THE MONGODB SCHEMA ${nocolor}"
cp /root/repos-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>${logfile}
mongo --host mongodb-dev.mounika.site <${app_path}/schema/user.js
echo -e "${color} ENABLING AND STARTING THE user SERVICE ${nocolor}"
systemctl enable user &>>${logfile}
systemctl restart user




