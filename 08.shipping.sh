echo -e "\e[32m INSTALLING MAVEN SERVICE \e[0m"
yum install maven -y
echo -e "\e[32m ADDING USER AND LOCATION \e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m DOWNLOADING NEW CONTENT AND DEPENDENCIES \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
unzip shipping.zip
rm -rf shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[32m CREATING SHIPPING SERVICE \e[0m"
cp /root/repos-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m INSTALLING MySql SERVICE \e[0m"
yum install mysql -y
echo -e "\e[32M LOADING MySql SCHEME \e[0m"
mysql -h mysql-dev.mounika.site -uroot -pRoboShop@1 </app/schema/shipping.sql
echo -e "\e[32m ENABLING AND STARTING THE SHIPPING SERVICE \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping




