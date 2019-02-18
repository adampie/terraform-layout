ENV?=dev
MODULE?=MODULE_NOT_SPECIFIED
IMPORT?=
RESOURCE?=

DIRS = $(shell ls -d ${ENV}/*/)
WDIR = $(shell pwd)

initall:
	$(foreach DIR,$(DIRS),cd $(WDIR)/$(DIR) && rm -rf .terraform && terraform init -backend-config=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars;)

planall:
	$(foreach DIR,$(DIRS),cd $(WDIR)/$(DIR) && terraform plan -var-file=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars;)

applyall:
	$(foreach DIR,$(DIRS),cd $(WDIR)/$(DIR) && terraform apply -auto-approve -var-file=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars;)

init:
	cd ${TYPE}/${MODULE} && rm -rf .terraform && terraform init -backend-config=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars

plan:
	cd ${TYPE}/${MODULE} && terraform plan -var-file=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars

apply:
	cd ${TYPE}/${MODULE} && terraform apply -auto-approve -var-file=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars

import:
	cd ${TYPE}/${MODULE} && terraform import -var-file=../backend-${ENV}.tfvars -var-file=../${ENV}.tfvars "${IMPORT}" "${RESOURCE}"