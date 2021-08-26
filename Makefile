TARGET_IMAGE="apicast/json_to_xml:latest"
# IP="http://localhost:8080"

build:
	docker build . --build-arg IMAGE=quay.io/3scale/rh-apicast:3scale-2.11-candidate -t $(TARGET_IMAGE)

debug:
	docker run -ti --rm $(TARGET_IMAGE) bash


test:
	docker run -ti -v $(PWD):/config \
		-e THREESCALE_CONFIG_FILE=/config/config.json \
		-e APICAST_BACKEND_CACHE_HANDLER=http://127.0.0.1:8081 \
		--name apicast-json-to-xml \
		--rm $(TARGET_IMAGE)

test-call:
	$(eval IP=$(shell docker inspect apicast-json-to-xml | jq -r ".[0].NetworkSettings.Networks | to_entries[0].value.IPAddress"))
	curl -H "Host: foo" "http://$(IP):8080/headers?user_key=foo"
