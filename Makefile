DEFAULT_CONTAINER ?= debian-12
# https://github.com/sio/Makefile.venv
# Seamlessly manage Python virtual environment with a Makefile
Makefile.venv:
	curl \
		-o Makefile.fetched \
		-L "https://github.com/sio/Makefile.venv/raw/v2023.04.17/Makefile.venv"
	echo "fb48375ed1fd19e41e0cdcf51a4a0c6d1010dfe03b672ffc4c26a91878544f82 *Makefile.fetched" \
		| sha256sum --check - \
		&& mv Makefile.fetched Makefile.venv

include Makefile.venv

.PHONY: all
all: Makefile.venv $(VENV) install test

.PHONY: install
install: Makefile.venv $(VENV)
	$(VENV)/pip install -r requirements.txt

.PHONY: create
create:
	$(VENV)/molecule create

.PHONY: converge
converge:
	$(VENV)/molecule converge

.PHONY: login
login:
	$(VENV)/molecule login -h $(DEFAULT_CONTAINER)

.PHONY: test
test: install
	$(VENV)/molecule test

.PHONY: lint
lint: $(VENV) yamllint ansible-lint

.PHONY: yamllint
yamllint: install
	$(VENV)/yamllint .

.PHONY: ansible-lint
ansible-lint: install
	$(VENV)/ansible-lint .

.PHONY: destroy
destroy:
	$(VENV)/molecule destroy

.PHONY: release
VERSION?=minor
# target: release - Bump version
release:
	$(VENV)/pip install bumpversion
	@bumpversion $(VERSION)
	@git checkout master
	@git merge devel
	@git checkout devel
	@git push --all
	@git push --tags

.PHONY: minor
minor: release

.PHONY: patch
patch:
	make release VERSION=patch

.PHONY: major
major:
	make release VERSION=major
