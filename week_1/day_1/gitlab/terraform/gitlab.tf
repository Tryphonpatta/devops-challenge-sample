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

resource "docker_image" "gitlab" {
  name = "gitlab/gitlab-ce:latest"
  keep_locally = false
}

resource "docker_container" "gitlab" {
  name = "gitlab"
  image = docker_image.gitlab.image_id
  env = [
    "GITLAB_OMNIBUS_CONFIG=external_url 'http://localhost'; gitlab_rails['gitlab_shell_ssh_port']=2424;"
  ]
  ports {
	internal = 80
	external = 80
  }
  ports {
	internal = 443
	external = 443
  }
  ports {
	internal = 22
	external = 2424
  }
  ports {
	internal = 8929
	external = 8929
  }
#   volumes {
# 	host_path = "/srv/gitlab/config"
# 	container_path = "/etc/gitlab"
#   }
#   volumes {
# 	host_path = "/srv/gitlab/logs"
# 	container_path = "/var/log/gitlab"
#   }
}