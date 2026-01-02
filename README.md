
# 📘 SAÉ 5.02 — Supervision réseau avec Docker et Ansible

## Présentation du projet

Ce projet a été réalisé dans le cadre de la **SAÉ 5.02** du BUT Réseaux & Télécommunications.
Il vise à mettre en œuvre une **infrastructure réseau virtualisée**, représentative d’un petit réseau d’entreprise, tout en appliquant une démarche d’**automatisation** et de **supervision**.

L’objectif n’est pas uniquement de déployer un réseau fonctionnel, mais également de montrer comment celui-ci peut être **supervisé** afin de détecter rapidement une anomalie ou une perte de connectivité.
Les informations de supervision sont centralisées dans un **dashboard**, permettant d’avoir une vue globale et claire de l’état du réseau.

---

## Démarche et objectifs

La démarche suivie dans ce projet est la suivante :

* Concevoir une architecture réseau simple et cohérente
* Déployer cette architecture à l’aide de Docker
* Automatiser la configuration réseau avec Ansible
* Structurer l’automatisation en **rôles Ansible** afin d’éviter les répétitions
* Mettre en place une **supervision centralisée**
* Visualiser l’état du réseau et les alertes dans un **dashboard de supervision**
* Générer un rapport de supervision
* Tester le système par une simulation de panne

---

## Architecture du réseau

L’infrastructure repose sur **quatre conteneurs Docker** :

* **node-manager**
  Machine d’administration exécutant Ansible et centralisant la supervision.

* **router-central**
  Routeur central assurant le routage entre les différents réseaux.

* **client1**
  Hôte du premier réseau local.

* **client2**
  Hôte du second réseau local.

Trois réseaux Docker sont utilisés :

* un réseau principal (**backbone**)
* deux réseaux locaux (**lan_client1** et **lan_client2**)

---

## Supervision et dashboard

La supervision du réseau permet de vérifier en continu la **disponibilité des équipements** et la **connectivité entre les hôtes**.

Les résultats de supervision (état des hôtes, succès ou échec des tests de connectivité) sont :

* collectés automatiquement,
* centralisés sur le **node-manager**,
* affichés dans un **dashboard de supervision**.

Ce dashboard offre une vue synthétique de l’état du réseau :

* hôtes joignables ou non,
* détection rapide d’une panne,
* visualisation claire des alertes.

Il permet ainsi de réagir rapidement en cas de problème, comme dans un contexte réel de supervision réseau en entreprise.

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

---

## Automatisation, supervision et alertes

Le playbook de déploiement configure automatiquement le réseau et prépare les hôtes à être supervisés :

```bash
ansible-playbook ansible/playbooks/deploy.yml
```

Le playbook de supervision :

* teste la connectivité réseau,
* détecte les hôtes injoignables,
* met à jour les informations affichées dans le dashboard,
* génère un rapport de supervision.

```bash
ansible-playbook ansible/playbooks/supervise.yml
```

---

## Simulation de panne

Une panne peut être simulée en arrêtant un conteneur client :

```bash
docker stop client2
```

Cette panne est immédiatement détectée par la supervision et visible dans le **dashboard**, ce qui permet de valider le bon fonctionnement du système d’alertes.

---

## Conclusion

Ce projet met en œuvre une infrastructure réseau automatisée et supervisée, proche d’un cas réel.
L’utilisation d’un **dashboard de supervision** permet d’avoir une vision claire et centralisée de l’état du réseau, facilitant la détection des incidents et l’analyse du fonctionnement global.
