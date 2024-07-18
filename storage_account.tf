resource "azurerm_storage_account" "stgacc" {
    name  = "terraformstgacc25"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}