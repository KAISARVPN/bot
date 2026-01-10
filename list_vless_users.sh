#!/bin/bash
# ===============================================================
# Script: list_vless_users.sh - ANTI-GAGAL (Regex Flexible)
# ===============================================================

CONFIG_FILE="/etc/xray/config.json"
export LANG=en_US.UTF-8

# 1. Cek File Config
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "🚫 *File config tidak ditemukan*"
    exit 1
fi

# 2. Hitung Jumlah (HAPUS SPASI SETELAH REGEX)
#    Kita cari baris yang 'dimulai dengan #vls atau #vlg', 
#    tidak peduli karakter setelahnya spasi atau tab.
NUMBER_OF_CLIENTS=$(grep -c -E "^#(vls|vlg)" "$CONFIG_FILE")

# 3. Logika Tampilan
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo -e "🚫 *Tidak ada akun VLESS yang aktif*"
else
    echo -e "📡 *DAFTAR AKUN VLESS (Total: $NUMBER_OF_CLIENTS)*"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # 4. Ambil Data
    #    Gunakan 'awk' default behaviour (otomatis baca spasi/tab)
    grep -E "^#(vls|vlg)" "$CONFIG_FILE" | while read -r line; do
        user=$(echo "$line" | awk '{print $2}')
        exp=$(echo "$line" | awk '{print $3}')
        
        # Tampilkan
        echo -e "👤 \`$user\` | ⏳ $exp"
    done
    
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

exit 0
