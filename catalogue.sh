echo "<<<<Creating the Catalogue service>>>>>"
cp catalogueService /etc/systemd/system/catalogue.service
echo "<<<<copying Mongodb repo file>>>>>"
cp mongo.Repo /etc/yum.repos.d/mongo.repo
echo "<<<<<<<installing Nodejs>>>>>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo "<<<<Adding Roboshop user>>>>>>"
useradd roboshop
echo "<<<<<<<<<<<<<<<<<removing app>>>>>>>>>>>>>>>>>>>>>>"
rm -rf /app
echo "<<<<creating app directory>>>>>"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
echo "<<<<<insatlling mongod>>>>"
yum install mongodb-org-shell -y
echo "<<<<loading schema>>>"
mongo --host mongodb.sreddy.online </app/schema/catalogue.js
echo "<<<<starting the catlogue service>>>>>"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue