up:
	docker-compose up -d
	while ! docker exec -ti cilium cilium status; do \
	  sleep 1s; \
	done
	-docker network create --ipv6 \
	  --subnet ::1/112 \
	  --driver cilium \
	  --ipam-driver cilium cilium-net
	docker run --net cilium-net \
	  -p 8080:8080 \
	  -l "app=opengrok" \
	  --name opengrok -d --rm \
	  -v ${HOME}/src:/src \
	  -v ${HOME}/opengrok_data:/data \
	  scue/docker-opengrok

sync:
	./repositories.sh

policy:
	cp opengrok.policy /var/run/cilium/
	cilium policy validate /var/run/cilium/opengrok.policy
	cilium policy import /var/run/cilium/opengrok.policy

down:
	docker-compose down
	docker rm -f opengrok
	docker network rm cilium-net

.PHONY: cilium
