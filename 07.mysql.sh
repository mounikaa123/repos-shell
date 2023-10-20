echo -e "\e[32m DISABLING MySql SERVICE \e[0m"
yum module disable mysql -y
echo -e  "\e[32m SETTING MySql REPO \e[0m"
cp /root/repos-shell/MySql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[32m INSTALLING MySql SERVER \e[0m"
yum install mysql-community-server -y
echo -e "\e[32m CHANGING THE DEFAULT ROOT PASSWORD \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
echo -e "\e[32m ENABLING AND STARTING THE MYSQL SERVICE \e[0m"
systemctl daemon-reload
systemctl enable mysql
systemctl restart mysql

