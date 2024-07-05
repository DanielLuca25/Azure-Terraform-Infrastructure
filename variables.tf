variable "vm_count" {
    type = number
    default = 2
  
}

variable "vm_size" {
    type = string
    default = "Standard_B1s"
}   

variable "vm_image" {
    type = string
    default = "22_04-lts"
}