resource "azurerm_subnet" "subnet" {
    name = "subnet-terraform"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/17"]
}
