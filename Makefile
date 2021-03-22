CONTAINER?=$(shell basename $(CURDIR))_php_1

.PHONY: build dev pulldb restoredb up

build: up
	cd scripts/ && ./docker_prod_build.sh
dev: up
pulldb: up
	cd scripts/ && ./docker_pull_db.sh
restoredb: up
	cd scripts/ && ./docker_restore_db.sh \
		$(filter-out $@,$(MAKECMDGOALS))
up:
	if [ ! "$$(docker ps -q -f name=$${CONTAINER})" ]; then \
        docker-compose up; \
    fi
%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
