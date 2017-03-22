all: header library

header:
	cc -shared -fPIC -o header.so header.c

library:
	crystal build --single-module --link-flags="-shared" -o mandel.so mandel.cr

run:
	crystal main.cr
