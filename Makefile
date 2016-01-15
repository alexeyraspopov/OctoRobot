.PHONY: start clean lint

export PATH:=$(shell pwd)/node_modules/.bin:$(PATH)
export NODE_PATH:=node_modules:.

start: export NODE_ENV=development
start: clean
	mkdir dist
	exec http-server . -p 3000 &
	exec browserify -r react -r react-dom -o dist/vendor.js
	exec watchify -e index.web.js \
		-x react -x react-dom \
		-t [ babelify --sourceMapRelative . ] \
		-p browserify-hmr \
		-g envify \
		-o dist/bundle.js -dv

clean:
	rm -rf dist

lint:
	exec eslint -c .eslintrc ./
