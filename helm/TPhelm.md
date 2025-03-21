# Guide d'installation de Nextcloud avec Helm

Ce guide explique comment déployer Nextcloud sur Kubernetes en utilisant Helm.

## 1. Installation de Helm

Commencez par installer Helm sur votre système :

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## 2. Déploiement de Nextcloud

### Configuration de la base de données PostgreSQL

Installez PostgreSQL à l'aide du chart Helm de Bitnami :

```bash
helm install postgresql bitnami/postgresql \
  --set global.postgresql.auth.username=nextcloud \
  --set global.postgresql.auth.password=passw0rd \
  --set global.postgresql.auth.database=nextcloud
```

### Création du fichier values.yml

Créez un fichier `values.yml` pour personnaliser le déploiement de Nextcloud.

### Installation de Nextcloud

Déployez Nextcloud en utilisant le chart Helm avec vos valeurs personnalisées :

```bash
helm install maxence-nc nextcloud/nextcloud -f values.yml
```

### Accès au service Nextcloud

Pour accéder à Nextcloud localement via port-forwarding :

```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=nextcloud" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace default $POD_NAME 8080:80
```

Une fois cette commande exécutée, Nextcloud sera accessible à l'adresse http://localhost:8080.

## 3. Documentation

Tous les fichiers de documentation se trouvent dans le dossier `/docs`.

> **Note**: Un bug avec GitHub Pages empêche actuellement le déploiement sur ArtifactHub.