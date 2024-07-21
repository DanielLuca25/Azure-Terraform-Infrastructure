resource "null_resource" "nginx" {
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
  inline = concat(
        [
          "sudo apt-get update -y",
          "sudo apt-get install -y docker.io",
          "sudo systemctl start docker",
          "sudo docker login -u ${nonsensitive(azurerm_container_registry.acr.admin_username)} -p ${nonsensitive(azurerm_container_registry.acr.admin_password)} ${azurerm_container_registry.acr.login_server}",
        ],
        count.index == 0 ? [
          "mkdir nginx-docker",
          "cd nginx-docker",
          "sudo echo -e 'FROM nginx:latest' > Dockerfile",
          "sudo docker build -t nginx-local:latest .",
          "sudo docker tag nginx-local:latest ${azurerm_container_registry.acr.login_server}/nginx:latest",
          "sudo docker push ${azurerm_container_registry.acr.login_server}/nginx:latest",
          "cd ..",
          "rm -rf nginx-docker"
        ] : [
          "sudo docker pull ${azurerm_container_registry.acr.login_server}/nginx:latest",
          "sudo docker run -d --name daniels_container -p 80:80 ${azurerm_container_registry.acr.login_server}/nginx:latest",
          "sleep 60",
          "sudo docker stop daniels_container",
          "sudo docker rm daniels_container"
        ]
      )
    }
  }

