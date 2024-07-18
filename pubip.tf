resource "azurerm_public_ip" "pubip" {
  count = local.vm_count
  name = "terraform-public-ip-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
}
