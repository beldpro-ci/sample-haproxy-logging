IMAGE_NAME	:= 	"loadbalancer"
BRIDGE_GW 	:=	$(shell ./get-bridge-gateway.sh)


image:
	docker build \
		--tag $(IMAGE_NAME) \
		./image


run:
	docker run \
		--detach \
		--env CONTAINERS_ADDRESS=$(BRIDGE_GW) \
		$(IMAGE_NAME)


.PHONY: image run
