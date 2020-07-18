all:
	echo "not yet"

bootstrap:
	sh scripts/bootstrap.sh > /dev/null

config: bootstrap
	python3 scripts/select_config.py

i3unglitch:
	rm ~/.Xresources-regolith ~/.config/regolith/i3/config