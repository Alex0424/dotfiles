#!/bin/bash

dnf install -y git
sudo -u vagrant git clone https://github.com/Alex0424/dotfiles.git /home/vagrant/dotfiles

echo "[INFO] Done."
