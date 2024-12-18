## --------------------------------------------------------
##  locals
## --------------------------------------------------------

locals { 
}

## --------------------------------------------------------
##  ALZ - Core
## --------------------------------------------------------
 
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "6.1.0"

  default_location = var.location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = "Accern" # Replace with "root id"
  root_name      = "Accern Organization" # Replace with "Tenant Root Group"
  
  disable_telemetry = true
  library_path                = "${path.root}/lib"
  
  deploy_core_landing_zones   = true

  custom_landing_zones = {
    "Landing-Zone-Dev" = {
      display_name               = "Landings Zones - Dev"
      parent_management_group_id = "Accern-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "customer_dev"
        parameters     = {}
        access_control = {}
      }
    }
    "Landing-Zone-Prod" = {
      display_name               = "Landings Zones - Prod"
      parent_management_group_id = "Accern-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "customer_prod"
        access_control = {}
        parameters     = {}
      }
    }
  }

  deploy_management_resources    = false
  subscription_id_management     = data.azurerm_client_config.core.subscription_id # replace is Management Subscription ID
  configure_management_resources = local.configure_management_resources

  deploy_identity_resources    = false
  subscription_id_identity     = data.azurerm_client_config.core.subscription_id # replace is Identity Subscription ID
  configure_identity_resources = local.configure_identity_resources

  deploy_connectivity_resources    = true
  subscription_id_connectivity     = data.azurerm_client_config.core.subscription_id # replace is Connectivity Subscription ID
  configure_connectivity_resources = local.configure_connectivity_resources
}