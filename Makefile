.PHONY: install os uninstall

all: install

install:
	echo "Setting up..." && \
		chmod +x ./scripts/state.sh && ./scripts/state.sh && \
		chmod +x ./scripts/stow.sh && ./scripts/stow.sh
	@if [ -d ./apps ]; then \
		$(MAKE) -C ./apps install; \
	fi

os:
	echo "OS setting up..." && \
		chmod +x ./scripts/os.sh && ./scripts/os.sh

uninstall:
	@if [ -d ./apps ]; then \
		$(MAKE) -C ./apps uninstall; \
	fi
	echo "Cleaning up..." && \
		chmod +x ./scripts/clean.sh && ./scripts/clean.sh
