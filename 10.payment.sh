echo -e "\e[33m INSTALLING PYTHON 3.6 \e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[32m ADDING USER AND LOCATION \e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m DOWNLOADING NEW CONTENT AND DEPENDENCIES \e[0m"
curl -o https://roboshop-artifacts.s3.amazonaws.com/payment.zip
unzip /tmp/payment.zip
rm -rf payment.zip
pip3.6 install -r requirements.txt
echo -e "\e[32m CREATING PAYMENT SERVICE \e[0m"
cp /root/repos-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[32m ENABLING AND STARTING THE payment SERVICE \e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment
systemctl restart payment