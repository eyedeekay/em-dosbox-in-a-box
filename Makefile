
#include ../config.mk

do: clean create run

include ./include.mk

pull:
	git pull; true

install:
	docker pull eyedeekay/em-dosbox-in-a-box

create:
	docker create --tty \
		--name em-dosbox \
		$(MOUNT_PROGRAMS_FOLDER) \
		-p $(IP_ADDR):405:8080 \
		eyedeekay/em-dosbox-in-a-box

run:
	docker start em-dosbox

build:
	docker build -t eyedeekay/em-dosbox-in-a-box .

clean:
	docker rm -f em-dosbox; true

clobber: clean
	docker rmi -f eyedeekay/em-dosbox-in-a-box

log:
	docker logs em-dosbox-in-a-box


