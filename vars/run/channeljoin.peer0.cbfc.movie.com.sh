#!/bin/bash
# Script to join a peer to a channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=192.168.1.5:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/cbfc.movie.com/peers/peer0.cbfc.movie.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=cbfc-movie-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/cbfc.movie.com/users/Admin@cbfc.movie.com/msp
export ORDERER_ADDRESS=192.168.1.5:7012
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/orderer/orderers/orderer1.orderer/tls/ca.crt
if [ ! -f "mychannel.genesis.block" ]; then
  peer channel fetch oldest -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA \
  --tls -c mychannel /vars/mychannel.genesis.block
fi

peer channel join -b /vars/mychannel.genesis.block \
  -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA --tls
