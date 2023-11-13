source common.sh
echo -e "\e[32m>>>>>>>>>>>>>Install Nginxx<<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nginx -y &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>Copy Reboshop Configuration<<<<<<<<<<<<<<<<\e[0m"
cp roboshopconfig /etc/nginx/default.d/roboshop.conf &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>Removing the old content<<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>Downloading the Application content<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>extracting the application content<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html &>>${log}
unzip /tmp/frontend.zip  &>>${log}
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>>Starting the Nginx Service<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}
exit_fun