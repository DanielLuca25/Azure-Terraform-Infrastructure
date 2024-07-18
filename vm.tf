resource "azurerm_linux_virtual_machine" "vm"{
    count = var.vm_count
    name = "terraform-vm-${count.index}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.vm_size
    admin_username = "adminuser"
    admin_password = random_password.rp[count.index].result
    disable_password_authentication = false

    network_interface_ids = [
        azurerm_network_interface.nic[count.index].id,
    ]

    os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = var.vm_image
        version = "latest"
    }
    
}