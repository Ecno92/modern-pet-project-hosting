docker-machine-create-vultr-instance:
	docker-machine create \
		--driver vultr \
		$(DOCKER_MACHINE_NAME)

.PHONY:
	docker-machine-create-vultr-instance
