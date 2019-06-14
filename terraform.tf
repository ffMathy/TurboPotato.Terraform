terraform {
  required_version = "~> 0.10.2"
}

# variable "stuff" {
# }

provider "docker" {
  host = "tcp://localhost:2375/"
}

resource "docker_network" "private_network" {
  name = "elk_network"
}

resource "docker_container" "elk_elasticsearch" {
  image = "${docker_image.elk_elasticsearch.name}"
  name = "elk_elasticsearch"
  env = ["discovery.type=single-node"]
  networks_advanced = {
    name = "elk_network"
    aliases = ["elk_network"]
  }
}

resource "docker_image" "elk_elasticsearch" {
  name = "elasticsearch:7.1.1"
}