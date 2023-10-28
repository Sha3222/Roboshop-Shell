
log=/tmp/robofile.log
Node_js () {
  echo -e "\e[34m >>>>>>>>>>>>>>>>>>Creating User Services>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cp ${varible} /etc/systemd/system/${varible}.service &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Mongodb Repo file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cp mongo.Repo /etc/yum.repos.d/mongo.repo
  echo -e "\e[34m >>>>>>>>>>>>>Installation Node JS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/robofile.log
  yum install nodejs -y &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Adding User>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  useradd roboshop
  echo -e "\e[34m >>>>>>>>>>>>>Removing App Directory>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  rm -rf /app &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Creating App Directory>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  mkdir /app
  echo -e "\e[34m >>>>>>>>>>>>>Downloading the Application Content>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -L -o /tmp/${varible}.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Extracting the Application File>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  unzip /tmp/${varible}.zip &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Mongodb dependencies>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  npm install &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Installation Mongodb Client>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  dnf install mongodb-org-shell -y &>> /tmp/robofile.log
  mongo --host mongodb.sreddy.online </app/schema/${varible}.js &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Start User Service>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>> /tmp/robofile.log
  systemctl enable ${varible} &>> /tmp/robofile.log
  systemctl restart ${varible} &>> /tmp/robofile.log
}

Catalogue () {
  echo -e "\e[34m<<<<Creating the ${variable}service>>>>>>>>>>>>\e[0m"
  cp ${variable}Service /etc/systemd/system/${variable}.service
  echo -e "\e[34m<<<<copying Mongodb repo file>>>>>>>>>>>>>\e[0m"
  cp mongo.Repo /etc/yum.repos.d/mongo.repo &>>/tmp/robofile.log
  echo -e "\e[34m<<<<<<<installing Nodejs>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/robofile.log
  yum install nodejs -y &>/tmp/robofile.log
  echo -e "\e[34m<<<<Adding Roboshop user>>>>>>>>>>>>>>>>>>\e[0m"
  useradd roboshop &>>/tmp/robofile.log
  echo -e "\e[34m<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  rm -rf /app &>/tmp/robofile.log
  echo -e "\e[34m<<<<creating app directory>>>>>>>>>>>>>>>>>>>>>\e[0m"
  mkdir /app &>>/tmp/robofile.log
  echo -e "\e[34m<<<<Downloading Application Content>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -o /tmp/${variable}.zip https://roboshop-artifacts.s3.amazonaws.com/${variable}.zip &>/tmp/robofile.log
  echo -e "\e[34m<<<<Extracting application content>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app &>/tmp/robofile.log
  unzip /tmp/${varible}.zip &>>/tmp/robofile.log
  cd /app &>>/tmp/robofile.log
  npm install &>>/tmp/robofile.log
  echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>/tmp/robofile.log
  echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m"
  mongo --host mongodb.sreddy.online </app/schema/${variable}.js  &>>/tmp/robofile.log
  echo -e "\e[34m<<<<starting the catlogue service>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>>/tmp/robofile.log
  systemctl enable ${variable} &>>/tmp/robofile.log
  systemctl start ${variable} &>>/tmp/robofile.log
}

java_shipping () {
  echo -e "\e[34m<<<<Creating the ${variable}service>>>>>>>>>>>>\e[0m"
  cp shippingservice /etc/systemd/system/shipping.service
  echo -e "\e[34m<<<<Mysql repo>>>>>>>>>>>>\e[0m"
  cp sqlrepo /etc/yum.repos.d/mysql.repo
  echo -e "\e[34m<<<<Installing Mavan>>>>>>>>>>>>\e[0m"
  yum install maven -y
  echo -e "\e[34m<<<< Adding roboshop>>>>>>>>>>>>\e[0m"
  useradd roboshop
  echo -e "\e[34m<<<<Cleaning the App directory>>>>>>>>>>>>\e[0m"
  rm -rf /app
  echo -e "\e[34m<<<<Creating the App Directory>>>>>>>>>>>>\e[0m"
  mkdir /app
  echo -e "\e[34m<<<<Downloading the Application content>>>>>>>>>>>>\e[0m"
  curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
  cd /app
  echo -e "\e[34m<<<<Extracting the file>>>>>>>>>>>>\e[0m"
  unzip /tmp/shipping.zip
  cd /app
  mvn clean package
  mv target/shipping-1.0.jar shipping.jar
  echo -e "\e[34m<<<<Loading the Sql Schema>>>>>>>>>>>>\e[0m"
  yum install mysql -y
  mysql -h mysql.sreddy.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

  echo -e "\e[34m<<<<Starting the service>>>>>>>>>>>>\e[0m"
  systemctl enable shipping
  systemctl restart shipping
}