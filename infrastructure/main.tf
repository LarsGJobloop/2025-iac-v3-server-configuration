resource "hcloud_ssh_key" "server_public_key" {
  name = "server-ssh-key"
  public_key = file("./ed_id.pub")
}

module "docker_server" {
  source = "./docker_server"

  ssh_keys = [
    hcloud_ssh_key.server_public_key.id,
  ]
}
