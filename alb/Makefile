help:		## Print Help Message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/clean //' | sed -e 's/##//'

clean:
	@rm -rf .terraform*

dev-apply:	clean ## Create VPC for DEV Env
	@terraform init -backend-config=env/dev-backend.tfvars -no-color
	@terraform apply -auto-approve -var-file=env/dev.tfvars -no-color

prod-apply:	clean ## Create VPC for PROD Env
	@terraform init -backend-config=env/prod-backend.tfvars -no-color
	@terraform apply -auto-approve -var-file=env/prod.tfvars -no-color

dev-destroy:	clean ## Delete VPC for DEV Env
	@terraform init -backend-config=env/dev-backend.tfvars -no-color
	@terraform destroy -auto-approve -var-file=env/dev.tfvars -no-color

prod-destroy:	clean ## Delete VPC for PROD Env
	@terraform init -backend-config=env/prod-backend.tfvars -no-color
	@terraform destroy -auto-approve -var-file=env/prod.tfvars -no-color