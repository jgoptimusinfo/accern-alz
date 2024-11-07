## --------------------------------------------------------
##  LOCALS
## --------------------------------------------------------


## --------------------------------------------------------
##  Network Security Group
## --------------------------------------------------------

resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = var.security_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
}

# Setup Network Security Group association with subnets
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {

  subnet_id                 = var.subnet
  network_security_group_id = azurerm_network_security_group.nsg.id
}