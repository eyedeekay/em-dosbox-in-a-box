
include config.mk

do: clean pull install run

pull:
	git pull; true

install:
	docker pull eyedeekay/em-dosbox

run:
	docker run -d -t -p 405:8080 $(MOUNT_PROGRAMS_FOLDER) --name em-dosbox eyedeekay/em-dosbox

build:
	docker build -t eyedeekay/em-dosbox .

clean:
	docker rm -f em-dosbox; true

clobber: clean
	docker rmi -f eyedeekay/em-dosbox

log:
	docker logs em-dosbox
