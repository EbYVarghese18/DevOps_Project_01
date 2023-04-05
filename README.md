# Simple Notes App
This is a simple notes app built with React and Django.

# workflow of the project
1. The code for the application is stored in a GitHub repository.
2. The developer creates a Dockerfile to define the image for the application.
3. The Dockerfile is built into a Docker image and stored in EC2. 
4. The Docker container is started on the EC2 instance using the docker run command.
5. The container runs the application, and nginx is used as a reverse proxy to manage traffic to the application.
6. The user/browser sends HTTP/HTTPS requests to the EC2 instance's public IP address or DNS name, which are then routed  through the internet to nginx.
7. Nginx handles the incoming requests and routes them to the appropriate endpoint in the application.
8. The application responds to the requests, and the response is sent back through nginx to the user/browser.


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

# Nginx Configurations

Install Nginx reverse proxy to make this application available

1. create a new configuration file for our app
    $sudo nano /etc/nginx/sites-available/notes-app.conf

   Add the below script to the file notes-app.conf:

        server {
            listen 80;
            server_name yourdomain.com_or_public_ip_address_of_the_ec2;

            location / {
                proxy_pass http://public_ip_or_yourdomain.com:8000; # Replace the details as per your configuration details
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }

            location /static/ {
                alias /path/to/static/files; # Replace the staticfiles location. 
            }
        }

2. create a symbolic link to enable the configuration:
    $sudo ln -s /etc/nginx/sites-available/notes-app.conf /etc/nginx/sites-enabled/

3. You can test the configuration by:
    $sudo nginx -t

4. Reload nginx if there are no errors. Recheck the configurations if there are any errors.
    $sudo systemctl reload nginx

5. Now you can access the app in the browser.
    To access: http://publicip_or_yourdomain.com:8000




Cheers :smile: you have successfully configured the app. Reach me out if you have any doubts :v::v::v: