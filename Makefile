export PATH:=$(shell npm bin):$(PATH)
export NODE_ENV:=development

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	@npm install

start: nodemon.pid ## Start dev env

stop: nodemon.pid ## Stop dev env
	@kill `cat $<` && rm $<
	@echo "The dev server has been stopped"

nodemon.pid:
	@exec nodemon & echo "$$!" > nodemon.pid

test: ## Run all tests
	exec stylelint
	exec eslint --ignore-path .gitignore **/*.js
	exec nyc mocha
	exec protractor

build: export NODE_ENV=production
build: ## Bundle everything
	exec webpack
