#!/bin/bash

JAR_FILE=/home/ubuntu/spring-petclinic.jar

APP_PROP=/home/ubuntu/application.properties

START_FILE=/home/ubuntu/properties.py

python3 ${START_FILE}

sudo java -jar ${JAR_FILE} --spring.config.location= ${APP_PROP} --spring.profiles.active=mysql &