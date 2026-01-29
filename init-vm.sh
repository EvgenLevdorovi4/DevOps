#!/bin/bash

# 1. Обновление списка пакетов
echo "Updating package list..."
sudo apt-get update -y

# 2. Полное обновление системы
echo "Upgrading system..."
sudo apt-get upgrade -y

# 3. Установка OpenSSH-сервера (если отсутствует)
echo "Installing OpenSSH server..."
sudo apt-get install -y openssh-server

# 4. Настройка SSH: разрешить пароль
echo "Configuring SSH..."
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh || sudo service ssh restart


# 5. Создание пользователя (опционально)
# echo "Creating user 'admin'..."
# sudo adduser --disabled-password --gecos "" admin
# echo "admin:your_secure_password" | sudo chpasswd

# 6. Разрешение sudo без пароля для vagrant
echo "Granting sudo rights to vagrant..."
echo "vagrant ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/vagrant

# 7. Финализация
echo "Setup completed on $(hostname) at $(date)" | sudo tee /var/log/vm-setup.log
echo "VM is ready for SSH access."

