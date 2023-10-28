Node_js () {
  echo -e "\e[34m >>>>>>>>>>>>>>>>>>Creating User Services>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cp userservice /etc/systemd/system/user.service &>> /tmp/robofile.log
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
  curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
  echo -e "\e[34m >>>>>>>>>>>>>Extracting the Application File>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  unzip /tmp/user.zip
  echo -e "\e[34m >>>>>>>>>>>>>Mongodb dependencies>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  npm install
  echo -e "\e[34m >>>>>>>>>>>>>Installation Mongodb Client>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  dnf install mongodb-org-shell -y
  mongo --host mongodb.sreddy.online </app/schema/user.js
  echo -e "\e[34m >>>>>>>>>>>>>Start User Service>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload
  systemctl enable user
  systemctl restart user
}
