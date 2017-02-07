build: bin/gitbook
	bin/gitbook build
	rm -rf docs/*
	mv _book/* docs
	rm -r _book
	rm -rf docs/**/*.md

bin/gitbook: node_modules/.bin/gitbook
	mkdir -p bin
	ln -s ../node_modules/.bin/gitbook bin/gitbook

node_modules/.bin/gitbook:
	npm install
