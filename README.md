#  SAÉ 5.02 — Supervision réseau avec Docker et Ansible

## Présentation du projet

Ce projet a été réalisé dans le cadre de la **SAÉ 5.02** du BUT Réseaux & Télécommunications.
Il vise à mettre en œuvre une **infrastructure réseau virtualisée**, représentative d’un petit réseau d’entreprise, tout en appliquant une démarche d’**automatisation** et de **supervision**.

L’objectif principal n’est pas uniquement de faire fonctionner le réseau, mais de montrer comment celui-ci peut être **déployé, configuré et supervisé automatiquement**, de manière claire, reproductible et maintenable.
Le projet s’appuie donc sur **Docker** pour la virtualisation et **Ansible** pour l’automatisation, en respectant les bonnes pratiques vues en cours, notamment l’utilisation des **rôles Ansible** et d’un **environnement Python dédié**.

---

## Démarche et objectifs

La démarche suivie dans ce projet est la suivante :

* Concevoir une architecture réseau simple mais cohérente
* Déployer cette architecture à l’aide de conteneurs Docker
* Automatiser la configuration réseau avec Ansible
* Structurer l’automatisation en **rôles** afin d’éviter les répétitions
* Mettre en place une supervision de la connectivité réseau
* Générer un **rapport de supervision** exploitable
* Tester la robustesse du système par une simulation de panne

L’ensemble du projet a été pensé pour être facilement compréhensible et réutilisable.

---

## Architecture du réseau

L’infrastructure repose sur **quatre conteneurs Docker** :

* **node-manager**
  Machine d’administration utilisée pour exécuter Ansible et la supervision.

* **router-central**
  Routeur central assurant le routage entre les différents réseaux.

* **client1**
  Hôte du premier réseau local.

* **client2**
  Hôte du second réseau local.

Trois réseaux Docker sont utilisés :

* un réseau principal (**backbone**)
* deux réseaux locaux (**lan_client1** et **lan_client2**)

Les réseaux sont définis directement dans le fichier `docker-compose.yml`, ce qui permet un déploiement simple et reproductible.

---

## Technologies utilisées

* **Docker / Docker Compose** : déploiement de l’infrastructure
* **Ansible** : automatisation de la configuration et de la supervision
* **Python (virtualenv)** : exécution d’Ansible dans un environnement isolé
* **Linux (Ubuntu)** : système utilisé dans les conteneurs

---

## Organisation du projet

```
sae502-supervision/
├── docker/
│   └── docker-compose.yml
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   ├── roles/
│   └── reports/
├── scripts/
│   └── setup_node_manager.sh
└── README.md
```

Cette organisation permet de séparer clairement :

* l’infrastructure Docker
* l’automatisation Ansible
* la génération des rapports

---

## Mise en œuvre du projet

### Déploiement de l’infrastructure

```bash
docker compose up -d
```

### Préparation du node-manager

```bash
bash scripts/setup_node_manager.sh
source ~/ansible/bin/activate
```

---

## Automatisation et supervision

Le playbook de déploiement configure automatiquement :

* les outils nécessaires sur les hôtes
* le routage sur le routeur central
* les routes sur les clients

```bash
ansible-playbook ansible/playbooks/deploy.yml
```

La supervision permet de tester la connectivité entre les hôtes et de générer un rapport :

```bash
ansible-playbook ansible/playbooks/supervise.yml
```

Les rapports sont disponibles dans le dossier `ansible/reports/`.

---

## Simulation de panne

Afin de valider le fonctionnement de la supervision, une panne peut être simulée en arrêtant un conteneur client :

```bash
docker stop client2
```

La perte de connectivité est alors détectée et signalée dans le rapport de supervision.

---

## Conclusion

Ce projet met en pratique les notions d’automatisation et de supervision réseau dans un environnement virtualisé.
Il illustre l’intérêt d’une infrastructure déployée de manière reproductible et d’une configuration automatisée, tout en restant simple et compréhensible.

