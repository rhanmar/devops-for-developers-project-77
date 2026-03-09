tf-init:
	terraform -chdir=terraform init

tf-apply:
	terraform -chdir=terraform apply

tf-validate:
	terraform -chdir=terraform validate

tf-destroy:
	terraform -chdir=terraform destroy
