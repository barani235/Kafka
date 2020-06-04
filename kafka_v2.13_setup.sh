#!/bin/sh
#Install JDK 8
sudo apt update && sudo apt install -y openjdk-8-jdk
#Download and untar Kafka 2.13
wget "https://downloads.apache.org/kafka/2.5.0/kafka_2.13-2.5.0.tgz"
tar -xvf kafka_2.13-2.5.0.tgz
#Export Kafka path
echo "export PATH=$HOME/kafka_2.13-2.5.0/bin:$PATH" >> $HOME/.bashrc
#Create data directories for zookeeper and kafka for log data storage
mkdir -p $HOME/kafka_2.13-2.5.0/data/zookeeper
mkdir -p $HOME/kafka_2.13-2.5.0/data/kafka
#Edit config files of zookeeper and kafka server to reflect the changes in datadir
sed -i "s|/tmp/zookeeper|$HOME/kafka_2.13-2.5.0/data/zookeeper|g" $HOME/kafka_2.13-2.5.0/config/zookeeper.properties
sed -i "s|/tmp/kafka-logs|$HOME/kafka_2.13-2.5.0/data/kafka|g" $HOME/kafka_2.13-2.5.0/config/server.properties
#Perform below steps if your instance has memory limitations, if not leave it to default
#Update Kafka Heap memory to use less than 1 GB
sed -i "s/1G/512M/g" $HOME/kafka_2.13-2.5.0/bin/kafka-server-start.sh
#Update Zookeeper Heap memory to use less than 0.5 GB
sed -i "s/512M/256M/g" $HOME/kafka_2.13-2.5.0/bin/zookeeper-server-start.sh
#To access kafka externally, uncomment advertised.listeners in server.properties and set it to advertised.listeners=PLAINTEXT://public_ip:9092
#For the changes in the PATH variable to take effect in the current session, use the command `source $HOME/.bashrc`
