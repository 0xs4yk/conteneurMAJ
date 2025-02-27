5. 

docker pull nginx
docker images
mkdir maxenceTP1
cd maxenceTP1
echo "<h1>MAXENCE LANCOSME</h1>" > index.html
docker run --name maxenceTP1 -d -p 8080:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx
docker stop maxenceTP1
docker rm maxenceTP1
docker run --name maxenceTP1 -d -p 8080:80 nginx
docker cp index.html maxenceTP1:/usr/share/nginx/html/index.html

6. 

docker build -t maxencetp1-image .
docker run --name maxenceTP1-container -d -p 8080:80 maxencetp1-image
La méthode 5 permet des modifications en temps réel avec des volumes, tandis que la méthode 6 nécessite de copier les fichiers après le démarrage, ce qui est moins flexible.

7.

docker pull mysql:5.7
docker pull phpmyadmin/phpmyadmin

Creation d'un network car cela ne marche pas bizarrement, DNS ?

docker network create app
docker run --name mysql-container --network app -d -e MYSQL_ROOT_PASSWORD=passw0rd -p 3306:3306 mysql:5.7
docker run --name phpmyadmin-container --network app -d -e PMA_HOST=mysql-container -p 8081:80 phpmyadmin/phpmyadmin

8. 

maxenceTP1/docker-compose.yml
docker-compose up -d

a. Le fichier docker-compose.yml simplifie la gestion des conteneurs en les configurant tous dans un seul fichier. On peut démarrer tout avec une seule commande.

b. On configure MySQL facilement en utilisant des variables d'environnement dans le fichier docker-compose.yml pour définir le mot de passe root, la base de données, et l'utilisateur dès le démarrage.

9.

maxenceTP1/pragma/docker-compose.yml

docker inspect <id-container>

"pragma_backend":
    "Gateway": "172.22.0.1",
    "IPAddress": "172.22.0.3",



"pragma_frontend":
    "Gateway": "172.21.0.1",
    "IPAddress": "172.21.0.3",


L'objectif ici est de limiter les accès réseau entre les services pour mieux contrôler la sécurité et l'accès aux données sensibles.