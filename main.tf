resource "azurerm_virtual_network" "vnet" {
    name = "vnet-terraform"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name = "subnet-terraform"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/17"]
}

resource "azurerm_public_ip" "pubip" {
  count = var.vm_count
  name = "terraform-public-ip-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
    count = var.vm_count
    name = "terraform-nic-${count.index}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration{
        name = "internal"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pubip[count.index].id
    }
}

resource "random_password" "rp"{
    count = var.vm_count
    length = 16
    special = true
}

resource "azurerm_linux_virtual_machine" "vm"{
    count = var.vm_count
    name = "terraform-vm`-${count.index}"
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