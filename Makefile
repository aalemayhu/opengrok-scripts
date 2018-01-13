cilium:
	cd cilium && docker-compose up

sync:
	./repositories.sh

policy:
	cp ./cilium/opengrok.policy /var/run/cilium/
	cilium policy validate /var/run/cilium/opengrok.policy
	cilium policy import /var/run/cilium/opengrok.policy

.PHONY: cilium
