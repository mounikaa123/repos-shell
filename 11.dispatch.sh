color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

echo -e "$color INSTALLING GOLANG SERVICE $nocolor"
yum install golang -y &>>${logfile}
echo -e "$color ADDING USER AND LOCATION $nocolor"
useradd roboshop &>>${logfile}
mkdir ${app_path}
cd ${app_path}
echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${logfile}
unzip dispatch.zip &>>${logfile}
rm -rf dispatch.zip
go mod init dispatch &>>${logfile}
go get &>>${logfile}
go build &>>${logfile}
echo -e "$color creating payment service file $nocolor"
cp /root/repos-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "$color ENABLING AND STARTING THE DISPATCH SERVICE $nocolor"
systemctl daemon-reload
systemctl enable dispatch &>>${logfile}
systemctl restart dispatch
