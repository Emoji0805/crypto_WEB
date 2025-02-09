# Utiliser une image WildFly comme base
FROM jboss/wildfly:latest

# Définir le répertoire de déploiement
WORKDIR /opt/jboss/wildfly/standalone/deployments/

# Copier le fichier WAR dans le répertoire de déploiement
COPY target/cryptaka-1.0-SNAPSHOT.war .

# Exposer le port HTTP standard de WildFly
EXPOSE 8080

# Commande par défaut pour démarrer le serveur
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
