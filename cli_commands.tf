resource "null_resource" "nginx" {
    count = local.vm_count

    connection {
      host = azurerm_public_ip.pubip[count.index].ip_address
      user = "adminuser"
      password = random_password.rp[count.index].result
    }

    # provisioner "remote-exec" {
    #   inline = [ 
    #     "ping -c 1 ${azurerm_public_ip.pubip[(count.index + 1) % local.vm_count].ip_address}",
    #    ]
    # }

  provisioner "remote-exec" {
    inline = [
      <<-EOF
      if [ ${count.index} -eq 0 ]; then
        docker login -u ${local.acr_username} -p ${local.acr_password} ${azurerm_container_registry.acr.login_server}
        docker tag nginx:latest ${azurerm_container_registry.acr.login_server}/nginx:latest
        docker push ${azurerm_container_registry.acr.login_server}/nginx:latest
      fi
      EOF
    ]
  }

  provisioner "remote-exec" {
    inline = [
      <<-EOF
      if [ ${count.index} -eq 1 ]; then
        docker login -u ${local.acr_username} -p ${local.acr_password} ${azurerm_container_registry.acr.login_server}
        docker pull ${azurerm_container_registry.acr.login_server}/nginx:latest
        docker run -d -p 80:80 ${azurerm_container_registry.acr.login_server}/nginx:latest
      fi
      EOF
    ]
  }

}

