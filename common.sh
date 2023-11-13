log=/tmp/robofile.log
exit_fun () {
  if [ $? -eq 0 ]
  then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
  fi
}
App_prerequest_function () {
    log=/tmp/robofile.log
    echo -e "\e[34m<<<<Creating ${variable} service>>>>>>>>>>>>\e[0m"
    cp ${variable}service /etc/systemd/system/${variable}.service &>>${log}
    exit_fun

    echo -e "\e[34m >>>>>>>>>>>>>Adding User>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    id roboshop &>>${log}
    if [ $? -ne 0 ]
    then
    useradd roboshop &>>${log}
    fi
    exit_fun

    echo -e "\e[34m<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    rm -rf /app &>>${log}
    exit_fun

    echo -e "\e[34m<<<<creating app directory>>>>>>>>>>>>>>>>>>>>>\e[0m"
    mkdir /app &>>${log}
    exit_fun

    echo -e "\e[34m >>>>>>>>>>>>>Downloading the Application Content>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    curl -L -o /tmp/${variable}.zip https://roboshop-artifacts.s3.amazonaws.com/${variable}.zip &>>${log}
    exit_fun

    echo -e "\e[34m >>>>>>>>>>>>>Extracting the Application File>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    cd /app
    unzip /tmp/${varible}.zip &>>${log}
    cd /app &>>{log}
    exit_fun

}

systemd_function () {
  echo -e "\e[34m<<<<starting the ${variable} service>>>>>>>>>>>>>>>>>>>\e[0m"
  systemctl daemon-reload &>>${log}
  systemctl enable ${variable} &>>${log}
  systemctl start ${variable} &>>${log}
  exit_fun
}

schema_fun () {
  if [ "$schema_type" == mongodb ]
  then
    echo -e "\e[34m >>>>>>>>>>>>>Installation Mongodb Client>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    dnf install mongodb-org-shell -y &>>${log}
    exit_fun
    mongo --host mongodb.sreddy.online </app/schema/${variable}.js &>>${log}
    exit_fun
  fi

  if [ "$schema_type" == mysql ]
  then
   echo -e "\e[34m<<<<Loading the Sql Schema>>>>>>>>>>>>\e[0m"
   yum install mysql -y &>>${log}
   mysql -h mysql.sreddy.online -uroot -pRoboShop@1 </app/schema/${variable}.sql &>>${log}
   exit_fun
  fi

}
Node_js () {
  log=/tmp/robofile.log
  if [ ${variable} == user ]
  then
    echo -e "\e[34m >>>>>>>>>>>>>Mongodb Repo file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
    cp mongo.Repo /etc/yum.repos.d/mongo.repo
    exit_fun
  fi

  echo -e "\e[34m >>>>>>>>>>>>>Installation Node JS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  yum install nodejs -y &>>${log}
  App_prerequest_function

  echo -e "\e[34m >>>>>>>>>>>>>Mongodb dependencies>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
  cd /app
  npm install &>>${log}
  exit_fun

  schema_fun

  systemd_function

}

Catalogue () {
  log=/tmp/robofile.log
  echo -e "\e[34m<<<<copying Mongodb repo file>>>>>>>>>>>>>\e[0m"
  cp mongo.Repo /etc/yum.repos.d/mongo.repo &>>${log}
  exit_fun

  App_prerequest_function

  echo -e "\e[34m<<<<<<<installing Nodejs>>>>>>>>>>>>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log}
  yum install nodejs -y &>>${log}
  npm install &>>${log}
  exit_fun

  echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>${log}
  exit_fun

  schema_fun

  systemd_function
}

java_shipping () {

  echo -e "\e[34m<<<<Mysql repo>>>>>>>>>>>>\e[0m"
  cp sqlrepo /etc/yum.repos.d/mysql.repo &>>${log}
  exit_fun

  echo -e "\e[34m<<<<Installing Mavan>>>>>>>>>>>>\e[0m"
  yum install maven -y &>>${log}
  exit_fun

  App_prerequest_function

  mvn clean package
  exit_fun
  mv target/${variable}-1.0.jar ${variable}.jar &>>${log}
  exit_fun

  schema_fun

  systemd_function

}
python_payment () {


  App_prerequest_function
  sed -i "s/rabbitmq_password/${rabbitmq_password}/" /etc/systemd/system/${variable}.service &>>${log}

  echo -e "\e[34m<<<<Building ${variable} service>>>>>>>>>>>>\e[0m"
  yum install python36 gcc python3-devel -y &>>${log}
  pip3.6 install -r requirements.txt &>>${log}

  systemd_function
}

dispatch_fun () {
  log=/tmp/robofile.log

  echo -e "\e[34m<<<<Go Installation>>>>>>>>>>>>\e[0m"
  yum install golang -y &>>${log}
  exit_fun

  App_prerequest_function

  go mod init dispatch
  exit_fun
  go get &>>${log}
  exit_fun
  go build &>>${log}

  systemd_function
}
