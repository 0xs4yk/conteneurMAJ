# TP 3 - Docker : Build avec multi-stage

## Étapes

### 1. Créez un nouveau repository Git

### 2. Initialisez un projet React vierge

Préférence : Utilisation de Next.js
```sh
npx create-next-app@latest maxence-tp3
```

### 3. Vérifiez que l'application fonctionne correctement en local
```sh
npm run dev
```

### 4. Créez un fichier Dockerfile à la racine du projet

#### Étape 1 : Construction de l'application React
```Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

COPY . .
RUN npm run build
```

#### Étape 2 : Serveur web pour l'application
```Dockerfile
FROM nginx:alpine

COPY --from=builder /app/.next /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### 5. Instanciez l’image créée

#### Build de l'image
```sh
docker build -t maxence-tp3 .
```

#### Exécution du conteneur
```sh
docker run -p 8080:80 maxence-tp3
```

#### Résultat attendu
```
172.17.0.1 - - [06/Feb/2025:13:34:22 +0000] "GET / HTTP/1.1" 200 615
