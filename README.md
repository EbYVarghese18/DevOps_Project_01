# Simple Notes App
This is a simple notes app built with React and Django.

# workflow of the project
1. The code for the application is stored in a GitHub repository.
2. The developer creates a Dockerfile to define the image for the application.
3. The Dockerfile is built into a Docker image and stored locally
4. The Docker container is started on the EC2 instance using the docker run command.
5. The container runs the application, and nginx is used as a reverse proxy to manage traffic to the application.
6. The user/browser sends HTTP/HTTPS requests to the EC2 instance's public IP address or DNS name, which are then routed  through the internet to nginx running in the Docker container.
7. Nginx handles the incoming requests and routes them to the appropriate endpoint in the application.
8. The application responds to the requests, and the response is sent back through nginx to the user/browser.

# Requirements

1. Python 3.9
2. Node.js
3. React

# Installation

1. Create an EC2 instance. You can use ubuntu image for the creation. 
    - create inbound rules to enable HTTP and HTTPS
    - connect to the instance through SSH
    - update the packages:
        $sudo apt update
    - install nginx:
        $sudo apt install nginx
        (you can confirm the nginx installation by visiting the public ip of your EC2. If you get a welcome screen of nginx, then the installation is successfull)
    - install docker:
        $sudo apt install docker.io
        (to check the docker status: $systemctl status docker)
        once the installation of docker is completed, we have to give the permission to user
        $sudo usermod -aG docker $USER
    - reboot the system

2. Clone the repository

    $git clone https://github.com/EbYVarghese18/DevOps_Project_01.git

3. Build the docker image

    $docker build -t notes-app .
    (To check the image: $docker images)
    Note: make sure that you are in the same directory that contain the file Dockerfile. Othervise adjust the directory in the docker build command accordingly

4. Run the app into docker container

    $docker run -d -p 8000:8000 notes-app:latest
    (To check the running container: $docker ps)

# Nginx

Install Nginx reverse proxy to make this application available

`sudo apt-get update`
`sudo apt install nginx`