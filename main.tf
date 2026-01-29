terraform {
  required_providers {
    virtualbox = {
      source  = "terra-formers/virtualbox"
      version = "~> 0.4.0"
    }
  }
}

provider "virtualbox" {}

resource "virtualbox_vm" "vm" {
  count       = 3
  name        = "vm-${count.index + 1}"
  image       = var.image_url
  cpus        = var.cpus
  memory      = var.memory
  disk_size   = var.disk_size

  # Сеть: NAT + проброс портов SSH (5001–5003 на хосте)
  network_adapter {
    type = "nat"
    forwarded_port {
      guest = 22
      host  = 500${count.index + 1}
    }
  }

  # Копируем скрипт настройки на ВМ
  provisioner "file" {
    source      = "${path.module}/init-vm.sh"
    destination = "/tmp/init-vm.sh"
  }

  # Выполняем скрипт на ВМ
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init-vm.sh",
      "/tmp/init-vm.sh"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"  # Для Vagrant-образов
      # Для использования SSH-ключа укажите:
      # private_key = file("~/.ssh/id_rsa")
      host        = self.network_adapter[0].ipv4_address
      port        = 22
      timeout     = "10m"
    }
  }
}

