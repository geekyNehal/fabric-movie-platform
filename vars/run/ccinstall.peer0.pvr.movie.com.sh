#!/bin/bash
# Script to install chaincode onto a peer node
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=192.168.1.5:7007
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/pvr.movie.com/peers/peer0.pvr.movie.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=pvr-movie-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/pvr.movie.com/users/Admin@pvr.movie.com/msp
cd /go/src/github.com/chaincode/fabcar


if [ ! -f "fabcar_go_1.0.tar.gz" ]; then
  cd go
  GO111MODULE=on
  go mod vendor
  cd -
  peer lifecycle chaincode package fabcar_go_1.0.tar.gz \
    -p /go/src/github.com/chaincode/fabcar/go/ \
    --lang golang --label fabcar_1.0
fi

peer lifecycle chaincode install fabcar_go_1.0.tar.gz
