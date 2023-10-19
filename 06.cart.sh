echo -e "\e[32m DOWNLOADING NODEJS REPO \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m INSTALLING NODEJS SERVICE \e[0m"
yum install nodejs -y
echo -e "\e[32m ADDING USER AND LOCATION \e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m DOWNLOADING NEW CONTENT AND DEPENDENCIES \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/cart.zip
unzip cart.zip
rm -rf cart.zip
npm install
echo -e "\e[32m CREATING CART SERVICE \e[0m"
cp /root/repos-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m ENABLING AND STARTING THE CART SERVICE \e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

