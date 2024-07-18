output "vm_passwords" {
  value = random_password.rp.*.result
  sensitive = true
}

output "pubip" {
  value = [for ip in azurerm_public_ip.pubip : ip.ip_address]
}

