TERRAFORM_DIR := terraform
ANSIBLE_DIR := ansible

tf-init:
	terraform -chdir=$(TERRAFORM_DIR) init

tf-apply:
	terraform -chdir=$(TERRAFORM_DIR) apply

tf-validate:
	terraform -chdir=$(TERRAFORM_DIR) validate

tf-destroy:
	terraform -chdir=$(TERRAFORM_DIR) destroy

ansible-install-deps:
	ansible-galaxy install -r $(ANSIBLE_DIR)/requirements.yml

ansible-setup: ansible-install-deps
	ansible-playbook $(ANSIBLE_DIR)/playbook.yml -i $(ANSIBLE_DIR)/inventory.ini -t setup --vault-password-file $(ANSIBLE_DIR)/group_vars/.vault-pass

ansible-deploy: ansible-install-deps
	ansible-playbook $(ANSIBLE_DIR)/playbook.yml -i $(ANSIBLE_DIR)/inventory.ini -t deploy --vault-password-file $(ANSIBLE_DIR)/group_vars/.vault-pass

ansible-datadog: ansible-install-deps
	ansible-playbook $(ANSIBLE_DIR)/playbook.yml -i $(ANSIBLE_DIR)/inventory.ini -t datadog --vault-password-file $(ANSIBLE_DIR)/group_vars/.vault-pass
