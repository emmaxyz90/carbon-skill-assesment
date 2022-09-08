#!/bin/bash

db_vol=$(dialog --title "Docker Build Script" --inputbox "Database Container Volume Name:" 10 40 3>&1 1>&2 2>&3 3>&-) 

  if [ ! -e ./docker-compose.yml ]; then
    touch docker-compose.yml
  else
    rm docker-compose.yml
    touch docker-compose.yml
  fi

  echo "version: \'3\'" >> docker-compose.yml
  echo "services:" >> docker-compose.yml
  echo "  webserver:" >> docker-compose.yml
  echo "    image: nginx:alpine" >> docker-compose.yml
  echo "    container_name: webserver" >> docker-compose.yml
  echo "    ports:" >> docker-compose.yml
  echo "      - "80:80"" >> docker-compose.yml
  echo "      - "443:443"" >> docker-compose.yml
  echo "    networks:" >> docker-compose.yml
  echo "      - my_net" >> docker-compose.yml

  echo "  mysql:" >> docker-compose.yml
  echo "    image: mysql:5.7" >> docker-compose.yml
  echo "    container_name: database" >> docker-compose.yml
  echo "    ports:" >> docker-compose.yml
  echo "      - "3306:3306"" >> docker-compose.yml
  echo "    volumes:" >> docker-compose.yml
  echo "      - $db_vol:/var/lib/mysql" >> docker-compose.yml
  echo "    environment:" >> docker-compose.yml
  echo "      - MYSQL_ROOT_PASSWORD=1234" >> docker-compose.yml
  echo "      - MYSQL_DATABASE=wordpress" >> docker-compose.yml
  echo "      - MYSQL_USER=wordpress" >> docker-compose.yml
  echo "      - MYSQL_PASSWORD=wordpress" >> docker-compose.yml
  echo "    networks:" >> docker-compose.yml
  echo "      - my_net" >> docker-compose.yml

  echo "  kibana:" >> docker-compose.yml
  echo "    image: docker.elastic.co/kibana/kibana:6.4.2" >> docker-compose.yml
  echo "    container_name: Kibana" >> docker-compose.yml
  echo "    ports:" >> docker-compose.yml
  echo "      - "3306:3306"" >> docker-compose.yml
  echo "    volumes:" >> docker-compose.yml
  echo "      - ./kibana.yml:/usr/share/kibana/config/kibana.yml" >> docker-compose.yml
  echo "    environment:" >> docker-compose.yml
  echo "      - SERVER_NAME=kibana.example.org" >> docker-compose.yml
  echo "      - ELASTICSEARCH_URL: http://elasticsearch.example.org" >> docker-compose.yml
  echo "    networks:" >> docker-compose.yml
  echo "      - my_net" >> docker-compose.yml
  echo "volumes:" >> docker-compose.yml
  echo "  $db_vol:" >> docker-compose.yml
  echo "networks:" >> docker-compose.yml
  echo "  my_net:" >> docker-compose.yml


docker-compose -f docker-compose.yml up -d

exit 0 
