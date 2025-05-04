.PHONY: stow stow-del

all: stow

stow:
	echo "Run setting up script..." && cd ./scripts && ./setup.sh
	$(MAKE) -C MacOS
	$(MAKE) -C zsh
	$(MAKE) -C git
	$(MAKE) -C ssh
	$(MAKE) -C tmux
	$(MAKE) -C wezterm
	$(MAKE) -C curl
	$(MAKE) -C wget

stow-del:
	echo "Run setting up script..." && cd ./scripts && ./setup.sh
	$(MAKE) -C MacOS stow-del
	$(MAKE) -C zsh stow-del
	$(MAKE) -C git stow-del
	$(MAKE) -C ssh stow-del
	$(MAKE) -C tmux stow-del
	$(MAKE) -C wezterm stow-del
	$(MAKE) -C curl stow-del
	$(MAKE) -C wget stow-del

clean:
	rm -rf ./Linux
	rm -rf ./MacOS