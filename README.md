# Create SSL
### cd ssl & bash create.sh

# Deploy Docker image
## From Main Directory
### docker-compose up

# Setup admin
### docker exec -it elasticsearch-node1 /bin/bash
### bash kickstart.sh
### exit
### docker exec -it elasticsearch-node2 /bin/bash
### bash kickstart.sh
### exit

Access Kibana at https://IPADDRESS:5601

