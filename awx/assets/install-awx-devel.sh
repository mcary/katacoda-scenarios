#!/bin/sh
#
# Install AWX using the docker-compose method, ideal for development.
# Unfortunately this runs out of disk space in Katacoda during the build
# (see error messages below).

set -xe

# Install prereqs:
time python3 -m pip install docker-compose
# Docker is already installed.
# Ansible is already installed.

# Download source for AWX
release=19.3.0 # https://github.com/ansible/awx/releases/
time git clone -b "$release" https://github.com/ansible/awx.git
cd awx
git checkout "$release" # Avoid leaving the git HEAD detached

# Configure to pull from quay.io rather than build from scratch?
sed -i.orig '/awx_image=/s/^# //' tools/docker-compose/inventory
git diff | cat # Avoid hanging on the pager (less)

# Build AWX
time make docker-compose-build

# Fails at:
#    => [stage-1 15/30] RUN ln -s /var/lib/awx/venv/awx/bin/awx-manage /usr/bin/awx-manage    41.6s
#    => [stage-1 16/30] COPY --from=quay.io/project-receptor/receptor:1.0.0a2 /usr/bin/recep  47.3s
#    => [stage-1 17/30] RUN openssl req -nodes -newkey rsa:2048 -keyout /etc/nginx/nginx.key  46.9s
#    => [stage-1 18/30] ADD tools/ansible/roles/dockerfile/files/rsyslog.conf /var/lib/awx/r  41.8s
#    => [stage-1 19/30] ADD tools/ansible/roles/dockerfile/files/wait-for-migrations /usr/lo  27.6s
#    => [stage-1 20/30] ADD tools/docker-compose/launch_awx.sh /usr/bin/launch_awx.sh         35.9s
#    => [stage-1 21/30] ADD tools/docker-compose/nginx.conf /etc/nginx/nginx.conf             34.9s
#    => [stage-1 22/30] ADD tools/docker-compose/nginx.vh.default.conf /etc/nginx/conf.d/ngi  33.1s
#    => ERROR [stage-1 23/30] ADD tools/docker-compose/start_tests.sh /start_tests.sh         30.6s
#   ------
#    > importing cache manifest from quay.io/awx/awx_devel:HEAD:
#   ------
#   ------
#    > [stage-1 23/30] ADD tools/docker-compose/start_tests.sh /start_tests.sh:
#   ------
#   failed to solve with frontend dockerfile.v0: failed to build LLB: failed to prepare ymh8fbgab0br0jsle0dxo0rhk: no space left on device
#   make: *** [Makefile:521: docker-compose-build] Error 1
#   Command exited with non-zero status 2
#   16.08user 7.17system 20:02.55elapsed 1%CPU (0avgtext+0avgdata 63760maxresident)k
#   197496inputs+6888outputs (2022major+195480minor)pagefaults 0swaps


# Start AWX
# "-d" means run in the background
time make docker-compose COMPOSE_UP_OPTS=-d

# Build UI
time docker exec tools_awx_1 make clean-ui ui-devel

# Load demo data
docker exec tools_awx_1 awx-manage create_preload_data
