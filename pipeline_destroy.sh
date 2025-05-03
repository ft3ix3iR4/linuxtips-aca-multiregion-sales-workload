#!/bin/bash

set -e

echo "DESTROY DO POST-DEPLOYMENT"

cd post-deployment/

rm -rf .terraform
terraform init -backend-config=environment/backend.tfvars
terraform destroy --auto-approve -var-file=environment/terraform.tfvars

echo "DESTROY DO DEPLOYMENT SA-EAST-1"

cd ../
cd deployment/

rm -rf .terraform
terraform init -backend-config=environment/sa-east-1/backend.tfvars
terraform destroy --auto-approve -var-file=environment/sa-east-1/terraform.tfvars

echo "DESTROY DO DEPLOYMENT US-EAST-1"

cd ../
cd deployment/

rm -rf .terraform
terraform init -backend-config=environment/us-east-1/backend.tfvars
terraform destroy --auto-approve -var-file=environment/us-east-1/terraform.tfvars

echo "DESTROY DO PRE-DEPLOYMENT"

cd ../
cd pre-deployment/

rm -rf .terraform
terraform init -backend-config=environment/backend.tfvars
terraform destroy --auto-approve -var-file=environment/terraform.tfvars

echo "DESTROY FINALIZADO"