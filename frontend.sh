echo -e "\e[32m>>>>>>>>>>>>>Install Nginxx<<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nginx -y
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>Copy Reboshop Configuration<<<<<<<<<<<<<<<<\e[0m"
cp roboshopconfig /etc/nginx/default.d/roboshop.conf
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>Removing the old content<<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
exit_fun

echo -e "\e[32m>>>>>>>>>>>>Downloading the Application content<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>extracting the application content<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
exit_fun

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>>Starting the Nginx Service<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx
exit_fun