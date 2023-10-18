yum install nginx -y
cd /usr/share/nginx/html
rm -rf *
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip frontend.zip
rm -rf frontend.zip
cp /root/repos-shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf
systemctl enable nginx
systemctl restart nginx




