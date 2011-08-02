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

# Restarting riak
$INIT_RIAK restart

# Restarting walk-server
$INIT_WALK_SERVER restart
