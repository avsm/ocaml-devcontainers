.PHONY: all depends buildx push debs

all:
	@.

depends:
	docker run --privileged --rm tonistiigi/binfmt --install all

buildx:
	docker buildx build --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:4.14 --pull .

push:
	docker buildx build --push --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:4.14 --pull .

debs:
	docker buildx build --push --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:4.14-debs -f Dockerfile.deb --pull .
	docker buildx build --push --platform linux/arm64,linux/amd64 --tag avsm/ocaml-devcontainer:debrepo -f Dockerfile.debrepo --pull .
