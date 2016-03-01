export PATH:=$(shell npm bin):$(PATH)
export NODE_ENV:=development

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	@npm install

start: client-app.pid ## Start dev env

	@kill `cat $<` && rm $<
stop: client-app.pid ## Stop dev env
	@echo "The dev server has been stopped"

client-app.pid:
	@exec babel-node ClientApp/index.node.dev.js & echo "$$!" > client-app.pid
	@echo "The dev server has been started"

test: ## Run all tests
	exec stylelint
	exec eslint --ignore-path .gitignore **/*.js
	exec nyc mocha
	exec protractor

build: export NODE_ENV=production
build: ## Bundle everything
	exec webpack
