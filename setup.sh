#!/bin/bash

# ================================
# 💾 Script Auto Backup Panel 💾
# ================================

clear

# Display ASCII Art
cat << "EOF"
⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
EOF

echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33mSelamat datang di script auto backup panel!\033[0m"
echo -e "\033[1;33mPastikan kamu punya akses OAuth yang sudah dibeli dari ChiwA <3\033[0m"
echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

sleep 5
clear

cd
mkdir -p backup
cd backup

echo -e "\033[1;33m🔧 Installing necessary packages...\033[0m"
apt update
apt install -y jq wget

echo -e "\033[1;33m🚀 Installing Node Version Manager (nvm)...\033[0m"
rm -f backup.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc

nvm install 20
source ~/.bashrc
node -v
npm i axios fs path googleapis tar
npm install -g pm2

# Pilihan backup atau restore
CHOICE=""
while [[ "$CHOICE" != "1" && "$CHOICE" != "2" ]]; do
  echo -e "\033[1;33mPilih opsi:\033[0m"
  echo -e "\033[1;32m1) Backup data\033[0m"
  echo -e "\033[1;34m2) Restore data\033[0m"
  read -p "Masukkan pilihan (1 atau 2): " CHOICE

  if [[ "$CHOICE" != "1" && "$CHOICE" != "2" ]]; then
    echo -e "\033[1;31m❌ Pilihan tidak valid. Silakan coba lagi.\033[0m"
  fi
done

if [ "$CHOICE" == "1" ]; then
  # Backup
  echo -e "\033[1;33m📥 Downloading backup script...\033[0m"
  wget -qO backup.js https://files.chiwa.id/script/backuppanel/backup.js
  chmod +x backup.js

  SERVER_BASE_URL="https://api.chiwa.id"

  AUTH_URL=$(curl -s "$SERVER_BASE_URL/api/auth/common/gdrive" | jq -r '.url')

  echo -e "\033[1;35mPlease visit the following URL to login: \033[1;36m$AUTH_URL\033[0m"
  read -p "Enter the authentication code: " AUTH_CODE

  TOKEN_RESPONSE=$(curl -s "$SERVER_BASE_URL/api/auth/common/gdrive/code?code=$AUTH_CODE")
  ERROR=$(echo "$TOKEN_RESPONSE" | jq -r '.error')

  TOKENS=$(echo "$TOKEN_RESPONSE" | jq '.tokens')
  CONFIG_FILE="config.json"

  if [ ! -f "$CONFIG_FILE" ]; then
    echo "{}" > "$CONFIG_FILE"
  fi

  jq --argjson tokens "$TOKENS" '.tokens = $tokens' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
  echo -e "\033[1;32m✅ Authentication successful! Tokens saved to config.json.\033[0m"

  echo -e "\033[1;33m🚀 Starting the backup process with PM2...\033[0m"
  pm2 start backup.js --name "backup"

echo "Masukkan hari (contoh: 0 untuk setiap hari, 1 untuk 1 hari):"
read days
echo "Masukkan jam:"
read hours
echo "Masukkan menit:"
read minutes

# Hitung total interval dalam menit
total_minutes=$((days * 1440 + hours * 60 + minutes))

if [[ $total_minutes -eq 0 ]]; then
    echo -e "\033[1;31m⚠️  Total interval tidak valid! Masukkan nilai yang benar.\033[0m"
    exit 1
fi

# Konfigurasi cron job
if [[ $days -eq 0 && $hours -eq 0 ]]; then
    echo -e "\033[1;33m🔄 Menjadwalkan backup setiap $minutes menit...\033[0m"
    cron_expression="*/$minutes * * * * pm2 restart backup"
else
    echo -e "\033[1;33m🔄 Menjadwalkan backup setiap $days hari, lebih $hours jam, lebih $minutes menit...\033[0m"
    cron_expression="0 $minutes $hours */$days * pm2 restart backup"
fi

# Tambahkan ke crontab
(crontab -l 2>/dev/null; echo "$cron_expression") | crontab -

echo -e "\033[1;32m✅ Cron job berhasil ditambahkan!\033[0m"
  echo -e "\033[1;32m✅ Cron job to restart PM2 backup process has been set!\033[0m"
  npm i -g pm2
  node backup.js
  pm2 logs backup
elif [ "$CHOICE" == "2" ]; then
  # Restore
  echo -e "\033[1;33m📥 Downloading restore script...\033[0m"
  cd /root/backup
  wget -qO restore.js https://files.chiwa.id/script/backuppanel/restore.js
  chmod +x restore.js

  echo -e "\033[1;33m🚀 Starting the restore process...\033[0m"
  node restore.js
  echo -e "\033[1;32m✅ Restore process completed!\033[0m"
fi

echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32mProses selesai! 🚀\033[0m"
echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
