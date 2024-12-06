#!/bin/bash

# Menampilkan ASCII art untuk "Saandy"
echo "  ██████ ▄▄▄     ▄▄▄      ███▄    █▓█████▓██   ██▓"
echo "▒██    ▒▒████▄  ▒████▄    ██ ▀█   █▒██▀ ██▒██  ██▒"
echo "░ ▓██▄  ▒██  ▀█▄▒██  ▀█▄ ▓██  ▀█ ██░██   █▌▒██ ██░"
echo "  ▒   ██░██▄▄▄▄█░██▄▄▄▄██▓██▒  ▐▌██░▓█▄   ▌░ ▐██▓░"
echo "▒██████▒▒▓█   ▓██▓█   ▓██▒██░   ▓██░▒████▓ ░ ██▒▓░"
echo "▒ ▒▓▒ ▒ ░▒▒   ▓▒█▒▒   ▓▒█░ ▒░   ▒ ▒ ▒▒▓  ▒  ██▒▒▒ "
echo "░ ░▒  ░ ░ ▒   ▒▒ ░▒   ▒▒ ░ ░░   ░ ▒░░ ▒  ▒▓██ ░▒░ "
echo "░  ░  ░   ░   ▒   ░   ▒     ░   ░ ░ ░ ░  ░▒ ▒ ░░  "
echo "      ░       ░  ░    ░  ░        ░   ░   ░ ░     "
echo "                                    ░     ░ ░     "
echo

# Minta pengguna memasukkan address reward
echo "Masukkan reward address Anda (contoh: 0x1234567890abcdef):"
read -r REWARD_ADDRESS

# Pastikan input address tidak kosong
if [[ -z "$REWARD_ADDRESS" ]]; then
  echo "Error: Reward address tidak boleh kosong."
  exit 1
fi

# Hentikan layanan cysic
sudo systemctl stop cysic

# Hapus file database cysic-verifier
sudo rm -rf cysic-verifier/data/cysic-verifier.db

# Unduh dan jalankan skrip setup dari GitHub dengan address yang dimasukkan
curl -L https://github.com/cysic-labs/phase2_libs/releases/download/v1.0.0/setup_linux.sh > ~/setup_linux.sh
bash ~/setup_linux.sh "$REWARD_ADDRESS"

# Mulai ulang layanan cysic dan tampilkan log secara real-time
sudo systemctl restart cysic
sudo journalctl -u cysic -f --no-hostname -o cat
