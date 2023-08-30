#!/bin/bash

for img in $(docker-compose config | awk '{if ($1 == "image:") print $2;}'); do
  images="$images $img"
done

echo $images

docker image save $images | docker image load
docker-compose up --force-recreate -d
docker-compose logs -f