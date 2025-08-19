# ☁️ ShopMate Cloud Deployment

This branch (`cloud-deploy`) contains Docker + CI/CD configuration for deploying **ShopMate** (Java/JSP e-commerce app) on the cloud.

## Features
- Dockerized Java + MySQL
- `docker-compose.yml` for local dev/test
- GitHub Actions pipeline for CI/CD
- Cloud-ready structure (can deploy to AWS/GCP/Azure with minimal changes)

## Run locally
```bash
docker-compose up --build
