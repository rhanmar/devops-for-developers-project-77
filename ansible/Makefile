check: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t check --vault-password-file ./group_vars/.vault-pass

setup: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t setup --vault-password-file ./group_vars/.vault-pass

install-deps:
	ansible-galaxy install -r requirements.yml

edit-vault-all:
	EDITOR=nano ansible-vault edit group_vars/webservers/vault.yml --vault-password-file ./group_vars/.vault-pass

deploy: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t deploy --vault-password-file ./group_vars/.vault-pass

datadog: install-deps
	ansible-playbook playbook.yml -i inventory.ini -t datadog --vault-password-file ./group_vars/.vault-pass

run-local:
	docker run --env-file .env redmine
