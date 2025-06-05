## Concepets

### Cloud Server Configurations

- [ ] SSH
- [ ] Package Manager
- [ ] Cloud Init

## Commands

- Generate a default SSH Key

    ```sh
    ssh-keygen -t ed25519 -f ed_id
    ```
- Log on to the server

    ```sh
    ssh -i ed_id root@157.180.124.210
    ```
- Exit ssh

    ```sh
    exit
    ```

## Example prompt for help setting up a new cloud config

````
could you give me simple cloud config yaml for a debian-12 docker server?
```

## Module inspiration

Here is an example of how a module might look. It's a higher level abstraction where you wrap a bundle of resources into a compose application. Allowing future you (or others) to quickly create new instances of a Compose Application. Some more names to inspire usages and thinking about abstractions (you might find that some of these already exists and can be used by you in projects):

- `dotnet_application`
- `postgresql`
- `discord_bot`
- `kubernetes_cluster`
- `canvas`
- `nextcloud` # Private cloud suite 

```tf
module "compose_application" {
    # Metadata
    name = "your-name"

    # Hardware Configuration
    server_type = "small-server"
    location = "europe"

    # Reconciliation Configuration
    source_repository = "https://github.com/${USER_NAME}/${REPOSITORY}"
    target_branch = "production"
    compose_path = "manifests/compose.production"
    synchronization_interval = "30sec"

    # Debugging, TODO! Remove once done developing
    ssh_keys = [
       hcloud_ssh_keys.maintenance_key.id
    ]
}

output "application_address" {
    description = "IP addresses for the compose application"
    value = {
        ipv4 = module.compose_application.ipv4_address
        ipv6 = module.compose_application.ipv6_address
    }
}
```