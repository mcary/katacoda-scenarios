#!/bin/sh
#
# This script is run as if pasted into the terminal, so no "-x" is needed
# to show the commands that were run.  Comments will be stripped.

while ! [ -f install-awx.sh ]; do echo -n .; sleep 1; done; echo
./install-awx.sh

# Create admin user for AWX
$ docker exec -ti tools_awx_1 awx-manage createsuperuser
