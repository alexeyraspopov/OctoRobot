.PHONY: install-requirements start stop test

export PATH:=$(shell npm bin):$(PATH)
export NODE_ENV?=development
export NODE_PATH=$(shell npm root):app

install-requirements:
	npm install
