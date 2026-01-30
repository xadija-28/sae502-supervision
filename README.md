
# SAE 5.02 – Supervision réseau automatisée

**Docker · Prometheus · Grafana · Alerting · Ansible**

## 1. Objectif du projet

L’objectif de ce projet est de **déployer automatiquement une solution de supervision réseau** permettant :

* de superviser l’état de routeurs (ICMP),
* de visualiser l’état du réseau via Grafana,
* de déclencher des alertes en cas de panne,
* d’automatiser le déploiement avec Ansible.

Le projet est conçu pour être **déployé en une seule commande**, sans configuration manuelle dans l’interface graphique.

---

## 2. Architecture générale

La solution repose sur **trois briques principales** :

* **Docker** : exécution des services (Prometheus, Grafana, routeurs, webhook)
* **Grafana** : visualisation et alerting
* **Ansible** : orchestration et automatisation du déploiement

---

## 3. Organisation du projet

```
sae502-supervision/
├── ansible/
├── docker/
├── grafana/
├── README.md
```

### 3.1 Dossier `ansible/`

Ce dossier contient **l’automatisation complète du déploiement**.

```
ansible/
├── ansible.cfg
├── inventory/
│   └── hosts.ini
├── playbooks/
│   └── site.yml
└── roles/
    ├── check_environment/
    ├── check_stack/
    ├── deploy_stack/
    └── post_checks/
```

#### Rôles Ansible

* **check_environment**
  Vérifie que Docker et Docker Compose sont bien installés sur la machine.

* **check_stack**
  Vérifie si des conteneurs Docker sont déjà présents avant le déploiement.

* **deploy_stack**
  Lance automatiquement la stack Docker via `docker compose up -d`.

* **post_checks**
  Vérifie que les services sont bien accessibles :

  * Grafana
  * Prometheus
  * Webhook d’alertes

 **Un seul playbook est exécuté** :

```bash
ansible-playbook playbooks/site.yml
```

---

### 3.2 Dossier `docker/`

C’est **le cœur technique du projet**.

```
docker/
├── docker-compose.yml
├── prometheus/
│   └── prometheus.yml
├── grafana/
│   ├── dashboards/
│   └── provisioning/
│       ├── datasources/
│       ├── dashboards/
│       └── alerting/
├── webhook/
└── frr/
```

#### Services déployés

* **Routeurs FRR** (router-central, CE1, CE2)
* **Prometheus**
* **Blackbox Exporter (ICMP)**
* **Grafana**
* **Webhook Flask (alertes)**

Tous les services sont lancés **automatiquement** par Docker Compose.

---

### 3.3 Grafana – Dashboards et alertes

La configuration Grafana est **provisionnée automatiquement** via des volumes :

* Dashboards chargés automatiquement
* Datasource Prometheus configurée
* Alertes Grafana préconfigurées
* Point de contact webhook déjà défini

Aucune action manuelle n’est nécessaire dans l’interface Grafana.

---

## 4. Alerting

### Fonctionnement

* Prometheus détecte une panne ICMP (`probe_success == 0`)
* Grafana déclenche une alerte
* L’alerte est envoyée vers un **webhook Flask**
* Le webhook affiche l’alerte avec :

  * équipement concerné
  * statut
  * résumé
  * procédure de dépannage
  * lien vers le runbook

Les alertes sont **persistantes** grâce aux volumes Grafana :
un `docker down` suivi d’un `docker up` **ne supprime rien**.

---

## 5. Déploiement du projet (démonstration)

### Étape 

```bash
cd sae502-supervision/ansible
ansible-playbook playbooks/site.yml
```

➡️ Cette commande :

* vérifie l’environnement,
* déploie la stack Docker,
* vérifie que tous les services sont fonctionnels.

Aucune configuration manuelle n’est requise.

---

## 6. Accès aux services

* Grafana : [http://localhost:3000](http://localhost:3000)
* Prometheus : [http://localhost:9090](http://localhost:9090)
* Webhook alertes : [http://localhost:5001](http://localhost:5001)

---

## 7. Conclusion

Ce projet démontre :

* une **supervision réseau fonctionnelle**,
* un **déploiement entièrement automatisé**,
* une **architecture claire et reproductible**,
* une séparation nette entre orchestration (Ansible) et exécution (Doccker)
