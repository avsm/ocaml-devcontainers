.PHONY: all depends buildx

all:
	@.

depends:
	docker run --privileged --rm tonistiigi/binfmt --install all

buildx:
	docker buildx build --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:4.14 --pull .

push:
	docker buildx build --push --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:4.14 --pull .
