
#include ../config.mk

include ./include.mk

do: clean install create run

pull:
	git pull; true

install:
	docker pull eyedeekay/em-dosbox-in-a-box

create:
	docker create --name em-dosbox $(MOUNT_PROGRAMS_FOLDER) eyedeekay/em-dosbox-in-a-box

run:
	docker run -d -t \
		-p 0.0.0.0:405:8080 \
		--name em-dosbox \
		eyedeekay/em-dosbox-in-a-box

build:
	docker build -t eyedeekay/em-dosbox-in-a-box .

clean:
	docker rm -f em-dosbox; true

clobber: clean
	docker rmi -f eyedeekay/em-dosbox-in-a-box

log:
	docker logs em-dosbox-in-a-box


