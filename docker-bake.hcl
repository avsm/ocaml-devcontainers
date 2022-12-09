group "default" {
    targets = ["repo"]
}
target "ocaml_debs_4_14_0" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  args = { OCAML_VERSION="4.14.0" }
}
target "ocaml_debs_5_0_0" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  args = { OCAML_VERSION="5.0.0" }
}
target "ocaml_debs_5_1_0" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  args = { OCAML_VERSION="5.1.0" }
}
target "repo" {
  dockerfile = "Dockerfile.all"
  contexts = {
    debs_4_14_0 = "target:ocaml_debs_4_14_0"
    debs_5_0_0 = "target:ocaml_debs_5_0_0"
    debs_5_1_0 = "target:ocaml_debs_5_1_0"
  }
  tags = [ "ghcr.io/avsm/ocaml-devcontainers:debs" ]
}
