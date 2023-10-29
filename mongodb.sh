cp mongo.Repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y
sed -i -e '/127.0.0.0/0.0.0.0' /etc/mongod.conf
systemctl enable mongod
systemctl restart mongodk
echo $?

