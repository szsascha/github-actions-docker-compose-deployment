#!/bin/bash

docker compose build

for img in $(docker-compose config | awk '{if ($1 == "image:") print $2;}'); do
  images="$images $img"
done

echo $images

docker image save $images | docker -H "${{ DOCKER_REMOTE_HOST }}" image load
docker-compose -H "${{ DOCKER_REMOTE_HOST }}" up --force-recreate -d