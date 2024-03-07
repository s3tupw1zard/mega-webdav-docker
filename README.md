# MEGA-cmd webdav server inside docker

## Usage

To run this docker image as container simply do the following:

### Option a

Run this command using e.g. SSH:

```docker
docker run --name mega-webdav --restart always \
-p 4443:4443 -e SERVE_PATH="<Path to folder on your mega.nz cloud>" \
-v /etc/machine-id:/etc/machine-id:ro \
-v /opt/MEGAcmd/config:/root/.megaCmd --log-opt max-size=1g \
ghcr.io/s3tupw1zard/mega-webdav-docker:latest
```

What you can or should customize is explained in the docker-compose below.

### Option b

Use this docker-compose file

```docker-compose
version: '3.9'

name: mega-webdav
services:
    mega-webdav:
        image: ghcr.io/s3tupw1zard/mega-webdav-docker:latest
        container_name: mega-webdav
        restart: always
        ports:
            # HOST-Port:CONTAINER-Port
            - 4443:4443
        environment:
            # Example SERVE_PATH="SomeApp-Backup/"
            - SERVE_PATH=<Path to folder on your mega.nz cloud>
        volumes:
            - /etc/machine-id:/etc/machine-id:ro
            - /opt/MEGAcmd/config:/root/.megaCmd
        logging:
            options:
                max-size: 1g
```

Remember to change the config volume and port to your liking.

After this run the following replacing your login info for mega to login megacmd.
You need to run this with both options.

```docker
docker exec -it mega-webdav mega-login <username> <password>
```
