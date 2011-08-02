#! /bin/bash

/etc/init.d/riak stop

/etc/init.d/walk-server stop

# Remove schedule stud service
insserv /etc/init.d/walk-server --remove
echo "Remove schedule walk-server service"

# Remove schedule riak service
insserv /etc/init.d/riak --remove
echo "Remove schedule riak service"
