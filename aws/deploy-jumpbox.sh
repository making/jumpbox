#!/bin/bash

export PUBLIC_IP=$(terraform output --json | jq -r '.external_ip.value')
export INTERNAL_CIDR=$(terraform output --json | jq -r '.internal_cidr.value')
export INTERNAL_GW=$(terraform output --json | jq -r '.internal_gw.value')
export INTERNALIP=$(terraform output --json | jq -r '.jumpbox_internal_ip.value')
export SECURITY_GROUP_NAME=$(terraform output --json | jq -r '.jumpbox_security_group.value')
export DEFAULT_SECURITY_GROUP=$(terraform output --json | jq -r '.jumpbox_security_group.value')
export REGION=$(terraform output --json | jq -r '.region.value')
export AVAILABILITY_ZONE=$(terraform output --json | jq -r '.az.value')
export SUBNET_ID=$(terraform output --json | jq -r '.subnet_id.value')
export VPC_ID=$(terraform output --json | jq -r '.vpc_id.value')
export ACCESS_KEY_ID=$(terraform output --json | jq -r '.jumpbox_iam_user_access_key.value')
export SECRET_ACCESS_KEY=$(terraform output --json | jq -r '.jumpbox_iam_user_secret_key.value')
export DEFAULT_KEY_NAME=$(terraform output --json | jq -r '.default_key_name.value')
export PRIVATE_KEY=$(terraform output --json | jq -r '.private_key.value')

export JUMPBOX_DEPLOYMENT=../jumpbox-deployment
export OPS_FILES=../ops-files


bosh create-env ${JUMPBOX_DEPLOYMENT}/jumpbox.yml \
  -o ${JUMPBOX_DEPLOYMENT}/aws/cpi.yml \
  --vars-store jumpbox-creds.yml \
  -l ../versions.yml \
  -v external_ip=${PUBLIC_IP} \
  -v az=${AVAILABILITY_ZONE} \
  -v subnet_id=${SUBNET_ID} \
  -v access_key_id=${ACCESS_KEY_ID} \
  -v secret_access_key=${SECRET_ACCESS_KEY} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups="[${DEFAULT_SECURITY_GROUP}]" \
  -v region=${REGION} \
  --var-file private_key=<(cat <<EOF
${PRIVATE_KEY}
EOF
) \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${INTERNALIP} \
  -o ${OPS_FILES}/openjdk.yml \
  -o ${OPS_FILES}/jq.yml \
  -o ${OPS_FILES}/mysql-client.yml \
  -o ${OPS_FILES}/psql.yml \
  -o ${OPS_FILES}/pre-start.yml \
  -o <(cat <<EOF
- type: replace
  path: /resource_pools/0/cloud_properties/instance_type
  value: t2.micro
- type: replace
  path: /resource_pools/0/cloud_properties/spot_bid_price?
  value: 0.0050
- type: replace
  path: /resource_pools/name=vms/cloud_properties/ephemeral_disk
  value: 
    size: 20_000
    type: standard
EOF) \
  --state jumpbox-state.json \
  $@