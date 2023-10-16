cp mongo.Repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod

systemctl restart mongodk

