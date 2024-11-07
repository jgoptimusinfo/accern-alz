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
  root_id        = "Accern"
  root_name      = "Accern Organization" # "Tenant Root Group"

  library_path                = "${path.root}/lib"
  deploy_core_landing_zones   = true

  custom_landing_zones = {
    "Sandboxes" = {
      display_name               = "Sandboxes"
      parent_management_group_id = "Accern-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_sandboxes"
        parameters     = {}
        access_control = {}
      }
    }
    "Landing-Zone-Prod" = {
      display_name               = "Landings Zones - Prod"
      parent_management_group_id = "Accern-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "customer_prod"
        parameters = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = ["eastus", "eastus2"]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = ["eastus", "eastus2"]
          }
        }
        access_control = {}
      }
    }
  }
}