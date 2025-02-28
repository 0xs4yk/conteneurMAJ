# Documentation TP Kubernetes avec Kind et Ingress

## 1. Installation de Kind

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.21.0/kind-$(uname)-amd64
```

## 2. Installation du contrôleur Ingress Nginx

```bash
kubectl apply -f ingress-nginx.yml
```

Vérification de l'installation :
```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

Résultat attendu :
```
pod/ingress-nginx-controller-5989557678-7dw8r condition met
```

## 3. Schéma de l'architecture

Voir le fichier: `k8s/TP2/schéma.png`

## 4. Construction et publication des images Docker

### Build des images
```bash
docker build -t sayk/monbonlait:latest .
docker build -t sayk/mesbonslegumes:latest .
docker build -t sayk/mesbonslegumesbio:latest .
```

### Publication sur Docker Hub
```bash
docker build sayk/monbonlait:latest
docker build sayk/mesbonslegumes:latest
docker build sayk/mesbonslegumesbio:latest
```

## 5. Déploiement des applications

### Monbonlait
```bash
kubectl apply -f Deployment/deployment-mbl.yml
kubectl apply -f Service/service-mbl.yml
kubectl apply -f Ingress/ingress-mbl.yml
```

### Mesbonslegumes
```bash
kubectl apply -f Deployment/deployment-mblg.yml
kubectl apply -f Service/service-mblg.yml
kubectl apply -f Ingress/ingress-mblg.yml
```

### Mesbonslegumesbio
```bash
kubectl apply -f Deployment/deployment-mblgb.yml
kubectl apply -f Service/service-mblgb.yml
kubectl apply -f Ingress/ingress-mblgb.yml
```

## 6. Scaling et gestion des ressources

Exemple de configuration avec répliques et ressources :

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: monbonlait-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: monbonlait
  template:
    metadata:
      labels:
        app: monbonlait
    spec:
      containers:
      - name: monbonlait
        image: sayk/monbonlait:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

Pour vérifier la distribution des pods :
```bash
while true; do curl -H "Host: monbonlait.fr" http://localhost:8080; sleep 0.1; done
```
Puis vérification sur chaque pod avec 

k logs "nom du pod"

## 7. Mise à jour d'une application (Rolling Update)

### Modification et publication d'une nouvelle version
```bash
# Modifier le fichier HTML
docker build -t sayk/mesbonslegumesbio:v2 .
docker push sayk/mesbonslegumesbio:v2
```

### Déploiement de la nouvelle version
```bash
kubectl set image deployment/mesbonslegumesbio-deployment mesbonslegumesbio=sayk/mesbonslegumesbio:v2.0.1
```

### Surveillance du déploiement

Dans un terminal :
```bash
watch -n 1 -c kubectl get pods
```

Dans un autre terminal :
```bash
watch -n 1 -c curl mesbonslegumes.fr/bio
```

Ces commandes permettent de visualiser en temps réel :
- La création et suppression progressive des pods
- Les changements dans la réponse HTML qui confirment que la nouvelle version est déployée