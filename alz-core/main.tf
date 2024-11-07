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
  version = "<version>" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  default_location = var.location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = "accerntest"
  root_name      = "Tenant Root Group"

  deploy_management_resources = false
  subscription_id_management  = data.azurerm_client_config.core.subscription_id
}