output "server" {
  description = "IP addresses to server"
  value = {
    ipv4 = hcloud_server.our_server.ipv4_address
    ipv6 = hcloud_server.our_server.ipv6_address
  }
}