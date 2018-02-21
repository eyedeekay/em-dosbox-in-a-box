
do: build

run:
	docker pull eyedeekay/em-dosbox
	docker run -t em-dosbox

build:
	docker build -t em-dosbox .
	docker run -t em-dosbox
