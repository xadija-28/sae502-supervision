#!/bin/bash

BASE_DIR="$(pwd)/frr"

echo "Création des fichiers daemons FRR..."

for ROUTER in router-central ce1 ce2
do
  DIR="$BASE_DIR/$ROUTER"

  if [ ! -d "$DIR" ]; then
    echo "❌ Dossier $DIR introuvable"
    exit 1
  fi

  cat > "$DIR/daemons" <<EOF
zebra=yes
ospfd=yes
bgpd=no
ripd=no
isisd=no
EOF

  chmod 644 "$DIR/daemons"
  echo "daemons créé pour $ROUTER"
done

echo " Tous les fichiers daemons ont été créés avec succès."
