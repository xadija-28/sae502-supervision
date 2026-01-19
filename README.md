Projet SAÉ 5.02
Supervision automatisée d’une infrastructure réseau virtualisée
1. Présentation
Ce projet, dans le cadre de la SAÉ 5.02, consiste à déployer une infrastructure réseau virtualisée avec supervision.
On utilise des équipements virtuels et des outils conteneurisés pour simuler un environnement réel, en supervisant via SNMP et ICMP, de façon reproductible et automatisée.
3. Objectifs

    Déployer une infrastructure réseau virtualisée
    Installer des routeurs virtuels (FRRouting)
    Superviser via SNMP et ICMP
    Centraliser les métriques
    Automatiser le déploiement et la configuration

4. Périmètre
Inclus

    Infrastructure virtualisée
    Routeurs FRRouting
    Réseaux LAN et backbone
    Supervision SNMP/ICMP
    Visualisation (Grafana)
    Déploiement automatisé

Hors périmètre

    Équipements physiques
    Sécurité avancée (ACL, VPN, chiffrement)

4. Architecture

    Réseaux virtuels (LAN, backbone)
    Routeurs virtuels connectés
    Plateforme de supervision centralisée

Déployé via Docker pour rapidité et cohérence.

5. Outils
   
Rôles 
Docker / Docker Compose  -->  Déploiement infrastructure
FRRouting   --> Routage IP
Prometheus   --> Collecte métriques
SNMP Exporter  -->  SNMP
Blackbox Exporter  --> ICMP
Grafana  --> Visualisation
Ansible  --> Automatisation

6. Fonctionnement

    Déploiement via Docker Compose
    Mise en place des routeurs et réseaux
    Activation SNMP sur équipements
    Collecte métriques par Prometheus
    Visualisation dans Grafana
    Automatisation via Ansible (scripts/playbooks)

L’ensemble doit pouvoir s’initialiser sans intervention manuelle.
7. Organisation du dépôt

plaintext


.
├── ansible/        # Playbooks et rôles
├── docker/         # Docker Compose et configs
├── grafana/        # Dashboards
├── prometheus/     # Configurations
└── README.md

8. Automatisation

  L’automatisation repose sur :

Docker Compose pour l’orchestration des services

Ansible pour la préparation de l’environnement et le déploiement

L’objectif final est que la démonstration puisse être lancée uniquement à partir des scripts et playbooks, conformément aux attentes de la SAÉ.


9. État d’avancement

    Architecture définie
    Docker opérationnel
    Supervision en cours
    Automatisation en partie



🔜 Prochaine étape
Préparer la présentation orale (phase 1) et finaliser la démo automatisée (phase 2).
