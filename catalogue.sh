echo -e "\e[34m<<<<Creating the Catalogue service>>>>>>>>>>>>\e[0m"
cp catalogueService /etc/systemd/system/catalogue.service &>>/tmp/robofile.log
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
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>/tmp/robofile.log
cd /app &>/tmp/robofile.log
unzip /tmp/catalogue.zip &>>/tmp/robofile.log
cd /app &>>/tmp/robofile.log
npm install &>>/tmp/robofile.log
echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y &>>/tmp/robofile.log
echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m"
mongo --host mongodb.sreddy.online </app/schema/catalogue.js &>>/tmp/robofile.log
echo -e "\e[34m<<<<starting the catlogue service>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue