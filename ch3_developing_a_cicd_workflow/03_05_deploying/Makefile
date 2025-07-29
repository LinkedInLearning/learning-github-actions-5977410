API    = mascot
SCOPE  = user99
TAG    = $(shell echo "$$(date +%F)-$$(git rev-parse --short HEAD)")

help:
	@echo "Run make <target> where target is one of the following..."
	@echo
	@echo "    requirements - install required libraries"
	@echo "    development-requirements - install development libraries"
	@echo "    lint         - run flake8 and pylint"
	@echo "    unittest     - run unittests"
	@echo "    build        - build docker container"
	@echo "    run          - run containter on host port 8080"
	@echo "    logs 	    - show logs of the running container"
	@echo "    stop		    - stop local container"
	@echo "    clean        - stop local container, clean up workspace"

all: development-requirements lint unittest build

requirements:
	pip install --upgrade --requirement requirements.txt

development-requirements: requirements
	pip install --upgrade --requirement development-requirements.txt

lint:
	flake8 --ignore=E501,E231 *.py
	pylint --errors-only --disable=C0301 *.py

unittest:
	python -m unittest --verbose --failfast

build: pip lint unittest
	docker build -t $(SCOPE)/$(API):$(TAG) .

run: build
	docker run --rm -d -p 8080:8080 --name $(API) $(SCOPE)/$(API):$(TAG)

logs:
	docker logs -f $(API) || true

stop:
	docker container stop $(API) || true

clean:
	docker container stop $(API) || true
	@rm -rf ./__pycache__ ./tests/__pycache__
	@rm -f .*~ *.pyc

.PHONY: build clean deploy help interactive lint pip run test unittest upload
