#!/bin/sh
#
# This script is run as if pasted into the terminal, so no "-x" is needed
# to show the commands that were run.  Comments will be stripped.

while ! [ -f install-awx.sh ]; do echo -n .; sleep 1; done; echo
time ./install-awx.sh

nodePort="$(kubectl get service awx-demo-service -o custom-columns=nodePort:.spec.ports[0].nodePort --no-headers)"

password="$(kubectl get secret awx-demo-admin-password -o jsonpath="{.data.password}" | base64 --decode)"

cat <<EOF

Use the awx-demo-service's nodePort to access AWX:

  https://[[HOST_SUBDOMAIN]]-$nodePort-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]/
  User: admin
  Password: $password

Be careful to open it in a _new_ tab, else your environment will end.
EOF
