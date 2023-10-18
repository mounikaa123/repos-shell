echo -e "\e[33m INSTALLING NGINX SERVICE \e[0m"
yum install nginx -y
echo -e "\e[32m REMOVING DEFAULT NGINX CONTENT \e[0m"
cd /usr/share/nginx/html
rm -rf *
echo -e  "\e[31m DOWNLOADING NEW CONTENT TO NGINX \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip frontend.zip
rm -rf frontend.zip
echo -e  "\e[30mCONFIGURING REVERSE PROXY SERVER \e[0m"
cp /root/repos-shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf
echo -e "\e[34m ENABLING AND RESTARTING NGINX \e[0m"
systemctl enable nginx
systemctl restart nginx




