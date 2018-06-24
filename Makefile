include .env-${ENV}
export $(shell sed 's/=.*//' .env-${ENV})


plan-infra:
	$(MAKE) --directory terraform/ create-plan

create-infra:
	$(MAKE) --directory terraform/ create-infra

delete-infra:
	$(MAKE) --directory terraform/ delete-infra

provision-instance:
	./create_inventory.sh
	ansible-playbook -i ./ansible/hosts ./ansible/provision-docker.yml \
	-e "ssh_repo=${SSH_GIT_REPO} proyect_env_file=${PROYECT_ENV_FILE} ssh_rute_file=${SSH_GIT_KEY} git_branch=${GIT_BRANCH} proyect_env=${PROYECT_ENV}"
