# Terraform Template Repository

This repository contains Terraform configurations for deploying various Azure resources to build and Enterprise Azure Laning Zone. The repository is structured to support modular and reusable code, making it easier to manage and deploy infrastructure as code.

## Repository Structure

- `modules/`: Contains reusable Terraform modules.
- `alz-core/`: Contains configurations for Azure Landing Zones core setup.
- `main.tf`: The main entry point for Terraform configurations.
- `variables.tf`: Defines the input variables for the Terraform configurations.
- `outputs.tf`: Defines the output values for the Terraform configurations.
- `providers.tf`: Configures the providers required for the Terraform configurations.
- `.github/workflows/`: Contains GitHub Actions workflows for CI/CD.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- An Azure account with appropriate permissions to create resources.
- Azure CLI installed and authenticated.

## Usage

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/terraform-template-repo.git
   cd terraform-template-repo



