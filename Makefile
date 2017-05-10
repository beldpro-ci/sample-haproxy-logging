IMAGE_NAME	:= 	"loadbalancer"
BRIDGE_GW 	:=	$(shell ./get-bridge-gateway.sh)

image:
	docker build \
		--tag $(IMAGE_NAME) \
		./image

run:
	CONTAINERS_ADDRESS=$(BRIDGE_GW) docker-compose up


.PHONY: image run
