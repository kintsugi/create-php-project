#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cr=${cr%.}
read -r -p "This will create a php project folder for you using Docker. Continue? [y\\N] $cr"
read -r -p "Enter the name for your php project: $cr" name 
read -r -p "Enter the directory for your php project: $cr" dir
mkdir $dir
cd $dir || exit;
echo 'Initializing git'
git init
cp $script_dir/new-php-project.gitignore .gitignore
echo 'Initializing composer'
composer init
echo 'Initializing docker'
mkdir docker/
cp $script_dir/docker/Dockerfile docker/Dockerfile 
cp $script_dir/docker/vhost.conf docker/vhost.conf
cp $script_dir/docker-compose.yml .
cp -r $script_dir/src .
sed -i bak -e "s|PROJECT_NAME|${name}|g" docker-compose.yml
docker-compose build
echo "New project created! Run the following command to run and then view the phpinfo at http://localhost:8080/index.php"
echo "cd $dir && docker-compose up"