#!/bin/bash

echo "🛠️ Initialisation des fichiers Ansible..."

# site.yml
cat << 'EOF' > ansible/playbooks/site.yml
---
- name: Supervision stack automation
  hosts: localhost
  connection: local
  become: false

  roles:
    - check_environment
    - check_stack
    - deploy_stack
    - post_checks
EOF

# check_environment
cat << 'EOF' > ansible/roles/check_environment/tasks/main.yml
---
- name: Vérifier Docker
  command: docker --version
  register: docker_version
  changed_when: false
  failed_when: docker_version.rc != 0

- name: Vérifier Docker Compose
  command: docker compose version
  register: compose_version
  changed_when: false
  failed_when: compose_version.rc != 0

- name: Afficher versions Docker
  debug:
    msg:
      - "{{ docker_version.stdout }}"
      - "{{ compose_version.stdout }}"
EOF

# check_stack
cat << 'EOF' > ansible/roles/check_stack/tasks/main.yml
---
- name: Vérifier si des conteneurs existent déjà
  command: docker ps --format "{{ '{{' }}.Names{{ '}}' }}"
  register: running_containers
  changed_when: false

- name: Afficher les conteneurs en cours
  debug:
    msg: "{{ running_containers.stdout_lines }}"
EOF

# deploy_stack
cat << 'EOF' > ansible/roles/deploy_stack/tasks/main.yml
---
- name: Déployer la stack Docker
  command: docker compose up -d
  args:
    chdir: "{{ playbook_dir }}/../../docker"
  register: deploy_output

- name: Résultat du déploiement
  debug:
    msg: "{{ deploy_output.stdout }}"
EOF

# post_checks
cat << 'EOF' > ansible/roles/post_checks/tasks/main.yml
---
- name: Vérifier Grafana
  uri:
    url: http://localhost:3000
    status_code: 200

- name: Vérifier Prometheus
  uri:
    url: http://localhost:9090
    status_code: 200

- name: Vérifier Webhook
  uri:
    url: http://localhost:5001
    status_code: 200
EOF

echo "✅ Tous les fichiers Ansible ont été générés"

