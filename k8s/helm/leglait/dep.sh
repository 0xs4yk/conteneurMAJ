#!/bin/bash

# Déploiement du magasin "Mes Bons Légumes"
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mesbonslegumes-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mesbonslegumes
  template:
    metadata:
      labels:
        app: mesbonslegumes
    spec:
      containers:
      - name: mesbonslegumes
        image: sayk/mesbonslegumes:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "512Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: mesbonslegumes-service
spec:
  selector:
    app: mesbonslegumes
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF

# Déploiement du magasin "Mes Bons Légumes Bio"
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mesbonslegumesbio-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mesbonslegumesbio
  template:
    metadata:
      labels:
        app: mesbonslegumesbio
    spec:
      containers:
      - name: mesbonslegumesbio
        image: sayk/mesbonslegumesbio:v2
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "512Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: mesbonslegumesbio-service
spec:
  selector:
    app: mesbonslegumesbio
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: mesbonslegumesbio-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: "mesbonslegumes.fr"
    http:
      paths:
      - path: /bio
        pathType: Prefix
        backend:
          service:
            name: mesbonslegumesbio-service
            port:
              number: 80
EOF

# Déploiement du magasin "Mon Bon Lait"
kubectl apply -f - <<EOF
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
---
apiVersion: v1
kind: Service
metadata:
  name: monbonlait-service
spec:
  selector:
    app: monbonlait
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: monbonlait-ingress
spec:
  rules:
  - host: "monbonlait.fr"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: monbonlait-service
            port:
              number: 80
EOF

echo "Déploiement terminé !"
