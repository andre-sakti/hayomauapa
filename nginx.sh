cd /root/;
apt install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev -y;
wget -q -O /root/nginx.tar.gz http://nginx.org/download/nginx-1.19.9.tar.gz;
tar -zxvf nginx.tar.gz; cd nginx-1.19.9/;
./configure --prefix=/etc/biji/webserver/ \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --http-log-path=/var/log/nginx/access.log \
            --error-log-path=/var/log/nginx/error.log \
            --with-pcre  --lock-path=/var/lock/nginx.lock \
            --pid-path=/var/run/nginx.pid \
            --with-http_ssl_module \
            --with-http_image_filter_module=dynamic \
            --modules-path=/etc/nginx/modules \
            --with-http_v2_module \
            --with-stream=dynamic \
            --with-http_addition_module \
            --with-http_mp4_module \
            --with-http_realip_module;
make && make install;
cd && rm -rf /root/nginx-1.19.9 && rm -f /root/nginx.tar.gz;
cat > /lib/systemd/system/nginx.service << END
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target
        
[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
        
[Install]
WantedBy=multi-user.target
END
systemctl stop nginx;
rm -rf /etc/nginx/sites-*;
mkdir -p /etc/nginx/conf.d/;
wget -q -O /etc/nginx/nginx.conf "FILE NGINX.CONF";
wget -q -O /etc/nginx/conf.d/vps.conf "FILE VPS.CONF";
mkdir -p /etc/biji/webserver/;
echo -e "hayoloooh" >> /etc/biji/webserver/index.html ;
sudo chown -R www-data:www-data /etc/biji/webserver/;
sudo chmod 755 /etc/biji/webserver/;
systemctl enable nginx;
systemctl start nginx;