#!/bin/bash
cd $FABRIC_CFG_PATH
# cryptogen generate --config crypto-config.yaml --output keyfiles
configtxgen -profile OrdererGenesis -outputBlock genesis.block -channelID systemchannel

configtxgen -printOrg cbfc-movie-com > JoinRequest_cbfc-movie-com.json
configtxgen -printOrg inox-movie-com > JoinRequest_inox-movie-com.json
configtxgen -printOrg pvr-movie-com > JoinRequest_pvr-movie-com.json
configtxgen -printOrg tokenplatform-movie-com > JoinRequest_tokenplatform-movie-com.json
