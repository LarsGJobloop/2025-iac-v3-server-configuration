## Major Terraform Parts

- [Resources](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources): What is managed
- [Variables](https://developer.hashicorp.com/terraform/language/values): The data you don't want to version control, but is still required. Also for modules to enable compositions
- [Outputs](https://developer.hashicorp.com/terraform/language/values): The data that you need for further automation.
- [Providers](https://developer.hashicorp.com/terraform/language/providers): Datacenters and SaaS providers, misc functionality. All 3rd party dependencies.
- [Registries](https://registry.terraform.io/): Where 3rd party modules can be sourced from.

## Concepts

### Cloud Server Configurations

These are at their core rather simple, though they can quickly scale into very complex terrain. Learn the core, and use LLMs for the rest.

- [SSH](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)
  - How to connect to a remote server using **keys** and **IP addresses**
- [Package Manager](https://www.onyxgs.com/blog/introduction-package-managers)
  - **Find** packages, **install** packages and **remove** packages
- [Cloud Init](https://cloudinit.readthedocs.io/en/latest/tutorial/index.html)
  - **Have a server use the config**, explore option on demand. Use LLMs to discover hardening necessities

## Commands

> [!IMPORTANT]
> SSH-Keys (and other crypto identities) are potentially very hard to change if leaked. You can use ephemeral keys here, lessening the issue.
>
> But to build good habits, keep them somwhere safe (Private Key Managers, Cloud Vaults) and be mindeful of what they have access to. For important enough keys consider physical copies in safe deposit boxes as backups (no I am not joking).

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

## Example prompts

- Get some baseline `cloud-config.yaml` that you can start iterating on:
    ```
    could you give me simple cloud config yaml for a debian-12 docker server?
    ```
- Hardening advice:
    ```
    On a standard Debian server instantiated through Terraform and Cloud Init, what are hardening options that should be implemented, considered to be implemented, and might be overkill to implement.

    The context is for hosting an ASP .NET Core API, which auto syncs from a Git repository using a Pull approach.
    ```
    Follow up:
    ```
    Are there other things besides security concerns I might want to research?
    ```
- Hands-off server:
    ```
    I heard that some practice a full automation setup of servers, GitOps. If I want to create a Terraform module for a Docker Compose Application what would be required for this? Say on Hetzner.
    ```
- Persistence in face of ephemeral:
    ```
    I have setup a Docker Compose Application IaC module using Terraform and auto syncing with a Git repository, all deployed to Hetzner, which works great. But now I want to persist data across reboots and server creation. What are my options?
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