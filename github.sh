#!/bin/bash
# ==========================================================
# ⚡ Neon Glow Intelligence v5.1.6 — Full Integrity Edition
# Termux Friendly • Auto Auth • Git Upload (HTTPS/SSH) • API Upload • Full LICENSE/README
# ==========================================================

CINEMATIC=false
THEME="neon"
TERMUX_MODE=false
NO_LOLCAT=false
username=""
token=""

# ---------- ARGUMENT PARSING ----------
for arg in "$@"; do
  case "$arg" in
    cinematic) CINEMATIC=true ;;
    --theme=*) THEME="${arg#*=}" ;;
    --termux) TERMUX_MODE=true ;;
    --no-lolcat) NO_LOLCAT=true ;;
  esac
done

# ---------- ENVIRONMENT DETECTION ----------
COLS=$(tput cols 2>/dev/null || echo 80)
SMALL_TERM=false
[ "$COLS" -lt 80 ] && SMALL_TERM=true
if command -v termux-open-url >/dev/null 2>&1 || [[ "$PREFIX" =~ termux ]]; then TERMUX_MODE=true; fi

# Safe mode lolcat & figlet
if $SMALL_TERM || $TERMUX_MODE || $NO_LOLCAT; then USE_LOLCAT=false; else command -v lolcat >/dev/null 2>&1 && USE_LOLCAT=true || USE_LOLCAT=false; fi
FIGLET_FONT="slant"; $SMALL_TERM && FIGLET_FONT="mini"; command -v figlet >/dev/null 2>&1 || FIGLET_FONT=""

# ---------- COLORS ----------
if [[ "$THEME" == "cyberpunk" ]]; then
  RED='\e[38;5;196m'; MAGENTA='\e[38;5;201m'; BLUE='\e[38;5;93m'; GREEN='\e[38;5;118m'; CYAN='\e[38;5;81m'; RESET='\e[0m'; YELLOW='\e[33m'; BOLD='\e[1m'
elif [[ "$THEME" == "matrix" ]]; then
  RED='\e[32m'; MAGENTA='\e[32m'; BLUE='\e[32m'; GREEN='\e[32m'; CYAN='\e[32m'; RESET='\e[0m'; YELLOW='\e[32m'; BOLD='\e[1m'
else
  RED='\e[31m'; GREEN='\e[92m'; BLUE='\e[94m'; YELLOW='\e[93m'; MAGENTA='\e[95m'; CYAN='\e[96m'; RESET='\e[0m'; BOLD='\e[1m'
fi

# ---------- HELPERS ----------
lcat() { $USE_LOLCAT && lolcat || cat; }
pause(){ read -p "Tekan Enter..." _; }

ai_thinking(){
  local lines=("Analyzing data..." "Syncing neural cores..." "Optimizing threads..." "Ready.")
  for msg in "${lines[@]}"; do echo -e "${CYAN}$msg${RESET}" | lcat; sleep 0.4; done
}

boot_system_ai(){
  clear
  if command -v figlet >/dev/null 2>&1; then figlet -f "$FIGLET_FONT" "Booting System" | lcat; else echo "Booting System..."; fi
  echo "Initializing Neural Framework..." | lcat; sleep 0.4
  echo "Loading neural modules..." | lcat; sleep 0.4
  echo "Activating visual cortex..." | lcat; sleep 0.4
  echo -e "${GREEN}✅ System Online — Neural Core Activated${RESET}" | lcat
  sleep 0.5
}

tampilkan_ascii(){
  clear
  if command -v figlet >/dev/null 2>&1; then figlet -f "$FIGLET_FONT" "Neon Glow AI" | lcat; else echo "== Neon Glow AI =="; fi
  echo "🤖 Neural Core Online — GitHub Manager" | lcat
  echo "===================================" | lcat
}

# ---------- AUTH ----------
autentikasi_github(){
  tampilkan_ascii
  [ -z "$username" ] && { echo -e "${YELLOW}Masukkan Username GitHub:${RESET}"; read username; }
  [ -z "$token" ] && { echo -e "${YELLOW}Masukkan Personal Access Token (PAT):${RESET}"; read -s token; }
  echo -e "${GREEN}✅ Autentikasi tersimpan.${RESET}"
  sleep 0.5
}

# ---------- SAFE DIR FIX ----------
safe_dir_fix(){ git config --global --add safe.directory "$1" >/dev/null 2>&1; }

# ---------- LICENSE / README ----------
generate_license() {
  local type="$1" author="$2" year=$(date +%Y)
  case "$type" in
    mit)
      cat <<EOF
MIT License

Copyright (c) $year $author

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
      ;;
    apache-2.0)
      cat <<EOF
Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

Copyright (c) $year $author

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
EOF
      ;;
    gpl-3.0)
      cat <<EOF
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) $year $author

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF
      ;;
    unlicense)
      cat <<EOF
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
EOF
      ;;
    *)
      echo "No license selected." ;;
  esac
}


# === README ===
generate_readme(){
  local path="$1" repo="$2" desc="$3" username="$4" banner="$5" license="$6"
  local now=$(date '+%A, %d %B %Y — %H:%M:%S')
  local banner_ascii=$(figlet -f slant "$banner" 2>/dev/null || echo "$banner")
  mkdir -p "$path"
  
  # buat struktur folder bergaya tree
  echo "📦 Membuat struktur folder..." 
  local tree_output
  if command -v tree >/dev/null 2>&1; then
    tree_output=$(tree -a -I '.git|node_modules' "$path")
  else
    tree_output=$(find "$path" -print | sed -e "s|[^/]*/|├── |g")
  fi

  cat > "$path/README.md" <<EOF
# ⚡ $repo

$desc

🕒 Dibuat: $now  
👤 Pemilik: [$username](https://github.com/$username)  
⚖️ Lisensi: ${license:-None}

\`\`\`
$banner_ascii
\`\`\`

---

## 📂 Struktur Folder
\`\`\`
${tree_output}
\`\`\`

Dibuat otomatis oleh **GitHub Uploader Plus v4.1.5 BY CPM_JHON — Neon Glow Intelligence Fusion**
EOF
}

license_template_from_choice(){
  case "$1" in
    1) echo "mit" ;;
    2) echo "apache-2.0" ;;
    3) echo "gpl-3.0" ;;
    4) echo "unlicense" ;;
    *) echo "" ;;
  esac
}

# ---------- API UPLOAD ----------
upload_api_file(){
  local u="$1" t="$2" r="$3" f="$4" rel="$5"
  [ ! -f "$f/$rel" ] && return
  local enc=$(base64 "$f/$rel" | tr -d '\n')
  local data="{\"message\":\"upload\",\"content\":\"$enc\"}"
  curl -s -X PUT -u "$u:$t" -H "Accept: application/vnd.github.v3+json" -d "$data" \
       "https://api.github.com/repos/$u/$r/contents/$rel" >/dev/null
}

upload_via_api(){
  local u="$1" t="$2" r="$3" folder="$4"
  [ ! -d "$folder" ] && { echo "📁 Folder '$folder' belum ada, membuat baru..."; mkdir -p "$folder"; }
  pushd "$folder" >/dev/null || { echo "❌ Gagal masuk folder."; return; }
  mapfile -t files < <(find . -type f | sed 's|^\./||')
  [ ${#files[@]} -eq 0 ] && { echo "⚠️ Tidak ada file untuk diupload."; popd >/dev/null; return; }
  local i=0 total=${#files[@]}
  for rel in "${files[@]}"; do i=$((i+1)); printf "\r📤 [%d/%d] %s" "$i" "$total" "$rel"; upload_api_file "$u" "$t" "$r" "$(pwd)" "$rel"; done
  echo -e "\n✅ Upload selesai."
  popd >/dev/null || true
}

# ---------- CORE FEATURES ----------
create_repo_flow(){
  tampilkan_ascii
  read -p "Nama repository: " repo
  read -p "Deskripsi singkat: " desc
  echo "Pilih lisensi:"
  echo "1) MIT"; echo "2) Apache-2.0"; echo "3) GPL-3.0"; echo "4) Unlicense"; echo "5) None"
  read -p "#? " lchoice
  lic_template=$(license_template_from_choice "$lchoice")

  [ -n "$lic_template" ] && payload="{\"name\":\"$repo\",\"description\":\"$desc\",\"license_template\":\"$lic_template\",\"auto_init\":true}" \
                         || payload="{\"name\":\"$repo\",\"description\":\"$desc\",\"auto_init\":true}"
                         
  ai_thinking
  curl -s -u "$username:$token" -d "{\"name\":\"$repo\",\"description\":\"$desc\"}" "https://api.github.com/user/repos" >/dev/null
  echo "✅ Repository '$repo' dibuat."
  read -p "Path folder lokal: " folder
  mkdir -p "$folder"
  read -p "Teks banner README: " banner_text 
  generate_readme "$folder" "$repo" "$desc" "$username" "$banner_text" "${lic_template:-None}"
  [ -n "$lic_template" ] && generate_license "$lic_template" "$username" > "$folder/LICENSE"
  
  echo "📤 Upload README & LICENSE..."
  upload_api_file "$username" "$token" "$repo" "$folder" "README.md"
  upload_api_file "$username" "$token" "$repo" "$folder" "LICENSE"
  upload_via_api "$username" "$token" "$repo" "$folder"
  pause
}

buat_repository(){
  tampilkan_ascii
  read -p "Nama Repository: " repo
  ai_thinking
  curl -s -u "$username:$token" -d "{\"name\":\"$repo\"}" "https://api.github.com/user/repos" >/dev/null
  echo "✅ Repository '$repo' berhasil dibuat."
  pause
}

hapus_repository(){
  tampilkan_ascii
  read -p "Masukkan nama repository yang ingin dihapus: " repo
  ai_thinking
  curl -s -X DELETE -u "$username:$token" "https://api.github.com/repos/$username/$repo"
  echo "✅ Repository '$repo' dihapus (jika ada)."
  pause
}

upload_proyek(){
  tampilkan_ascii
  read -p "Masukkan nama repository tujuan: " repo
  read -p "Masukkan path folder proyek: " folder
  ai_thinking
  upload_via_api "$username" "$token" "$repo" "$folder"
  pause
}

# ---------- 🔗 UPLOAD REPO HTTPS/SSH ----------
upload_repo(){
  clear
  echo "${MAGENTA}${BOLD}=== UPLOAD / UPDATE REPOSITORY ===${RESET}"
  ai_thinking
  read -p "Nama repository: " repo
  echo "Pilih mode upload:"
  echo "1) HTTPS (pakai PAT)"
  echo "2) SSH"
  read -p "#? " mode
  read -p "Masukkan path folder lokal: " path
  read -p "Pesan commit: " msg

  [ ! -d "$path" ] && echo "${RED}❌ Folder tidak ditemukan.${RESET}" && sleep 2 && return
  cd "$path" || { echo "${RED}❌ Tidak dapat masuk folder.${RESET}"; sleep 2; return; }

  if [ -d ".git" ]; then
    echo "${YELLOW}⚠️ Menghapus konfigurasi Git lama...${RESET}"
    rm -rf .git
  fi

  safe_dir_fix "$path"
  git init --initial-branch=main >/dev/null 2>&1
  git add . >/dev/null 2>&1
  git commit -m "$msg" >/dev/null 2>&1

  animate_push(){
    local spin='|/-\'
    local i=0
    while kill -0 "$1" 2>/dev/null; do
      i=$(( (i+1) %4 ))
      printf "\r${CYAN}🚀 Uploading via Git ${spin:$i:1}${RESET}"
      sleep 0.2
    done
  }

  if [ "$mode" == "1" ]; then
    read -p "Masukkan URL repo HTTPS (https://github.com/user/repo.git): " repo_url
    [[ ! "$repo_url" =~ ^https://github.com/ ]] && echo "${RED}❌ URL tidak valid.${RESET}" && sleep 2 && return
    git remote add origin "https://${username}:${token}@${repo_url#https://}"
    echo "${CYAN}Mengunggah via HTTPS...${RESET}"
    (git push --set-upstream origin main -f >/dev/null 2>&1) & pid=$!
    animate_push $pid; wait $pid
    [ $? -eq 0 ] && echo -e "\n${GREEN}✅ Upload HTTPS berhasil!${RESET}" || echo -e "\n${RED}❌ Upload HTTPS gagal.${RESET}"
  elif [ "$mode" == "2" ]; then
    read -p "Masukkan URL repo SSH (git@github.com:user/repo.git): " ssh_url
    [[ ! "$ssh_url" =~ ^git@github.com: ]] && echo "${RED}❌ URL SSH tidak valid.${RESET}" && sleep 2 && return
    git remote add origin "$ssh_url"
    echo "${CYAN}Mengunggah via SSH...${RESET}"
    (git push --set-upstream origin main -f >/dev/null 2>&1) & pid=$!
    animate_push $pid; wait $pid
    [ $? -eq 0 ] && echo -e "\n${GREEN}✅ Upload SSH berhasil!${RESET}" || echo -e "\n${RED}❌ Upload SSH gagal.${RESET}"
  fi

  echo
  echo "${BLUE}🌐 Membuka repo di browser...${RESET}"
  termux-open-url "https://github.com/${username}/${repo}" >/dev/null 2>&1 || true
  pause
}

# ---------- MENU ----------
main_menu(){
  while true; do
    tampilkan_ascii
    echo -e "${BLUE}Pilih aksi:${RESET}" | lcat
    echo "1️⃣  Buat Repo + Upload + README + LICENSE"
    echo "2️⃣  Buat Repository"
    echo "3️⃣  Hapus Repository"
    echo "4️⃣  Upload Proyek (API)"
    echo "5️⃣  Upload (HTTPS/SSH)"
    echo "6️⃣  Ganti Akun GitHub"
    echo "7️⃣  Keluar"
    echo
    read -p "Masukkan pilihan: " p
    case $p in
      1) create_repo_flow ;;
      2) buat_repository ;;
      3) hapus_repository ;;
      4) upload_proyek ;;
      5) upload_repo ;;
      6) username=""; token=""; autentikasi_github ;;
      7) clear; figlet -f mini "Shutdown" | lcat; exit 0 ;;
      *) echo "❌ Pilihan tidak valid." ;;
    esac
    pause
  done
}

# ---------- STARTUP ----------
boot_system_ai
autentikasi_github
main_menu
