check: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t check --vault-password-file ./group_vars/.vault-pass

setup: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t setup --vault-password-file ./group_vars/.vault-pass

install-deps:
	ansible-galaxy install -r requirements.yml

vault-edit:
	EDITOR=nano ansible-vault edit group_vars/all/vault.yml --vault-password-file ./group_vars/.vault-pass

vault-encrypt:
	ansible-vault encrypt group_vars/all/vault.yml --vault-pass-file ./group_vars/.vault-pass

vault-decrypt:
	ansible-vault decrypt group_vars/all/vault.yml --vault-pass-file ./group_vars/.vault-pass

deploy: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t deploy --vault-password-file ./group_vars/.vault-pass

datadog: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t datadog --vault-password-file ./group_vars/.vault-pass

run-local:
	docker run --env-file .env redmine

terraform-generate-config:
	ansible-playbook playbook.yml -t tf --vault-password-file ./group_vars/.vault-pass
# 	ansible-playbook playbook.yml -t tf
# 	ansible-playbook playbook.yml -t tf --ask-vault-pass
