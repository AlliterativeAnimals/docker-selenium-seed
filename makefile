SHELL=/bin/bash

require-docker-compose:
	@echo -n "Checking for docker-compose..."; \
    if hash docker-compose 2>/dev/null; \
    then \
        echo "OK"; \
    else \
        echo "ERR"; \
        echo "    docker-compose is used to start up the selenium application."; \
        echo "    please install docker-compose. Instructions are here:"; \
        echo "    http://docs.docker.com/compose/install/#install-compose"; \
        exit 1; \
    fi;

require-docker:
	@echo -n "Checking for docker..."; \
    if hash docker 2>/dev/null; \
    then \
        echo "OK"; \
    else \
        echo "ERR"; \
        echo "    docker is used to compartmentalise the selenium application"; \
        echo "    please install docker. Instructions are here:"; \
        echo "    http://docs.docker.com/compose/install/#install-docker"; \
        exit 1; \
    fi;

selenium-start: require-docker require-docker-compose
	@echo -n "Starting application..."; \
    if docker-compose up -d --no-recreate >/dev/null 2>&1; \
    then \
        echo "OK"; \
    else \
        echo "ERR"; \
        echo "    Could not start application."; \
        echo "    try 'docker-compose up -d --no-recreate' to debug."; \
        exit 1; \
    fi;

selenium-stop: require-docker require-docker-compose
	@echo -n "Stopping application..."; \
    if docker-compose stop >/dev/null 2>&1; \
    then \
        echo "OK"; \
    else \
        echo "ERR"; \
        echo "    Could not stop application."; \
        echo "    try 'docker compose stop' to debug."; \
        exit 1; \
    fi;

selenium-clean: require-docker require-docker-compose stop
	@echo -n "Cleaning application..."; \
    if docker-compose rm -f >/dev/null 2>&1; \
    then \
        echo "OK"; \
    else \
        echo "ERR"; \
        echo "    Could not clean application images."; \
        echo "    try 'docker-compose rm -f' to debug."; \
        exit 1; \
    fi;

start: selenium-start

stop: selenium-stop

clean: selenium-clean
