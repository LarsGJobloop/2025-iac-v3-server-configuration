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
