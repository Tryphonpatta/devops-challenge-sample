terraform {
  required_providers {
	docker = {
		source = "kreuzwerker/docker"
		version = "~> 3.0.1"
	}
  }
}
provider "docker" {
  
}

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts"
  keep_locally = false
}

resource "docker_container" "jenkins" {
  name = "jenkins"
  image = docker_image.jenkins.image_id
  ports {
	internal = 8080
	external = 8080
  }
}