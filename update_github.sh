#!/bin/bash
# -------------------------------------------------------------
#  GitHub uuendusskript - saadab lokaalsed muudatused GitHubi
#  Autor: Indrek Kuusk
#  Kasutamiseks: käivita projekti juurkaustas (nt ~/AWS-test)
# -------------------------------------------------------------

set -e  # Peata skript, kui mõni käsk ebaõnnestub

REPO_DIR=$(pwd)

echo "-----------------------------------------"
echo " GitHub uuendusskript"
echo " Kaust: $REPO_DIR"
echo "-----------------------------------------"

# 1. Kontrolli, et tegemist on git-repoga
if [ ! -d ".git" ]; then
    echo "❌ Viga: see kaust ei ole git-repo. Mine projekti juurkausta."
    exit 1
fi

# 2. Näita muutusi
echo "📋 Kontrollin muudatusi..."
git status

# 3. Küsi commit’i sõnum
echo ""
read -p "Sisesta commit’i sõnum (nt 'Uuendatud landing page või parandatud viga'): " message

if [ -z "$message" ]; then
    echo "❌ Viga: commit’i sõnum ei tohi olla tühi."
    exit 1
fi

# 4. Lisa kõik muudatused
echo "📦 Lisan kõik muudatused..."
git add .

# 5. Tee commit
git commit -m "$message" || {
    echo "ℹ️  Pole uusi muudatusi commitimiseks."
    exit 0
}

# 6. Kontrolli branch’i (main või master)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📡 Aktiivne branch: $BRANCH"

# 7. Tõmba enne push’i (et vältida konflikte)
echo "🔄 Sünkroniseerin GitHubi viimase seisu..."
git pull origin "$BRANCH" --rebase

# 8. Saada muudatused GitHubi
echo "🚀 Saadan muudatused GitHubi..."
git push origin "$BRANCH"

echo "✅ Kõik muudatused on edukalt saadetud GitHubi!"
echo "-----------------------------------------"
