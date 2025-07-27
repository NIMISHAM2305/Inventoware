# Inventoware: Legacy App Modernization

## Project Overview
This project modernizes the legacy Inventoware inventory management app for cloud-native deployment. It uses Docker for containerization, Terraform for AWS infrastructure, Ansible for configuration, Jenkins for CI/CD, and Trivy for security scanning.

## Key Components

### 1. Docker
- The app is containerized using the provided `Dockerfile`.
- To build and run locally:
  ```sh
  docker build -t inventoware-app .
  docker run -p 5000:5000 inventoware-app
  ```

### 2. Terraform
- `main.tf` provisions AWS resources (EC2, etc.).
- Usage:
  ```sh
  terraform init
  terraform apply
  ```
- Update AMI and add resources as needed.

### 3. Ansible
- `ansible-playbook.yml` automates dependency installation and app deployment.
- Usage:
  ```sh
  ansible-playbook -i <ec2_public_ip>, ansible-playbook.yml
  ```

### 4. Jenkins CI/CD
- `Jenkinsfile` defines pipeline: build, scan, test, push, deploy.
- Requires Docker, Trivy, and Jenkins plugins.
- Set up DockerHub credentials in Jenkins.

### 5. Security Scanning
- Trivy scans Docker images for vulnerabilities in the pipeline.

## Dependencies
- Python 3.10+
- Flask (see `requirements.txt`)
- Docker
- Terraform
- Ansible
- Jenkins
- Trivy

## Next Steps
- Update Terraform and Ansible files for your AWS/account specifics.
- Add more tests to the app for robust CI.
- Optionally, add Kubernetes manifests for further modernization.

---
For any missing dependencies, install with:
- `pip install -r requirements.txt`
- [Install Docker](https://docs.docker.com/get-docker/)
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Install Jenkins](https://www.jenkins.io/doc/book/installing/)
- [Install Trivy](https://aquasecurity.github.io/trivy/v0.18.3/installation/)
