#!/bin/bash

dnf update -y
dnf install httpd -y

systemctl enable httpd
systemctl start httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>AWS Cloud Dashboard</title>
</head>
<body style="font-family:Arial;text-align:center;margin-top:120px;">
<h1>☁ AWS Cloud Dashboard</h1>
<p>Running Successfully on Amazon EC2</p>
</body>
</html>
EOF
