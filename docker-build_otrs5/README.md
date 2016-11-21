# docker-otrs5

```
sudo docker network create -d bridge otrs-net

sudo docker run -d --name otrs-db \
-v otrs-db:/var/lib/mysql \
--net otrs-net \
-e MYSQL_ROOT_PASSWORD=suP3rp244w0rds91r00t \
-e MYSQL_DATABASE=otrs \
-e MYSQL_USER=otrs \
-e MYSQL_PASSWORD=suP3rp244w0rds910tr4 \
jetrat/otrs5-db

sudo docker run -d --name otrs \
-v otrs-conf:/opt/otrs \
--net otrs-net \
-e OTRS_DB_HOST=otrs-db \
-e OTRS_DB_NAME=otrs \
-e OTRS_DB_USER=otrs \
-e OTRS_DB_PASS=suP3rp244w0rds910tr4 \
-p 80:80 \
jetrat/otrs5
```


If you're running new OTRS instance, you have to finish installation via web

* After running containers you have to open http://SERVER-IP:PORT/otrs/installer.pl in your browser
* On step 2/4 choose existing MySQL database
* On step 3/4 enter password from MYSQL_PASSWORD key (suP3rp244w0rds910tr4 by default)
* On step 4/4 WRITE DOWN password for root@localhost
