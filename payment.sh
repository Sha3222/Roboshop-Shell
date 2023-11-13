variable=payment
source common.sh
rabbitmq_password=$1
if [ -z "${rabbitmq_password}" ]
then
  echo invalid password
  exit 1
fi

python_payment