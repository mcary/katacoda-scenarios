#!/bin/sh
#
# Install AWX using the AWX Operator method, hopefully faster than
# docker-compose method, which is for development and runs out of disk
# space in Katacoda

set -xe

# Ensure kubernetes is responding
while ! kubectl get nodes,pods -A; do
  echo "Communication failed, waiting a sec..."
  sleep 1
done

release=19.3.0 # https://github.com/ansible/awx/releases/
operator_release=0.13.0 # https://github.com/ansible/awx-operator/releases/
time kubectl apply -f https://raw.githubusercontent.com/ansible/awx-operator/"$operator_release"/deploy/awx-operator.yaml

time kubectl rollout status deployment/awx-operator

# Create a PV to meet the expectations of postgres, since we don't have any
# dynamic storage classes already setup, and awx-operator creates
# postgres's pvc with a "" storage class.
cat > awx-pv.yml <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-pv
  labels:
    type: local
spec:
  storageClassName: ""
  capacity:
    storage: 8Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/srv"
EOF

kubectl apply -f awx-pv.yml

cat > awx-demo.yml <<EOF
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx-demo
spec:
  service_type: NodePort
  ingress_type: none
  hostname: awx-demo.example.com
  # Reduce requirements by 75% to fit into 2CPU/4GB RAM with room for
  # other services to run.
  web_resource_requirements:
    requests:
      cpu: "0.75"
      memory: "1.5Gi"
  task_resource_requirements:
    requests:
      cpu: "0.384"
      memory: "0.75Gi"
  ee_resource_requirements:
    requests:
      cpu: "0.384"
      memory: "0.75Gi"
EOF

kubectl apply -f awx-demo.yml

echo For diagnostic info:
echo "    "kubectl logs -f deployments/awx-operator

time kubectl wait awx/awx-demo --for condition=running
while ! time kubectl rollout status deployment/awx-demo; do
  echo "Waiting for deployment to exist so we can wait for it to be ready"
  sleep 2
done

kubectl get pods,svc -l "app.kubernetes.io/managed-by=awx-operator"
