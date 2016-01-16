.PHONY: start bundle clean lint

export PATH:=$(shell pwd)/node_modules/.bin:$(PATH)
export NODE_PATH:=node_modules:.

EXTERNAL=-x react -x react-dom
CSS_MODULES=--extension=.css -p [ css-modulesify -o dist/styles.css \
			--after autoprefixer \
			--after postcss-custom-properties ]

start: export NODE_ENV=development
start: clean
	exec livestyle -r . -p 3000 &
	exec browserify -r react -r react-dom -o dist/vendor.js
	exec watchify -e index.web.js \
		$(EXTERNAL) \
		$(CSS_MODULES) \
		-t [ babelify --sourceMapRelative . ] \
		-p browserify-hmr \
		-g envify \
		-o dist/bundle.js -dv

bundle: export NODE_ENV=production
bundle: clean
	exec browserify -r react -r react-dom \
		-g envify | exec uglifyjs --compress > dist/vendor.js
	exec browserify -e index.web.js \
		$(EXTERNAL) \
		$(CSS_MODULES) \
		-t babelify \
		-g envify | exec uglifyjs --compress > dist/bundle.js
	exec cssnano dist/styles.css dist/styles.css

clean:
	rm -rf dist
	mkdir dist

lint:
	exec eslint -c .eslintrc ./
