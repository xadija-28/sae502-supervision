#!/bin/bash

BASE_DIR="ansible"

echo "📁 Création de l'arborescence Ansible..."

# Dossiers principaux
mkdir -p $BASE_DIR/{inventory,playbooks,roles}

# Fichier inventory
mkdir -p $BASE_DIR/inventory
touch $BASE_DIR/inventory/hosts.ini

# Playbook principal
mkdir -p $BASE_DIR/playbooks
touch $BASE_DIR/playbooks/site.yml

# Rôles
ROLES=(
  check_environment
  check_stack
  deploy_stack
  post_checks
)

for role in "${ROLES[@]}"; do
  mkdir -p $BASE_DIR/roles/$role/tasks
  touch $BASE_DIR/roles/$role/tasks/main.yml
done

echo "✅ Arborescence Ansible créée avec succès"
