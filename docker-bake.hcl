group "default" {
    targets = ["repo"]
}
target "ocaml-debs" {
  dockerfile = "Dockerfile.deb"
  platforms = [ "linux/arm64", "linux/amd64" ]
  output = [ "out" ]
}
#target "repo" {
#    dockerfile = "Dockerfile.repo"
#    contexts = {
#        debs = "target:ocaml-debs"
#    }
#}
