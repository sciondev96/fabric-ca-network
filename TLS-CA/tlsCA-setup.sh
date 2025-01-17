#!/usr/bin/env bash

# creates home directory for TLS-CA Server and TLS-CA client

mkdir -p server/crypto
mkdir -p client/crypto

sleep 2s

# starts the tls-ca server

echo
echo
echo "### Starting fabric CA server ###"
echo
echo

docker-compose -f tls-ca-server.yaml up -d

sleep 5

# copies the tls-CA server root certificate to tls-ca client for tls authentication

echo "##########################################################"
cp ./server/crypto/ca-cert.pem ./client/crypto/tls-ca-cert.pem
echo "Copied"
echo "##########################################################"
echo
echo
sleep 2

export FABRIC_CA_CLIENT_HOME=./client
export FABRIC_CA_CLIENT_TLS_CERTFILES=crypto/tls-ca-cert.pem

# the commands below will enroll the TLS CA admin and then registers indenties to provide them with tls certificate upon enrollment
echo "##########################################################"
echo
fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer1-org3 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name peer2-org3 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

echo "##########################################################"
echo
fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
echo
echo "##########################################################"
sleep 2

