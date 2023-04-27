#!/bin/bash
# Script to instantiate chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=192.168.1.5:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/cbfc.movie.com/peers/peer0.cbfc.movie.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=cbfc-movie-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/cbfc.movie.com/users/Admin@cbfc.movie.com/msp
export ORDERER_ADDRESS=192.168.1.5:7012
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/orderer/orderers/orderer1.orderer/tls/ca.crt
SID=$(peer lifecycle chaincode querycommitted -C mychannel -O json \
  | jq -r '.chaincode_definitions|.[]|select(.name=="fabcar")|.sequence' || true)

if [[ -z $SID ]]; then
  SEQUENCE=1
else
  SEQUENCE=$((1+$SID))
fi

peer lifecycle chaincode commit -o $ORDERER_ADDRESS --channelID mychannel \
  --name fabcar --version 1.0 --sequence $SEQUENCE \
  --peerAddresses 192.168.1.5:7004 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/cbfc.movie.com/peers/peer0.cbfc.movie.com/tls/ca.crt \
  --peerAddresses 192.168.1.5:7006 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/inox.movie.com/peers/peer0.inox.movie.com/tls/ca.crt \
  --peerAddresses 192.168.1.5:7007 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/pvr.movie.com/peers/peer0.pvr.movie.com/tls/ca.crt \
  --peerAddresses 192.168.1.5:7005 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/tokenplatform.movie.com/peers/peer0.tokenplatform.movie.com/tls/ca.crt \
  --collections-config /vars/fabcar_collection_config.json \
  --cafile $ORDERER_TLS_CA --tls
