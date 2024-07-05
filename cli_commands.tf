resource "null_resource" "ping" {
    count = var.vm_count

    connection {
      host = azurerm_public_ip.pubip[count.index].ip_adress
      user = "adminuser"
      password = random_password.rp[count.index].result
    }

    provisioner "remote-exec" {
      inline = [ 
        "ping -c 1 ${azurerm_public_ip.pubip[(count.index + 1) % var.vm_count].ip_address}",
       ]
    }
  
}