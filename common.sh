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
  mongo --host mongodb.sreddy.online </app/schema/user.js &>> /tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Start User Service>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>> /tmp/robofile.log
  systemctl enable ${varible} &>> /tmp/robofile.log
  systemctl restart ${varible} &>> /tmp/robofile.log
}

catalogue () {
  echo -e "\e[34m<<<<Creating the Catalogue service>>>>>>>>>>>>\e[0m"
  cp ${varible}Service /etc/systemd/system/${varible}.service &>>/tmp/robofile.log
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
  curl -o /tmp/${varible}.zip https://roboshop-artifacts.s3.amazonaws.com/${varible}.zip &>/tmp/robofile.log
  echo -e "\e[34m<<<<Extracting application content>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app &>/tmp/robofile.log
  unzip /tmp/${varible}.zip &>>/tmp/robofile.log
  cd /app &>>/tmp/robofile.log
  npm install &>>/tmp/robofile.log
  echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>/tmp/robofile.log
  echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m"
  mongo --host mongodb.sreddy.online </app/schema/catalogue.js &>>/tmp/robofile.log
  echo -e "\e[34m<<<<starting the catlogue service>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>>/tmp/robofile.log
  systemctl enable ${varible} &>>/tmp/robofile.log
  systemctl start ${varible} &>>/tmp/robofile.log
}
