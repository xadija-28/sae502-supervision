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

	<img width="496" height="385" alt="{94FFBFA6-FAF3-4E1A-B78A-6091E80A03F5}" src="https://github.com/user-attachments/assets/9a65ccc3-4d2f-4f14-9bd7-3b795ae1d29d" />


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

<img width="372" height="136" alt="{C3BB8CB6-72E4-4142-81C8-0B97CF5D3C07}" src="https://github.com/user-attachments/assets/c79b51ca-d201-4a30-90b4-3db2ee482e91" />


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
