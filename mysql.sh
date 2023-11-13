source common.sh
mysql_root_password=$1
if [ -z "${mysql_root_password}" ]
then
  echo Input password missing
  exit 1
fi
echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>Copying the mysql repo file>>>>>>>>>>>>>>>>>>>>\e[0m"
cp sqlrepo /etc/yum.repos.d/mysql.repo &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>Module disable >>>>>>>>>>>>>>>>>>>>\e[0m"
yum module disable mysql -y &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>Installing Mysql>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mysql-community-server -y &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>Starting mysql service>>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable mysqld &>>${log}
systemctl start mysqld &>>${log}
exit_fun

mysql_secure_installation --set-root-pass ${mysql_root_password}
mysql -uroot -pRoboShop@1
