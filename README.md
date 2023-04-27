# fabric-movie-platform
Blockchain based movie platform on Hyperledger Fabric

## Prereq Before Running the Project:

1. Ensure all the binaries and docker images are already present in the system. This project is requires fabric binaries of version 2.4. Following are the fabric binaries which needs to be pulled.
    i. `hyperledger/fabric-tools:2.4`
    ii. `hyperledger/fabric-peer:2.4`
    iii. `hyperledger/fabric-orderer:2.4`
    iv. `hyperledger/fabric-ccenv:2.4`
    v. `hyperledger/fabric-baseos:2.4`
    
2. Ensure npm and node are installed in the system.
3. Ensure golang with version >=19 is installed in the system.
4. After this just run `deploy.sh`
5. After successfull installation goto `api-node` and do `npm install`
6. After successfull installation of the node modules run `enrollAdmin.js` and `registerUser.js`
7. After successfull registration run `invoke.js`

##
