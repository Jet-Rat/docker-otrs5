# docker-otrs5

```
sudo docker network create -d bridge otrs-net

suP3rp244w0rds910tr4
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
-e OTRS_DB_HOST=otrs-db
-e OTRS_DB_NAME=otrs
-e OTRS_DB_USER=otrs
-e OTRS_DB_PASS=suP3rp244w0rds910tr4
-p 80:80 \
jetrat/otrs5
```
