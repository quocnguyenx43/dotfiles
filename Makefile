.PHONY: install clean

all: install

install:
	echo "Run setup script..." && \
		chmod +x ./setup.sh && \
		./setup.sh --no-os-setup
	@if [ -d ./.outputs ]; then \
		$(MAKE) -C ./.outputs install; \
	fi

install-os-setup:
	echo "Run setup script..." && \
		chmod +x ./setup.sh && \
		./setup.sh
	@if [ -d ./.outputs ]; then \
		$(MAKE) -C ./.outputs install; \
	fi

clean:
	@if [ -d ./.outputs ]; then \
		$(MAKE) -C ./.outputs clean; \
	fi
	echo "Run cleaning script..." && \
		chmod +x ./clean.sh && \
		./clean.sh
