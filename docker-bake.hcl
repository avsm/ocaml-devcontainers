group "default" {
    targets = ["repo"]
}
target "ocaml-debs-4_14_0" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  args = { OCAML_VERSION="4.14.0" }
}
target "ocaml-debs-5_0_0" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  args = { OCAML_VERSION="5.0.0" }
}
target "repo" {
  dockerfile = "Dockerfile.allrepo"
  contexts = {
    debs_4_14_0 = "target:ocaml-debs_4_14_0"
    debs_5_0_0 = "target:ocaml-debs_5_0_0"
  }
  tags = [ "ghcr.io/avsm/ocaml-devcontainers:debs" ]
}
