# Picswall Project

Ce projet permet de gérer et analyser des cryptomonnaies via une application web. Ce guide explique comment faire fonctionner le projet dans un autre environnement en utilisant Docker.

## Étapes pour faire fonctionner le projet Web crypto et le fournisseur d'identité :

### 1. Utilisation de Docker Desktop:

Commencez par ouvrir docker desktop:

### 2. Se mettre dans le dossier ou se trouve docker-compose:

Ouvrir un terminal dans le dossier cryptaka pour se mettre au niveau du fichier docker-compose.yml :

### 3. Lancer le fichier docker-compose.yml
Ensuite, exécutez docker-compose pour démarrer les services définis dans le fichier docker-compose.yml à l'aide de la commande suivante :

```bash
docker-compose up --build -d
```

### 4. Mettre le dump dans le container PostgreSQL
   Vous devez maintenant importer les données dans la base de données PostgreSQL. Pour ce faire, copiez le fichier de dump SQL dans le container PostgreSQL avec cette commande :
```bash
docker cp crypto_dump.sql postgres_service:/tmp/crypto_dump.sql
```

### 5. Se connecter au container PostgreSQL
   Accédez au container PostgreSQL en utilisant la commande suivante pour entrer dans une session bash à l'intérieur du container :
```bash
docker exec -it postgres_service bash
```

### 6. Importer le fichier SQL dans la base de données
Une fois dans le container, vous devez importer le fichier de dump SQL dans la base de données :
```bash
psql -U postgres -d crypto -f /tmp/crypto_dump.sql
```
### 7. Accéder à l'application via le navigateur
Ouvrez votre navigateur web et accédez à l'URL suivante pour utiliser l'application :

Page d'accueil 
http://localhost:8080/cryptaka-1.0-SNAPSHOT/

Front-office :

http://localhost:8080/cryptaka-1.0-SNAPSHOT/pages/frontoffice

Back-office :

http://localhost:8080/cryptaka-1.0-SNAPSHOT/pages/backoffice



