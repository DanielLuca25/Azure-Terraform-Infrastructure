resource "azurerm_storage_container" "stgcont" {
    name = "terraformstgcont"
    storage_account_name = azurerm_storage_account.stgacc.name

}