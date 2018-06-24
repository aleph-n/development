
.init:
	@terraform init

create-plan: .init
	@terraform plan \
		-input=false \
		-var "region=$(AWS_REGION)" \
		-var "env=$(ENV)" \
		-var "main_dns_name=$(DNS_NAME)" \
		-var "key_name=$(KEY_NAME)" \
		-var "instance_type=$(INSTANCE_TYPE)" \
		-out=create-plan-$(AWS_REGION)-$(ENV).tfplan


create-infra: create-plan-$(AWS_REGION)-$(ENV).tfplan
	@terraform apply \
    	-input=false \
		create-plan-$(AWS_REGION)-$(ENV).tfplan

delete-infra:
	@terraform destroy \
		-input=false \
		-var "region=$(AWS_REGION)" \
		-var "env=$(ENV)" \
		-var "main_dns_name=$(DNS_NAME)" \
		-var "key_name=$(KEY_NAME)" \
		-var "instance_type=$(INSTANCE_TYPE)"
