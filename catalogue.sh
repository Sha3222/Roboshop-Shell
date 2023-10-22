echo -e "\e[34m<<<<Creating the Catalogue service>>>>>>>>>>>>\e[0m"
cp catalogueService /etc/systemd/system/catalogue.service
echo -e "\e[34m<<<<copying Mongodb repo file>>>>>>>>>>>>>\e[0m"
cp mongo.Repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m<<<<<<<installing Nodejs>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo -e "\e[34m<<<<Adding Roboshop user>>>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[34m<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
echo -e "\e[34m<<<<creating app directory>>>>>>>>>>>>>>>>>>>>>\e[0m"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m"
mongo --host mongodb.sreddy.online </app/schema/catalogue.js
echo -e "\e[34m<<<<starting the catlogue service>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue