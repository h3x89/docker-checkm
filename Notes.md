## How to get into a docker container?
docker exec -it <mycontainer> bash

## How to make ssh tunnel open to public?
 ssh -o GatewayPorts=yes -L 6556:dc-node:6556 gateway



## Set default command
#CMD ["/usr/bin/bash"]
