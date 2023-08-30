#!/bin/bash

docker-compose build

for img in $(docker-compose config | awk '{if ($1 == "image:") print $2;}'); do
  images="$images $img"
done

echo $images

docker image save $images | docker -H "ssh://${{ secrets.USER }}@${{ secrets.HOST }}:${{ secrets.PORT }}" image load
docker-compose -H "ssh://${{ secrets.USER }}@${{ secrets.HOST }}:${{ secrets.PORT }}" up --force-recreate -d
docker-compose -H "ssh://${{ secrets.USER }}@${{ secrets.HOST }}:${{ secrets.PORT }}" logs -f