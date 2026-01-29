variable "image_url" {
  description = "URL образа Ubuntu для VirtualBox (Vagrant box)"
  type        = string
  default     = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20250101.0.0/providers/virtualbox.box"
}

variable "cpus" {
  description = "Количество CPU на ВМ"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Объём памяти (МБ)"
  type        = number
  default     = 1024
}

variable "disk_size" {
  description = "Размер диска (МБ)"
  type        = number
  default     = 10240
}
