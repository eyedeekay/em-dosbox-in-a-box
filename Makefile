
#include ../config.mk

do: clean pull install run

pull:
	git pull; true

install:
	docker pull eyedeekay/em-dosbox-in-a-box

run:
	docker run -d -t -p 405:8080 $(MOUNT_PROGRAMS_FOLDER) --name em-dosbox eyedeekay/em-dosbox-in-a-box

build:
	docker build -t eyedeekay/em-dosbox-in-a-box .

clean:
	docker rm -f em-dosbox; true

clobber: clean
	docker rmi -f eyedeekay/em-dosbox-in-a-box

log:
	docker logs em-dosbox-in-a-box

config:
	cp config.mk ../config.mk
	sed -i 's|#include|include|g' Makefile
	git commit -am "include config"
