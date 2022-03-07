# Foodgram [![Django-app workflow](https://github.com/hardkoro/foodgram/actions/workflows/foodgram_workflow.yml/badge.svg?branch=master)](https://github.com/hardkoro/foodgram/actions/workflows/foodgram_workflow.yml)

## Description

Foodgram is a service for storing and sharing recipes to cook. Registered user are allowed to add new recipes, subscribe to the authors, add recipes to favorites or to the shopping cart & download shopping cart in PDF.

Service contains an API that allows to retrieve or to update service data.

Application is made on Django REST Framework, deployed on Nginx-server with Docker containerization technologies. GitHub Actions are used for Continuous Integration.

<!--Available at: [http://51.250.19.115/](http://51.250.19.115/)-->

## Technology Stack

[![Python](https://img.shields.io/badge/-Python-464646??style=flat-square&logo=Python)](https://www.python.org/)
[![Django](https://img.shields.io/badge/-Django-464646??style=flat-square&logo=Django)](https://www.djangoproject.com/)
[![Nginx](https://img.shields.io/badge/-NGINX-464646??style=flat-square&logo=NGINX)](https://nginx.org/ru/)
[![Docker](https://img.shields.io/badge/-Docker-464646??style=flat-square&logo=docker)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/-PostgreSQL-464646??style=flat-square&logo=PostgreSQL)](https://www.postgresql.org/)
[![GitHub](https://img.shields.io/badge/-GitHub-464646??style=flat-square&logo=GitHub)](https://github.com/)
[![GitHub%20Actions](https://img.shields.io/badge/-GitHub%20Actions-464646??style=flat-square&logo=GitHub%20actions)](https://github.com/features/actions)

- Python
- Django
- Django REST Framework
- Nginx
- Docker
- Docker Compose
- PostgreSQL
- GitHub
- GitHub Actions

## Deployment

- Clone the repo and change directory to the cloned repo:

  ```bash
  git clone https://github.com/hardkoro/foodgram.git
  ```

  ```bash
  cd foodgram
  ```

- Log in to the remote Ubuntu service

- Install [Docker](https://www.docker.com/get-started)

  ```
  sudo apt install docker.io
  ```

- Install [Docker Compose](https://docs.docker.com/compose/install/)

  ```
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ```

- Edit your nginx configuration file at ```infra/nginx.conf```. Change ```server_name``` to your IP-address

- Copy ```infra/docker-compose.yml``` and ```infra/nginx.conf``` to your Ubuntu server:

  ```
  scp infra/docker-compose.yml <username>@<host>:/home/<username>/docker-compose.yml
  scp infra/nginx.conf <username>@<host>:/home/<username>/nginx.conf
  ```

- Create ```.env``` file & fill it with environment variables:

  ```
  touch .env
  ```
  
  ```.env``` example:

  ```
  DB_ENGINE=<django.db.backends.postgresql>
  DB_NAME=<postgres db name>
  DB_USER=<db user>
  DB_PASSWORD=<password>
  DB_HOST=<db>
  DB_PORT=<5432>
  SECRET_KEY=<django project secret key>
  ```

- To use workflow add environment variables to Secrets at Github:

  ```
  DB_ENGINE=<django.db.backends.postgresql>
  DB_NAME=<postgres db name>
  DB_USER=<db user>
  DB_PASSWORD=<password>
  DB_HOST=<db>
  DB_PORT=<5432>

  DOCKER_PASSWORD=<your docker hub password>
  DOCKER_USERNAME=<your docker hub username>

  SECRET_KEY=<django project secret key>

  USER=<your Ubuntu server username>
  HOST=<your Ubuntu server host name>
  SSH_KEY=<your SSH-key (cat ~/.ssh/id_rsa)>

  TELEGRAM_TO=<your telegram chat id>
  TELEGRAM_TOKEN=<your telegram bot token>
  ```

  Workflow contains four steps:
    - PEP8 compliance code check
    - Build & push backend image to the DockerHub
    - Automatic deploy to the remote Ubuntu server
    - Send Telegram message

- Build and run containers at server:

  ```
  sudo docker-compose up -d --build
  ```

- After first successful deployment run the following commands:

  - Collect static files:

    ```
    sudo docker-compose exec backend python manage.py collectstatic --noinput
    ```

  - Make migrations:

    ```
    sudo docker-compose exec backend python manage.py migrate --noinput
    ```

  - Add initial ingredients to the database (not mandatory):

    ```
    sudo docker-compose exec backend python addingredients /* path_to_json_file */
    ```

  - Add Django superuser:

    ```
    sudo docker-compose exec backend python manage.py createsuperuser
    ```

  - The project will be available at your IP-address 

## Author 

[Evgeny Korobkov](https://github.com/hardkoro/)
