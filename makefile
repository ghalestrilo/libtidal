all:
	sh scripts/bootstrap.sh

config:
	python3 scripts/select_config.py

script:
	dotbot -d . -c 

i3unglitch:
	rm ~/.Xresources-regolith ~/.config/regolith/i3/config