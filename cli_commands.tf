resource "null_resource" "vm" {
    count = var.vm_count

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
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo docker login -u ${nonsensitive(azurerm_container_registry.acr.admin_username)} -p ${nonsensitive(azurerm_container_registry.acr.admin_password)} ${azurerm_container_registry.acr.login_server}",
      count.index == 0 ? <<-EOF
      wget -O nginx.tar https://path/to/nginx/image/tar/file
      sudo docker load -i nginx.tar
      sudo docker tag nginx:latest ${azurerm_container_registry.acr.login_server}/nginx:v1
      sudo docker push ${azurerm_container_registry.acr.login_server}/nginx:v1
      EOF
      :
      <<-EOF
      sudo docker pull ${azurerm_container_registry.acr.login_server}/nginx:v1
      sudo docker run -d -p 80:80 ${azurerm_container_registry.acr.login_server}/nginx:v1
      EOF
    ]
  }
}

