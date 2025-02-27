# Compte Rendu TP Docker
*LANCOSME Maxence*

## 5. Exécution d'un serveur web dans un conteneur Docker

### a. Récupération de l'image nginx
```bash
docker pull nginx
```

### b. Vérification de l'image en local
```bash
docker images
```

### c. & d. Création et servir un fichier HTML via volume
```bash
mkdir maxenceTP1
cd maxenceTP1
echo "<h1>MAXENCE LANCOSME</h1>" > index.html
docker run --name maxenceTP1 -d -p 8080:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx
```

### e. Utilisation de docker cp
```bash
docker stop maxenceTP1
docker rm maxenceTP1
docker run --name maxenceTP1 -d -p 8080:80 nginx
docker cp index.html maxenceTP1:/usr/share/nginx/html/index.html
```

## 6. Construction d'une image personnalisée

### a. & b. Build et exécution
```bash
docker build -t maxencetp1-image .
docker run --name maxenceTP1-container -d -p 8080:80 maxencetp1-image
```

### c. Analyse comparative des méthodes
La méthode du point 5 (volumes) offre l'avantage des modifications en temps réel, permettant une plus grande flexibilité pendant le développement. En revanche, la méthode du point 6 (Dockerfile) nécessite de copier les fichiers après le démarrage, ce qui est moins flexible mais plus adapté pour la production car l'image est autonome et portable.

## 7. Utilisation d'une base de données

### Configuration de MySQL et phpMyAdmin
```bash
docker pull mysql:5.7
docker pull phpmyadmin/phpmyadmin
docker network create app
docker run --name mysql-container --network app -d \
    -e MYSQL_ROOT_PASSWORD=passw0rd -p 3306:3306 mysql:5.7
docker run --name phpmyadmin-container --network app -d \
    -e PMA_HOST=mysql-container -p 8081:80 phpmyadmin/phpmyadmin
```

## 8. Utilisation de Docker Compose

### a. Avantages de Docker Compose
Docker Compose simplifie significativement la gestion des conteneurs en permettant de :
- Définir l'ensemble de l'infrastructure dans un seul fichier
- Démarrer tous les services avec une seule commande
- Gérer facilement les dépendances entre les services

### b. Configuration de MySQL
La configuration de MySQL se fait élégamment via les variables d'environnement dans le fichier docker-compose.yml, permettant de définir :
- Le mot de passe root
- La base de données initiale
- Les utilisateurs et leurs droits

## 9. Isolation réseau entre conteneurs

### a. & b. Configuration réseau et inspection
Résultats de l'inspection des conteneurs :
```json
"pragma_backend": {
    "Gateway": "172.22.0.1",
    "IPAddress": "172.22.0.3"
},
"pragma_frontend": {
    "Gateway": "172.21.0.1",
    "IPAddress": "172.21.0.3"
}
```

### c. Application pratique
Cette configuration réseau est particulièrement pertinente dans une architecture à trois niveaux où :
- Le frontend ne doit pas avoir d'accès direct à la base de données
- La couche applicative sert d'intermédiaire sécurisé
- L'isolation réseau renforce la sécurité globale de l'application
