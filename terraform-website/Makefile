ENV?=dev
IMPORT?=
RESOURCE?=

init:
	rm -rf .terraform && terraform init -backend-config=vars/backend-${ENV}.tfvars -var-file=vars/${ENV}.tfvars

plan:
	terraform plan -var-file=vars/backend-${ENV}.tfvars -var-file=vars/${ENV}.tfvars

apply:
	terraform apply -var-file=vars/backend-${ENV}.tfvars -var-file=vars/${ENV}.tfvars

destroy:
	terraform delete -var-file=vars/backend-${ENV}.tfvars -var-file=vars/${ENV}.tfvars -target="${RESOURCE}"

import:
	terraform import -var-file=vars/backend-${ENV}.tfvars -var-file=vars/${ENV}.tfvars "${IMPORT}" "${RESOURCE}"