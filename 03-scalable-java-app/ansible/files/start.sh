#!/bin/bash

JAR_FILE=/home/ubuntu/pet-clinic-1.0.1.jar
APP_PROPERTIES=/opt/application.properties
PROPERTIES_SCRIPT=/home/ubuntu/properties.py

sudo python3 ${PROPERTIES_SCRIPT}

sudo java -jar "${JAR_FILE}" --spring.config.location="${APP_PROPERTIES}" --spring.profiles.active=mysql &