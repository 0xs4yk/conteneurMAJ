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

## TP 3 

### CHALLENGE 2 - GITOPS DYNAMIC


# Installation et Configuration d'ArgoCD sur Kubernetes

## 1. Installation de ArgoCD

- Ajout du repository Helm ArgoCD :
  ```bash
  helm repo add argo https://argoproj.github.io/argo-helm
  helm repo update
  ```

- Installation du chart ArgoCD avec Helm :
  ```bash
  helm install argocd argo/argo-cd -n argocd --create-namespace
  ```

## 2. Vérification de l'installation

- Vérification du service `argocd-server` :
  ```bash
  kubectl describe svc argocd-server -n argocd
  ```

## 3. Mise en place de node port
```
kubectl expose service argocd-server --type=NodePort --name=argocd-nodeport -n argocd
```
- Vérification de la mise en place
```
kubectl get svc -n argocd
```
## 3. Accès à l'interface web d'ArgoCD

- Redirection du port de `argocd-server` vers un port local avec `kubectl port-forward` :
  ```bash
  kubectl port-forward svc/argocd-server -n argocd 8080:80
  ```

- Accéder à l'interface web via : [http://localhost:8080](http://localhost:8080)

## 4. Récupération des identifiants par défaut

- Récupération du mot de passe initial d'ArgoCD (utilisateur `admin`) :
  ```bash
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
  ```

## 5. Connexion à ArgoCD

- Connexion à l'interface web avec les identifiants par défaut :
  - Nom d'utilisateur : `admin`
  - Mot de passe : récupéré précédemment

