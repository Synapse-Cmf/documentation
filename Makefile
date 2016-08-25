build: bin/gitbook
	bin/gitbook build
	mv _book/* docs
	rm -r _book

bin/gitbook: node_modules/.bin/gitbook
	mkdir -p bin
	ln -s ../node_modules/.bin/gitbook bin/gitbook

node_modules/.bin/gitbook:
	npm install
