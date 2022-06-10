TAG=ddns-updater
BUILDER=$(TAG)-builder

build:
	docker build -t $(BUILDER) .

clean:
	docker rmi $(BUILDER)