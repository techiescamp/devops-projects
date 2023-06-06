#!/bin/bash

JAR_FILE=/home/ubuntu/petclinic-3.0.7.jar
APP_PROPERTIES=/home/ubuntu/application.properties
PROPERTIES_SCRIPT=/home/ubuntu/properties.py

encrypt=$(aws secretsmanager get-secret-value --secret-id consul-token --query SecretString --output text --region us-west-2 | grep -o '"consul":"[^"]*' | cut -d':' -f2- | sed 's/"//g')

sudo nohup consul agent -config-dir /etc/consul.d/ &

python3 ${PROPERTIES_SCRIPT}

sudo java -jar ${JAR_FILE} --spring.config.location=${APP_PROPERTIES} --spring.profiles.active=mysql & \
java -javaagent:/home/ubuntu/jmx_prometheus_javaagent-0.18.0.jar=9090:/home/ubuntu/config.yml -jar ${JAR_FILE} &