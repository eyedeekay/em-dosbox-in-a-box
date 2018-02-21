
do: build

run:
	docker pull eyedeekay/em-dosbox
	docker run -d -t --name em-dosbox em-dosbox

build:
	docker build -t em-dosbox .
	docker run -d -t --name em-dosbox em-dosbox

clean:
	docker rm -f em-dosbox; \
	docker rmi -f em-dosbox; \

log:
	docker logs -t em-dosbox
