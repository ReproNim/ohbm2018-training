#!/bin/bash

echo 'Wait for Docker to set up ip ports on host '
DOCKER_HOST_IP=`ip addr show docker0 | grep -P 'inet [\d\.]+' -o | grep -P '[\d\.]+' -o`
until [ ! -z "$DOCKER_HOST_IP" ]; do
    printf '.'
    sleep 5
    DOCKER_HOST_IP=`ip addr show docker0 | grep -P 'inet [\d\.]+' -o | grep -P '[\d\.]+' -o`
done

sed -e 's/INSERT_HOST_INTERNAL_IP_HERE/'"$DOCKER_HOST_IP"'/g' \
    /home/ubuntu/.config/nitrcce/guacamole/sql/initdb.template \
    > /home/ubuntu/.config/nitrcce/guacamole/sql/initdb.sql

chown ubuntu.ubuntu /home/ubuntu/.config/nitrcce/guacamole/sql/initdb.sql

su - ubuntu -c "cd /home/ubuntu/.config/nitrcce/guacamole; docker-compose up -d"
su - ubuntu -c "vncserver :1"
