# Docker compose deployment with github actions

Deploy your docker compose application with github actions and without the need of an own container registry to your server. But please keep in mind that this is just an example how a deployment for docker compose could work. Please modify the workflow to your needs before using it.

## Requirements

1. A public server with root access
2. Docker installed on the server
3. Correct configured Docker remote access with private key authentication


## Setup

1. Use the contents of this repo as base for your application
2. Configure the USER, HOST, PORT and PRIVATE_KEY secrets in your github repository
3. Set the name of your application in the docker-compose commands (-p argument) of your `deploy.sh`
4. Push your changes and the deployment should run automatically

## Best practices

1. Use a proxy in front of your services and don't choose public ports from your docker-compose application (see https://github.com/szsascha/caddy-proxy)
2. Consider to use an application specific proxy / gateway for load balancing or an further configuration/logging layer in front of your application and behind your public proxy, deployed by this docker compose
3. Always create own Dockerfiles for each image used. Otherwise a redeploy can break other services.
4. Always prefix your container names or use the -p argument of docker-compose
5. Manage internal portranges for your applications so you'll not get any problems with two applications using the same port