# Documentation des TPs Kubernetes - RBAC et Network Security

## Organisation des fichiers

- **TP1 (RBAC)** : Disponible dans le dossier `rbac` sous forme de monofichier
- **TP2 (Network Security)** : Disponible dans le dossier `security` avec des fichiers séparés pour permettre le déploiement des Network Policies en conséquence pour les tests

## TP1 - RBAC

Ce TP concerne la mise en place du contrôle d'accès basé sur les rôles dans Kubernetes.

### Étapes à réaliser
- Créer un namespace "Web"
- Créer un déploiement Nginx
- Créer un ServiceAccount "webmaster"
- Créer un rôle pour lister les pods dans le namespace web
- Assigner le rôle au ServiceAccount
- Créer un job qui curl le pod Nginx et liste les pods dans le namespace
- Créer un CronJob qui curl le pod Nginx et liste les pods dans le namespace toutes les 5 secondes
- Vérifier le bon fonctionnement
---
- Créer un namespace "backup"
- Créer un ServiceAccount "backup"
- Créer un ClusterRole pour lister les pods dans les namespaces
- Assigner le ClusterRole au ServiceAccount
- Sauvegarder la base ETCD
- Créer un job qui sauvegarde la base ETCD
- Créer un CronJob qui sauvegarde la base ETCD et la rend disponible pour l'administrateur
- Vérifier le bon fonctionnement

## TP2 - NETWORK SECURITY

Ce TP concerne la mise en place et la configuration des politiques réseau dans Kubernetes.

### Étapes à réaliser
- Créer un namespace "Webbis"
- Créer un déploiement Nginx (sans l'exposer)
- Créer un namespace "Curling"
- Créer un job qui curl le pod Nginx dans le namespace "Webbis" depuis le namespace "Curling"
- Créer un CronJob qui curl le pod Nginx et liste les pods dans le namespace toutes les 5 secondes
- Créer une NetworkPolicy qui refuse tout trafic (deny-all) sur "Webbis"
- Vérifier que le CronJob de curl dans le namespace "Curling" ne fonctionne pas
- Modifier la NetworkPolicy pour autoriser tout trafic depuis le namespace "Curling"
- Vérifier que le CronJob de curl dans le namespace "Curling" fonctionne
- Modifier la NetworkPolicy pour autoriser uniquement les requêtes provenant du CronJob du namespace "Curling"
- Vérifier le bon fonctionnement