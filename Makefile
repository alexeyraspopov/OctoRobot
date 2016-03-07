export PATH:=$(shell npm bin):$(PATH)
export NODE_ENV:=development
export NODE_PATH:=node_modules:ClientApp

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	@npm install

start: client-app.pid ## Start dev env

stop: client-app.pid ## Stop dev env
	@pkill -TERM -P `cat $<` && rm $<
	@echo "The dev server has been stopped"

restart:
	make stop && make start

client-app.pid:
	@exec babel-node ClientApp/index.node.js & echo "$$!" > client-app.pid
	@echo "The dev server has been started"

test: ## Run all tests
	exec stylelint
	exec eslint --ignore-path .gitignore **/*.js
	exec nyc mocha
	exec protractor

build: export NODE_ENV=production
build: ## Bundle everything
	exec webpack

clean: ## Clean all temp files (*.pid)
	@rm -rf *.pid
