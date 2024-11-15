## --------------------------------------------------------
##  locals
## --------------------------------------------------------

## NOTE: Replace the value of the firewall_resource_group_name with the name of the resource group where the Azure Firewall and Firewall Policy will be deployed.

locals { 
  firewall_resource_group_name = "accern-nwsvcs-prd-eus2-rg"
  virtual_hub_id = "/subscriptions/3124b81f-32b6-49f2-98d6-7500ef2a165f/resourceGroups/accern-nwsvcs-prd-eus2-rg/providers/Microsoft.Network/virtualHubs/acn-virtual-hub-prd"
}

## --------------------------------------------------------
##  Azure Firewall - Policy
## --------------------------------------------------------

module "firewall_policy" {
  
  source             = "Azure/avm-res-network-firewallpolicy/azurerm"
  version            = "0.3.2"

  enable_telemetry    = false
  name                = "acn-vwan-hub-fw-pol01"
  location            = var.location
  resource_group_name = local.firewall_resource_group_name
  
  tags = var.tags
}

module "rule_collection_group" {

  source             = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  version            = "0.3.2"

  firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.resource.id
  firewall_policy_rule_collection_group_name               = "acn-vwan-hub-fw-pol01-rules"
  firewall_policy_rule_collection_group_priority           = 400
  firewall_policy_rule_collection_group_network_rule_collection = [
    {
      action   = "Allow"
      name     = "NetworkRuleCollection"
      priority = 400
      rule = [
        {
          name                  = "OutboundToInternet"
          description           = "Allow traffic outbound to the Internet"
          destination_addresses = ["*"] 
          destination_ports     = ["*"] 
          source_addresses      = ["*"]
          protocols             = ["TCP", "UDP", "ICMP"]
        }
      ]
    }
  ]
  firewall_policy_rule_collection_group_application_rule_collection = [
    {
      action   = "Allow"
      name     = "ApplicationRuleCollection"
      priority = 600
      rule = [
        {
          name             = "AllowAll"
          description      = "Allow traffic to Microsoft.com"
          source_addresses = ["10.0.0.0/24"]
          protocols = [
            {
              port = 443
              type = "Https"
            }
          ]
          destination_fqdns = ["microsoft.com"]
        }
      ]
    }
  ]
}

## --------------------------------------------------------
##  Azure Firewall
## --------------------------------------------------------

module "firewall" {
  
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "0.3.0"
  enable_telemetry   = false

  name                = "acn-vwan-fw01"
  location            = var.location
  resource_group_name = local.firewall_resource_group_name
  
  firewall_sku_tier   = "Standard"
  firewall_sku_name   = "AZFW_Hub"
  firewall_zones      = ["1"] #["1", "2", "3"]
  firewall_virtual_hub = {
    virtual_hub_id  = local.virtual_hub_id
    public_ip_count = 2
  }
  firewall_policy_id = module.firewall_policy.resource.id

  tags = var.tags
}