#!/bin/bash
# Script to approve chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=192.168.1.5:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/cbfc.movie.com/peers/peer0.cbfc.movie.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=cbfc-movie-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/cbfc.movie.com/users/Admin@cbfc.movie.com/msp
export ORDERER_ADDRESS=192.168.1.5:7012
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/orderer/orderers/orderer1.orderer/tls/ca.crt

peer lifecycle chaincode queryinstalled -O json | jq -r '.installed_chaincodes | .[] | select(.package_id|startswith("fabcar_1.0:"))' > ccstatus.json

PKID=$(jq '.package_id' ccstatus.json | xargs)
REF=$(jq '.references.mychannel' ccstatus.json)

SID=$(peer lifecycle chaincode querycommitted -C mychannel -O json \
  | jq -r '.chaincode_definitions|.[]|select(.name=="fabcar")|.sequence' || true)
if [[ -z $SID ]]; then
  SEQUENCE=1
elif [[ -z $REF ]]; then
  SEQUENCE=$SID
else
  SEQUENCE=$((1+$SID))
fi


export CORE_PEER_LOCALMSPID=cbfc-movie-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/cbfc.movie.com/peers/peer0.cbfc.movie.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/cbfc.movie.com/users/Admin@cbfc.movie.com/msp
export CORE_PEER_ADDRESS=192.168.1.5:7004

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name fabcar --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.cbfc-movie-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name fabcar \
    --version 1.0 --package-id $PKID \
    --collections-config /vars/fabcar_collection_config.json \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=inox-movie-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/inox.movie.com/peers/peer0.inox.movie.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/inox.movie.com/users/Admin@inox.movie.com/msp
export CORE_PEER_ADDRESS=192.168.1.5:7006

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name fabcar --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.inox-movie-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name fabcar \
    --version 1.0 --package-id $PKID \
    --collections-config /vars/fabcar_collection_config.json \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=pvr-movie-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/pvr.movie.com/peers/peer0.pvr.movie.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/pvr.movie.com/users/Admin@pvr.movie.com/msp
export CORE_PEER_ADDRESS=192.168.1.5:7007

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name fabcar --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.pvr-movie-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name fabcar \
    --version 1.0 --package-id $PKID \
    --collections-config /vars/fabcar_collection_config.json \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=tokenplatform-movie-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/tokenplatform.movie.com/peers/peer0.tokenplatform.movie.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/tokenplatform.movie.com/users/Admin@tokenplatform.movie.com/msp
export CORE_PEER_ADDRESS=192.168.1.5:7005

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name fabcar --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.tokenplatform-movie-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name fabcar \
    --version 1.0 --package-id $PKID \
    --collections-config /vars/fabcar_collection_config.json \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi
