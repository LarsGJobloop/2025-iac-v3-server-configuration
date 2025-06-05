locals {
  cloud_config = file("${path.module}/cloud-config.yaml")
}

# Link to server resource docs
# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server
resource "hcloud_server" "our_server" {
  name = "our-server"

  server_type = "cax21"
  image = "debian-12"

  user_data = local.cloud_config

  ssh_keys = var.ssh_keys
}
