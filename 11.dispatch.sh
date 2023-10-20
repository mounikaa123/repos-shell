echo -e "\e[33m INSTALLING GOLANG SERVICE \e[0m"
yum install golang -y
echo -e "\e[32m ADDING USER AND LOCATION \e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m DOWNLOADING NEW CONTENT AND DEPENDENCIES \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
unzip dispatch.zip
rm -rf dispatch.zip
go mod init dispatch
go get
go build
echo -e "\e[32m ENABLING AND STARTING THE DISPATCH SERVICE \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
