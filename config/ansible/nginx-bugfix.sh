sudo mkdir /etc/systemd/system/nginx.service.d
sudo touch /etc/systemd/system/nginx.service.d/override.conf
sudo chmod 777 /etc/systemd/system/nginx.service.d/override.conf
sudo printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart nginx
