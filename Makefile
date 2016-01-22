.PHONY: start bundle clean lint test

export PATH:=$(shell pwd)/node_modules/.bin:$(PATH)
export NODE_PATH:=node_modules:.

EXTERNAL=-x react -x react-dom -x react-router
CSS_MODULES=--extension=.css -p [ css-modulesify -o dist/styles.css \
			--after autoprefixer \
			--after postcss-import --postcss-import.path . \
			--after postcss-custom-properties ]

start: export NODE_ENV=development
start: clean
	exec browserify -r react -r react-dom -r react-router -o dist/vendor.js
	exec watchify -e index.web.js \
		$(EXTERNAL) \
		$(CSS_MODULES) \
		-t [ babelify --sourceMapRelative . ] \
		-p browserify-hmr \
		-g envify \
		-o dist/bundle.js -dv &
	exec livestyle -r . -p 3000

bundle: export NODE_ENV=production
bundle: clean
	exec browserify -r react -r react-dom -r react-router \
		-g envify | exec uglifyjs --compress --screw-ie8 --mangle > dist/vendor.js
	exec browserify -e index.web.js \
		$(EXTERNAL) \
		$(CSS_MODULES) \
		-t babelify \
		-g envify | exec uglifyjs --compress --screw-ie8 --mangle > dist/bundle.js
	exec cssnano dist/styles.css dist/styles.css

clean:
	rm -rf dist
	mkdir dist

lint:
	exec eslint -c .eslintrc ./

test: lint
	mocha --compilers js:babel/register **/__tests__/*.js
