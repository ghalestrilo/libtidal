all:
	echo "not yet"

bootstrap:
	sh scripts/bootstrap.sh

config: bootstrap
	python3 scripts/select_config.py
