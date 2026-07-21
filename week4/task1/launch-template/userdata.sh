#!/bin/bash

dnf update -y
dnf install -y httpd

systemctl enable httpd
systemctl start httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Week 4 Auto Scaling</title>
</head>
<body>
    <h1>Hello from Auto Scaling!</h1>
    <p>Hostname: $(hostname)</p>
</body>
</html>
EOF
