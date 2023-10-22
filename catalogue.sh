echo -e "\e[34m<<<<Creating the Catalogue service>>>>>>>>>>>>\e[0m" &>/temp/robofile
cp catalogueService /etc/systemd/system/catalogue.service
echo -e "\e[34m<<<<copying Mongodb repo file>>>>>>>>>>>>>\e[0m" &>/temp/robofile
cp mongo.Repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m<<<<<<<installing Nodejs>>>>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo -e "\e[34m<<<<Adding Roboshop user>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
useradd roboshop
echo -e "\e[34m<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
rm -rf /app
echo -e "\e[34m<<<<creating app directory>>>>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
echo -e "\e[34m<<<<<insatlling mongod>>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
yum install mongodb-org-shell -y
echo -e "\e[34m<<<<loading schema>>>>>>>\e[0m" &>/temp/robofile
mongo --host mongodb.sreddy.online </app/schema/catalogue.js
echo -e "\e[34m<<<<starting the catlogue service>>>>>>>>>>>>>>>>>>>\e[0m" &>/temp/robofile
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue