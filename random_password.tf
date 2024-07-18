resource "random_password" "rp"{
    count = local.vm_count
    length = 16
    special = true
}
