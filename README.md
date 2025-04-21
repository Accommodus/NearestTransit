## Dockerfile Branch - Development Environment

This branch contains a custom `Dockerfile` used to define the development environment for this project. It is designed to work with VS Code Devcontainers and includes all required dependencies.

---

### How to Modify

1. Make sure you are a collaborator on the Docker Hub repository:  
   https://hub.docker.com/repository/docker/boomboomcannon/near-pub-trans/collaborators

2. Edit the `Dockerfile` as needed.

3. Build and push the updated image by running:
   ```sh
   sh build_push.sh
   ```

This will build the Docker image and push it to Docker Hub with the `latest` tag.