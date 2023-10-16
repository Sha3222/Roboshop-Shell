cp userservice /etc/systemd/system/user.service
cp mongo.Repo /etc/yum.repos.d/mongo.repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install

dnf install mongodb-org-shell -y
mongo --host mongodb.sreddy.online </app/schema/user.js
systemctl daemon-reload
systemctl enable user
systemctl restart user