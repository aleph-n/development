#!/bin/bash
export CURRENT_DIR=$(pwd)
cd ./terraform/
export DNS_NAME=$(terraform output instance_dns)
cd $CURRENT_DIR

envsubst < ./ansible/hosts.template > ./ansible/hosts
