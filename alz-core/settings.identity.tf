locals {
  configure_identity_resources = {
    settings = {
      identity = {
        enabled = true
        config = {
          enable_deny_public_ip             = true
          enable_deny_rdp_from_internet     = false
          enable_deny_subnet_without_nsg    = false
          enable_deploy_azure_backup_on_vms = false
        }
      }
    }
  advanced = {
      resource_prefix = "acn"
      resource_suffix = "prd-cace"
      custom_settings_by_resource_type = {
        azurerm_resource_group = {
          identity = {
            name = "acn-identity-prd-cace-rg-01"
          }
        }
      }
    }
  }
}