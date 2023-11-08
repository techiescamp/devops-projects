.PHONY: all service-discovery

pub_ip := $(shell curl -s ifconfig.io)
file := ./prometheus/prometheus.yml
file2 := ./prometheus/targets.json
local := 127.0.0.1

service-discovery:

	@echo "***************************************"
	@echo "****SERVICE DISCOVERY OF PUBLIC IP*****"
	@echo "*****PUBLIC IPADDRESS : $(pub_ip)******"
	@echo "******LOOPBACK ADDRESS : $(local)******"
	@sed -i "s/$(local)/$(pub_ip)/g" $(file)
	@echo "******UPDATED FILE prometheus.yml******"
	@cat "$(file)"
	@sed -i "s/$(local)/$(pub_ip)/g" $(file2)
	@echo "*******UPDATED FILE targets.json*******"
	@cat "$(file2)"
	@echo "***************************************"

rollback:

	@echo "***************************************"
	@echo "*****ROLLBACK OF SERVICE DISCOVERY*****"
	@echo "******PUBLIC IPADDRESS : $(pub_ip)*****"
	@echo "******LOOPBACK ASSRESS : $(local)******"
	@sed -i "s/$(pub_ip)/$(local)/g" $(file)
	@echo "******UPDATED FILE prometheus.yml******"
	@cat "$(file)"
	@sed -i "s/$(pub_ip)/$(local)/g" $(file2)
	@echo "*******UPDATED FILE targets.json*******"
	@cat "$(file2)"
	@echo "****************************************"

all: service-discovery

