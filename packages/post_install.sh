#! /bin/bash

INIT_WALK_SERVER=/etc/init.d/walk-server
INIT_RIAK=/etc/init.d/riak

# Copy stud
cp /usr/local/bin/walk-server $INIT_WALK_SERVER
chmod a+x $INIT_WALK_SERVER

# Schedule stud service
insserv $INIT_WALK_SERVER
echo "Schedule walk-server service"

# Schedule riak service
insserv $INIT_RIAK
echo "Schedule riak service"

# Configuring limits
if [ -e /etc/security/limits.d ]
then
  echo "riak    hard    nofile  999999\nriak    soft    nofile  999999" > /etc/security/limits.d/riak.conf
fi

# Restarting riak
$INIT_RIAK restart

# Restarting walk-server
$INIT_WALK_SERVER restart


