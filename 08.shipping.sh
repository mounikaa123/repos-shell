color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"


echo -e "$color INSTALLING MAVEN SERVICE $nocolor"
yum install maven -y &>>${logfile}
echo -e "$color ADDING USER AND LOCATION $nocolor"
useradd roboshop &>>${logfile}
rm -rf ${app_path}
mkdir ${app_path}
cd ${app_path}
echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${logfile}
unzip shipping.zip &>>${logfile}
mvn clean package &>>${logfile}
mv target/shipping-1.0.jar shipping.jar
echo -e "$color CREATING SHIPPING SERVICE $nocolor"
cp /root/repos-shell/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
echo -e "$color INSTALLING MySql SERVICE $nocolor"
yum install mysql -y &>>${logfile}
echo -e "$color LOADING MySql SCHEME $nocolor"
mysql -h mysql-dev.mounika.site -uroot -pRoboShop@1 <${app_path}/schema/shipping.sql &>>${logfile}
echo -e "$color ENABLING AND STARTING THE SHIPPING SERVICE $nocolor"
systemctl enable shipping &>>${logfile}
systemctl restart shipping




