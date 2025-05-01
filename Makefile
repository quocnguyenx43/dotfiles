.PHONY: stow stow-del

all: stow

stow:
	cd ./scripts && ./setup.sh
	$(MAKE) -C MacOS
	$(MAKE) -C zsh
	$(MAKE) -C git
	$(MAKE) -C ssh
	$(MAKE) -C tmux
	$(MAKE) -C wezterm

stow-del:
	cd ./scripts && ./setup.sh
	$(MAKE) -C MacOS stow-del
	$(MAKE) -C zsh stow-del
	$(MAKE) -C git stow-del
	$(MAKE) -C ssh stow-del
	$(MAKE) -C tmux stow-del
	$(MAKE) -C wezterm stow-del