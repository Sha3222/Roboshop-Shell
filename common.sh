log=/tmp/robofile.log
App_prerequest_function () {
    log=/tmp/robofile.log
    echo -e "\e[34m<<<<Creating ${variable} service>>>>>>>>>>>>\e[0m"
    cp Service /etc/systemd/system/payment.service &>>${log}
    echo -e "\e[34m >>>>>>>>>>>>>Adding User>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    useradd roboshop

    echo -e "\e[34m<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    rm -rf /app &>>${log}

    echo -e "\e[34m<<<<creating app directory>>>>>>>>>>>>>>>>>>>>>\e[0m"
    mkdir /app &>>${log}

    echo -e "\e[34m >>>>>>>>>>>>>Downloading the Application Content>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    curl -L -o /tmp/${varible}.zip https://roboshop-artifacts.s3.amazonaws.com/${variable}.zip &>>${log}

    echo -e "\e[34m >>>>>>>>>>>>>Extracting the Application File>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    cd /app
    unzip /tmp/${varible}.zip &>>${log}
    cd /app &>>{log}

}

systemd_function () {
  echo -e "\e[34m<<<<starting the ${variable} service>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>>${log}
  systemctl enable ${variable} &>>${log}
  systemctl start ${variable} &>>${log}
}
Node_js () {
  log=/tmp/robofile.log
  echo -e "\e[34m >>>>>>>>>>>>>Mongodb Repo file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cp mongo.Repo /etc/yum.repos.d/mongo.repo

  echo -e "\e[34m >>>>>>>>>>>>>Installation Node JS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  yum install nodejs -y &>>${log}
  App_prerequest_function

  echo -e "\e[34m >>>>>>>>>>>>>Mongodb dependencies>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  npm install &>>${log}

  echo -e "\e[34m >>>>>>>>>>>>>Installation Mongodb Client>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  dnf install mongodb-org-shell -y &>>${log}
  mongo --host mongodb.sreddy.online </app/schema/${varible}.js &>>${log}

  systemd_function

}

Catalogue () {
  log=/tmp/robofile.log
  echo -e "\e[34m<<<<Creating the ${variable}service>>>>>>>>>>>>\e[0m"
  cp ${variable}Service /etc/systemd/system/${variable}.service
  echo -e "\e[34m<<<<copying Mongodb repo file>>>>>>>>>>>>>\e[0m"
  cp mongo.Repo /etc/yum.repos.d/mongo.repo &>>${log}

  App_prerequest_function

  echo -e "\e[34m<<<<<<<installing Nodejs>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log}
  yum install nodejs -y &>>${log}
  npm install &>>${log}

  echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>${log}

  echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m"
  mongo --host mongodb.sreddy.online </app/schema/${variable}.js  &>>${log}

  systemd_function
}

java_shipping () {

  echo -e "\e[34m<<<<Mysql repo>>>>>>>>>>>>\e[0m"
  cp sqlrepo /etc/yum.repos.d/mysql.repo &>>${log}

  echo -e "\e[34m<<<<Installing Mavan>>>>>>>>>>>>\e[0m"
  yum install maven -y &>>${log}

  App_prerequest_function

  mvn clean package
  mv target/${variable}-1.0.jar ${variable}.jar &>>${log}

  echo -e "\e[34m<<<<Loading the Sql Schema>>>>>>>>>>>>\e[0m"
  yum install mysql -y &>>${log}
  mysql -h mysql.sreddy.online -uroot -pRoboShop@1 < /app/schema/${variable}.sql &>>${log}

  systemd_function

}
python_payment () {


  App_prerequest_function

  echo -e "\e[34m<<<<Building ${variable} service>>>>>>>>>>>>\e[0m"
  yum install python36 gcc python3-devel -y &>>${log}
  pip3.6 install -r requirements.txt &>>${log}

  systemd_function
}

