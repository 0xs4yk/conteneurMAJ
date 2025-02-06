# TP Docker Node.js

## 2. Compléter le Dockerfile
Option npm utilisée : `--production`
- Permet de ne pas installer les dépendances de développement
- Configuration dans : `maxenceTP2/Dockerfile`

## 3. Création de l'image
```bash
docker build -t ma_super_app .
```

## 4. Docker Compose
- Configuration dans : `maxenceTP2/docker-compose.yml`
```bash
docker-compose up --build -d
```