Directory structure 


=== ROOT === 

cdrrmo
   cdrrmo-api/
   cdrrmo-client/
   nginx/
   docker-compose.yml
   readme.txt
   
   
   
### FRONT END

**cdrrmo-client**
- Front end of the project.
- Architecture: Single Page Application (SPA).
- Development Server: Vite.
- Framework: Vue.js (Version 3).
- Language: TypeScript.
- CSS Framework: Utilizes Bootstrap 5 with the SB Admin Template.
   
   
   
   
### BACK END

**cdrrmo-api**
- Back end of the project.
- Architecture: API-Driven Architecture.
- Development Server: Node.js.
- Framework: NestJS.
- Language: TypeScript.
- Database ORM: Utilizes Prisma.
- Database: PostgreSQL.
   
   
   
   
=== DOCKER === 
   - Docker is a platform designed to make it easier to create, deploy, and run applications using containers. Containers allow developers to package an application and its dependencies together into a single unit. This containerized application can then run consistently across different environments, from development to testing to production.
   
   
   
   
=== NGINX === 
   - Web server
   - Use as reverse proxy
   
   
=== DEPLOY TO PRODUCTION ===
Installation Guide (Initial setup): 

1. Install Docker. https://docs.docker.com/get-docker/
2. Install Docker Compose. https://docs.docker.com/compose/install/

Running the Application: 

1. Open terminal 
2. Change your working directory to the root directory of the project. Run the following command to start the Docker containers:
   - docker-compose up --build
3. Open another terminal and check the list of running containers and run: 
   - docker ps

*You should see a table with information about your running containers. 

SAMPLE FORMAT

CONTAINER ID   IMAGE                         COMMAND                  CREATED          STATUS         PORTS                                       NAMES
bf7c2ba75162   nginx:1.25                    "/docker-entrypoint.…"   9 minutes ago    Up 4 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp           cdrrmo-ormoc-nginx-1
b6fa3346b91b   cdrrmo/cdrrmo-server:latest   "docker-entrypoint.s…"   9 minutes ago    Up 4 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   cdrrmo-ormoc-cdrrmo-server-1
a003e94cadf5   cdrrmo/cdrrmo-client:latest   "docker-entrypoint.s…"   39 minutes ago   Up 5 seconds   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp   cdrrmo-ormoc-cdrrmo-client-1
11fc39e20420   postgres:16                   "docker-entrypoint.s…"   5 days ago       Up 5 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   cdrrmo-ormoc-postgres-1

4. Go inside the Docker container for the back end by running the following command. Replace <CONTAINER ID> with the actual ID of your back-end container.

   - run command and use container id of cdrrmo-ormoc-cdrrmo-server-1: docker exec -it <CONTAINER ID> /bin/sh

5. Run the following command inside the Docker container to apply database migrations. run command: npx prisma migrate dev

6A. Open browser and go to http://localhost:3000/api#/
   - Scroll down to find the authentication API section and use a POST request for /api/v1/auth/create-admin. Provide a username and password in the request body.
6B. Optionally you can open another terminal window and run this command: curl -X POST -H "Content-Type: application/json" -d '{"username": "admin.cdrrmo", "password": "admin.cdrrmo123"}' http://localhost:3000/api/v1/auth/create-admin
   
7. Access Front End: Open new tab and go to http://localhost/cdrrmo/

8. Login: Enter username and password you provided during step 6


=== FOR DEVELOPMENT ===
Same procedure for deploying to production

if running on your own machine you can run: docker-compose down
   - this will stop running the docker containers and will free up resource on your machine

to run the application just run the command: docker-compose up and you can now access the app in the browser (http://localhost/cdrrmo/)

