# Show this help message
# Multiple lines are supported too
# When it's first, both commands works:
# `make`
# `make help`
.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -v 'PHONY' | docker run --rm -i xanders/make-help

# Build Docker image
build:
	docker build -t xanders/make-help .

# Run `build` and `help` successively
.PHONY: test
test: build help

##
## Section for authorized contributors
##

# Push image to `https://hub.docker.com`
push:
	docker push xanders/make-help
