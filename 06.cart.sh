color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"


echo -e "$color DOWNLOADING NODEJS REPO $nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
echo -e "$color INSTALLING NODEJS SERVICE $nocolor"
yum install nodejs -y &>>${logfile}
echo -e "$color ADDING USER AND LOCATION $nocolor"
useradd roboshop &>>${logfile}
mkdir ${app_path} 
cd ${app_path}
echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${logfile}
unzip cart.zip &>>${logfile}
rm -rf cart.zip
npm install &>>${logfile}
echo -e "$color CREATING CART SERVICE $nocolor"
cp /root/repos-shell/cart.service /etc/systemd/system/cart.service
echo -e "$color ENABLING AND STARTING THE CART SERVICE $nocolor"
systemctl daemon-reload
systemctl enable cart &>>${logfile}
systemctl restart cart

