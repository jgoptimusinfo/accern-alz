
terraform {
  required_version = ">= 1.9.3"

  backend "azurerm" {
    resource_group_name  = "state-dev"
    storage_account_name = "statedevjg3456"
    container_name       = "accern-alz-core"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.106.1, < 4.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.51.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.4.0, < 2.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.11.2"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3.4"
    }

    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1"
    }
  }
}

# Declare a standard provider block using your preferred configuration.
# This will target the "default" Subscription and be used for the deployment of all "Core resources".
provider "azurerm" {
  features {}
}

# Declare an aliased provider block using your preferred configuration.
# This will be used for the deployment of all "Connectivity resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "3124b81f-32b6-49f2-98d6-7500ef2a165f" # Replace with the Subscription ID for the "Connectivity" Subscription
  features {}
}

# Declare a standard provider block using your preferred configuration.
# This will be used for the deployment of all "Management resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "management"
  subscription_id = "3124b81f-32b6-49f2-98d6-7500ef2a165f" # Replace with the Subscription ID for the "Management" Subscription
  features {}
}

# Obtain client configuration from the un-aliased provider
data "azurerm_client_config" "core" {
  provider = azurerm
}

# Obtain client configuration from the "management" provider
data "azurerm_client_config" "management" {
  provider = azurerm.management
}

# Obtain client configuration from the "connectivity" provider
data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}

# Map each module provider to their corresponding `azurerm` provider using the providers input object
