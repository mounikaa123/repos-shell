echo -e  "\e[32m DOWNLOADING REDIS REPO \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[32m ENABLING REDIS 6.2 \e[0m"
yum module list
yum module enable redis:remi-6.2 -y
echo -e "\e[33m INSTALLING REDIS SERVICE \e[0m"
yum install redis -y
echo -e  "\e[32m CHANGING THE LISTEN ADDRESS \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
echo -e  "\e[32m CHANGING THE ANOTHER LISTEN ADDRESS \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
echo -e "\e[32m ENABLING AND RESTARTING REDIS \e[0m"
systemctl enable redis
systemctl restart redis



