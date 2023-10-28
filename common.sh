color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

nodejs()
{
  echo -e "$color DOWNLOADING NODEJS REPO $nocolor"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  echo -e "$color INSTALLING NODEJS SERVICE $nocolor"
  yum install nodejs -y &>>${logfile}
  app_start
  npm install &>>${logfile}
  service_start


}

app_start()
{
  echo -e "$color ADDING USER AND LOCATION $nocolor"k
    useradd roboshop &>>${logfile}
    mkdir ${app_path}
    cd ${app_path}
    echo -e "$color DOWNLOADING NEW CONTENT AND DEPENDENCIES $nocolor"
    curl -O https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${logfile}
    unzip $component.zip &>>${logfile}
    rm -rf $component.zip &>>${logfile}

}

mongo_schema()
{
  echo -e "$color DOWNLOADING AND INSTALLING THE MONGODB SCHEMA $nocolor"
    cp /root/repos-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
    yum install mongodb-org-shell -y &>>${logfile}
    mongo --host mongodb-dev.mounika.site <${app_path}/schema/$component.js

}

service_start()
{
  echo -e "$color CREATING $component SERVICE $nocolor"
    cp /root/repos-shell/$component.service /etc/systemd/system/$component.service
    echo -e "$color ENABLING AND STARTING THE $component SERVICE $nocolor"
    systemctl daemon-reload
    systemctl enable $component &>>${logfile}
    systemctl restart $component
}