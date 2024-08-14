---

# Azure Terraform Infrastructure with CI/CD Pipeline

This project automates the creation and management of a cloud infrastructure in Microsoft Azure using Terraform. The infrastructure includes essential networking components, virtual machines (VMs), storage solutions, and a Docker container workflow. Additionally, a CI/CD pipeline is implemented using GitHub Actions to streamline the deployment process. This project is managed using Agile principles to ensure iterative development, continuous improvement, and responsiveness to feedback.

## Table of Contents
- [Description](#description)
- [Architecture](#architecture)
- [Agile Workflow](#agile-workflow)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [CI/CD Pipeline](#cicd-pipeline)
- [Additional Files](#additional-files)

## Description
This project automates the creation and management of a cloud infrastructure in Microsoft Azure using Terraform. The infrastructure includes key resources such as resource groups, a virtual network (VNet), subnets, public IP addresses, network interfaces, Linux virtual machines, an Azure Container Registry, a Storage Account, and a Storage Container. The Terraform configuration uses the `count` function to create two instances of network interfaces, public IPs, random passwords, and virtual machines.

After deployment, the first virtual machine builds an Nginx Docker image and pushes it to the Azure Container Registry. The second virtual machine pulls this Docker image, runs it on port 80 for 60 seconds, then stops and deletes the container.

A CI/CD pipeline implemented with GitHub Actions automates the deployment process by installing Terraform, connecting to the Azure account, initializing and validating the infrastructure, planning the deployment, generating a plan output file, and applying the infrastructure.

This project is developed and maintained using Agile principles, ensuring continuous delivery, iterative progress, and responsiveness to feedback.

## Architecture
The project architecture includes:
1. **Resource Groups**: Organizes all resources.
2. **VNet and Subnet**: Establishes the networking environment.
3. **Public IPs and Network Interfaces**: Facilitates external connectivity for the VMs.
4. **Linux Virtual Machines**: Two instances are created using the `count` function in Terraform.
5. **Random Password Generator**: Generates secure passwords for the VMs.
6. **Azure Container Registry**: Stores and manages Docker container images.
7. **Storage Account**: Provides scalable cloud storage.
8. **Storage Container**: Organizes blobs within the Storage Account.

## Agile Workflow
This project is managed using Agile methodologies, incorporating the following practices:
- **Iterative Development**: The project is broken down into smaller, manageable sprints, each focusing on specific deliverables.
- **Continuous Integration**: Automated deployment and testing through GitHub Actions ensure that each iteration is integrated and validated frequently.
- **Continuous Improvement**: Regular self-assessment and reflection are conducted after each development cycle to identify areas for improvement and optimize processes. This involves reviewing what worked well and what didn’t, and making adjustments to enhance productivity and quality in future iterations.

## Installation
### Prerequisites
- **Terraform**: Ensure that Terraform is installed on your local machine.
- **Azure CLI**: Install Azure CLI and authenticate with your Azure account.
- **GitHub Account**: Required for setting up the GitHub Actions pipeline.

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Create a plan file:
   ```bash
   terraform plan -out=tfplan
   ```

5. Apply the infrastructure:
   ```bash
   terraform apply tfplan
   ```

## Usage
After deployment:
1. **VM 1**:
   - Builds the Docker Nginx image.
   - Pushes the image to the Azure Container Registry.

2. **VM 2**:
   - Pulls the Nginx image.
   - Runs the container on port 80 for 60 seconds.
   - Stops and deletes the container after execution.

### CLI Commands File
The `cli_commands` script automates the following on the VMs:
- Building and pushing the Docker image.
- Pulling and running the Docker container.

## Features
- **Automated Infrastructure Deployment**: Uses Terraform to deploy and manage Azure resources.
- **Dynamic Resource Creation**: Implements the `count` function to create multiple instances of resources.
- **Comprehensive Resource Management**: Includes networking, storage, and container management resources.
- **Docker Container Workflow**: Automates Docker image creation, pushing, and running between VMs.
- **CI/CD Pipeline**: GitHub Actions pipeline for continuous integration and deployment.
- **Agile Management**: The project is managed using Agile principles, allowing for iterative progress and continuous improvement.

## CI/CD Pipeline
The GitHub Actions pipeline automates the following steps:
1. **Terraform Installation**: Installs Terraform on the GitHub runner.
2. **Azure Authentication**: Connects to your Azure account.
3. **Terraform Initialization**: Initializes the Terraform working directory.
4. **Resource Importing**: Imports existing resources.
5. **Validation and Planning**: Validates the infrastructure and creates a plan file.
6. **Infrastructure Application**: Applies the Terraform plan to create or update resources.

## Additional Files
- **`cli_commands`**: A null resource that provides the VMs with the necessary script for Docker image creation and container management.
- **`locals`**: Defines local values used within the Terraform configuration.
- **`output`**: Contains the output variables for VM passwords and public IP addresses.
- **`terraform.tfvars`**: Stores the Terraform variables specific to your environment, including sensitive values.
- **`variables`**: Defines variables for resource counts, VM sizes, and VM images.

---
