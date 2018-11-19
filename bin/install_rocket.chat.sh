#!/bin/bash
if [ $USER != "root" ]; then
	echo "Run as root"
	exit 0
fi

DKR_EXE=`which docker`
if [ ! -x $DKR_EXE ]; then
	echo "Cannot verify which docker: $DKR_EXE"
	exit 0
fi

if [ $# -eq "0" ]; then
	echo "Specify host machine's IP address"
	exit 1
fi

DKR_NET=rocketchat_default
DKR_IP=$1 #10.95.151.132
DKR_PORT=8818

echo "Creating volumes"
docker volume create rocketchat_data
docker volume create rocketchat_dump
docker volume create rocketchat_upload
echo "Creating network"
docker network create $DKR_NET
#echo "Pulling images"
#docker pull mongo:3.2
#docker pull rocketchat/rocket.chat:latest
echo "Starting DB"
docker run -itd --name mongo --network $DKR_NET -v rocketchat_data:/data/db -v rocketchat_dump:/data/dump mongo:3.2 mongod --smallfiles --oplogSize 128 --replSet rs0 --storageEngine=mmapv1
echo "Running one-time DB configuration"
docker run --name mongo-init-replica --link mongo:mongo --rm --net=$DKR_NET mongo:3.2 mongo mongo/rocketchat --eval "rs.initiate({ _id: 'rs0', members: [ { _id: 0, host: 'localhost:27017' } ]})"
echo "Starting web"
docker run -itd --name rocketchat --network $DKR_NET -v rocketchat_upload:/app/uploads -e MONGO_OPLOG_URL=mongodb://mongo:27017/local -e MONGO_URL=mongodb://mongo:27017/rocketchat -e ROOT_URL=http://$DKR_IP:$DKR_PORT -p $DKR_PORT:3000 --link mongo:mongo rocketchat/rocket.chat:latest
echo "Adding port $DKR_PORT tp iptables"
iptables -A INPUT -p tcp --dport $DKR_PORT -j ACCEPT

echo "If no errors, server should now be up: http://$DKR_IP:$DKR_PORT"
