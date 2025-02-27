# Documentation TP Kubernetes avec kubectl et minikube

## 1. Installation des outils

### Installation de kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

Vérification de l'installation :
```bash
kubectl version --client
```

### Installation de minikube

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Vérification de l'installation :
```bash
minikube version
```

## 2. Déploiement d'un pod Nginx

### Création du fichier de configuration

Créer un fichier `nginx.yml`

### Déploiement du pod

```bash
kubectl apply -f nginx.yml
```

### Accès à la page par défaut de Nginx

```bash
kubectl port-forward pod/nginx 8080:80
```

Puis accéder à `http://localhost:8080` dans un navigateur.

## 3. Connexion entre plusieurs pods (MySQL et phpMyAdmin)

### Création des fichiers de configuration

- Créer `mysql.yml` pour le pod MySQL
- Créer `phpmyadmin.yml` pour le pod phpMyAdmin
- Créer `mysql-serv.yml` pour le service MySQL

### Déploiement des ressources

```bash
kubectl apply -f mysql.yml
kubectl apply -f phpmyadmin.yml
kubectl apply -f mysql-serv.yml
```

### Accès à phpMyAdmin

```bash
kubectl port-forward pod/phpmyadmin 8080:80
```

Accéder à `http://localhost:8080` dans un navigateur.
