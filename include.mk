
config:
	cp config.mk ../config.mk
	sed -i 's|#include ../config.mk|include ../config.mk|g' Makefile
	git commit -am "include config"
