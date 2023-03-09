## Create nextcloudpi docker container
```sh
docker run -d --restart always -p 4443:4443 -p 443:443 -p 80:80 -v ncdata:/data --name nextcloudpi ownyourbits/nextcloudpi <IP>
```
