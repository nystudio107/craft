# Determine the docker compose API version to get the separator character
VERSION?=$(shell docker-compose -v)
ifneq (,$(findstring v2.,$(VERSION)))
	SEPARATOR:=-
else
	SEPARATOR:=_
endif
CONTAINER?=$(shell basename $(CURDIR))$(SEPARATOR)php$(SEPARATOR)1
BUILDCHAIN?=$(shell basename $(CURDIR))$(SEPARATOR)vite$(SEPARATOR)1

.PHONY: build clean composer craft dev npm pulldb restoredb nuke ssh up

build: up
	docker exec -it $(BUILDCHAIN) npm run build
clean:
	rm -f cms/composer.lock
	rm -rf cms/vendor/
	rm -f buildchain/package-lock.json
	rm -rf buildchain/node_modules/
composer: up
	docker exec -it $(CONTAINER) su-exec www-data composer \
		$(filter-out $@,$(MAKECMDGOALS))
craft: up
	docker exec -it $(CONTAINER) su-exec www-data php craft \
		$(filter-out $@,$(MAKECMDGOALS))
dev: up
npm: up
	docker exec -it $(BUILDCHAIN) npm \
		$(filter-out $@,$(MAKECMDGOALS))
pulldb: up
	cd scripts/ && ./docker_pull_db.sh
restoredb: up
	cd scripts/ && ./docker_restore_db.sh \
		$(filter-out $@,$(MAKECMDGOALS))
nuke: clean
	docker-compose down -v
	docker-compose up --build --force-recreate
ssh:
	docker exec -it $(CONTAINER) su-exec www-data /bin/sh
up:
	if [ ! "$$(docker ps -q -f name=$(CONTAINER))" ]; then \
		cp -n cms/example.env cms/.env; \
		docker-compose up; \
    fi
%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
