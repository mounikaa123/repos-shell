color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

echo -e "\e[32m DOWNLOADING NODEJS REPO \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m INSTALLING NODEJS SERVICE \e[0m"
yum install nodejs -y
echo -e "\e[32m ADDING USER AND LOCATION \e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m DOWNLOADING NEW CONTENT AND DEPENDENCIES \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
unzip catalogue.zip
rm -rf catalogue.zip
npm install
echo -e "\e[32m CREATING CATALOGUE SERVICE \e[0m"
cp /root/repos-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m DOWNLOADING AND INSTALLING THE MONGODB SCHEMA \e[0m"
cp /root/repos-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.mounika.site </app/schema/catalogue.js
echo -e "\e[32m ENABLING AND STARTING THE CATALOGUE SERVICE \e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue