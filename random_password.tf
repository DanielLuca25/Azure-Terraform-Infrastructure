resource "random_password" "rp"{
    count = var.vm_count
    length = 16
    special = true
}
