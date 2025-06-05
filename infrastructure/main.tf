locals {
  cloud_config = file("./cloud-config.yaml")
}

resource "hcloud_ssh_key" "server_public_key" {
  name = "server-ssh-key"
  public_key = file("./ed_id.pub")
}

# Link to server resource docs
# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server
resource "hcloud_server" "our_server" {
  name = "our-server"

  server_type = "cax21"
  image = "debian-12"

  user_data = local.cloud_config

  ssh_keys = [
    hcloud_ssh_key.server_public_key.id,
  ]
}

output "server" {
  description = "IP addresses to server"
  value = {
    ipv4 = hcloud_server.our_server.ipv4_address
    ipv6 = hcloud_server.our_server.ipv6_address
  }
}
