#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cr=${cr%.}
read -r -p "This will create a php project folder for you using Docker. Continue? [y\N] $cr"
read -r -p "Enter the name for your php project: $cr" name 
read -r -p "Enter the directory for your php project: $cr" dir
composer create-project $dir
cd $dir || exit;
mkdir docker/
cp $script_dir/docker/Dockerfile docker/Dockerfile 
cp $script_dir/docker/vhost.conf docker/vhost.conf
cp $script_dir/docker/docker-compose.yml .
sed -i bak -e "s|PROJECT_NAME|${name}|g" docker-compose.yml
docker build \
  --file docker/Dockerfile \
  -t $name-php-docker .