.PHONY: install os uninstall

SHELL := /usr/bin/env bash

all: install

install:
	chmod +x ./scripts/state.sh && . ./scripts/state.sh
	chmod +x ./scripts/stow.sh && ./scripts/stow.sh
	@if [ -d ./apps ]; then \
		$(MAKE) -C ./apps install; \
	fi

os:
	chmod +x ./scripts/os.sh && ./scripts/os.sh

uninstall:
	@if [ -d ./apps ]; then \
		$(MAKE) -C ./apps uninstall; \
	fi
	chmod +x ./scripts/clean.sh && ./scripts/clean.sh
