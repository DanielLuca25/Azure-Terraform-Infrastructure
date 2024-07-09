output "vm_passwords" {
  value = random_password.rp.*.result
}