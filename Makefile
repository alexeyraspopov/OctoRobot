.PHONY: start bundle clean lint

export PATH:=$(shell pwd)/node_modules/.bin:$(PATH)
export NODE_PATH:=node_modules:.

start: export NODE_ENV=development
start: clean
	exec http-server . -p 3000 &
	exec browserify -r react -r react-dom -o dist/vendor.js
	exec watchify -e index.web.js \
		-x react -x react-dom \
		-t [ babelify --sourceMapRelative . ] \
		-p browserify-hmr \
		-g envify \
		-o dist/bundle.js -dv

bundle: export NODE_ENV=production
bundle: clean
	exec browserify -r react -r react-dom \
		-g envify | exec uglifyjs --compress > dist/vendor.js
	exec browserify -e index.web.js \
		-x react -x react-dom \
		-t babelify \
		-g envify | exec uglifyjs --compress > dist/bundle.js

clean:
	rm -rf dist
	mkdir dist

lint:
	exec eslint -c .eslintrc ./
