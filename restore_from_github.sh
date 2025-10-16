#!/bin/bash
# -------------------------------------------------------------
#  GitHubi taastamisskript - taastab lokaalsed failid GitHubi viimasesse seisu
#  Autor: Indrek Kuusk
#  Kasutamiseks: käivita samas kaustas, kus on Git repo (nt ~/AWS-test)
# -------------------------------------------------------------

set -e  # Lõpeta skript kohe, kui mingi käsk ebaõnnestub

REPO_DIR=$(pwd)
BACKUP_DIR="${REPO_DIR}/backup_$(date +%Y-%m-%d_%H-%M-%S)"

echo "-----------------------------------------"
echo " GitHub taastamisskript"
echo " Kaust: $REPO_DIR"
echo " Varukoopia: $BACKUP_DIR"
echo "-----------------------------------------"

# 1. Kontrolli, et tegemist on git-repoga
if [ ! -d ".git" ]; then
    echo "❌ Viga: see kaust ei ole git-repo. Mine projekti juurkausta."
    exit 1
fi

# 2. Tee varukoopia enne taastamist
echo "📦 Teen varukoopia praegusest seisust..."
mkdir -p "$BACKUP_DIR"
rsync -a --exclude='.git' ./ "$BACKUP_DIR"/
echo "✅ Varukoopia tehtud: $BACKUP_DIR"

# 3. Näita muutusi enne taastamist
echo ""
echo "📋 Muutused võrreldes GitHubiga:"
git fetch origin
git diff origin/main || true

echo ""
read -p "Kas soovid taastada kõik failid GitHubi viimasesse seisu? (jah/ei): " confirm

if [ "$confirm" != "jah" ]; then
    echo "❎ Katkestatud kasutaja poolt. Failid jäid muutmata."
    exit 0
fi

# 4. Taasta kõik failid GitHubi viimasesse seisu
echo "🔄 Taastan failid GitHubi seisu..."
git reset --hard origin/main

echo ""
echo "✅ Taastamine lõpetatud."
echo "Sinu vana versioon on varundatud kausta: $BACKUP_DIR"
echo "-----------------------------------------"
