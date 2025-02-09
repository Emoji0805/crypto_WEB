CREATE TABLE Crypto(
                       idCrypto SERIAL,
                       nom VARCHAR(50) ,
                       PRIMARY KEY(idCrypto)
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;


CREATE TABLE utilisateurs(
                             idUtilisateur SERIAL,
                             nom VARCHAR(50) ,
                             email VARCHAR(150) ,
                             mdp VARCHAR(50) ,
                             fond DOUBLE PRECISION ,
                             PRIMARY KEY(idUtilisateur)
);

CREATE TABLE portefeuille(
                             quantite DOUBLE PRECISION,
                             idCrypto INTEGER,
                             idUtilisateur INTEGER NOT NULL,
                             FOREIGN KEY(idCrypto) REFERENCES Crypto(idCrypto),
                             FOREIGN KEY(idUtilisateur) REFERENCES utilisateurs(idUtilisateur)
);


CREATE TABLE cours(
                      idCours SERIAL,
                      valeur DOUBLE PRECISION,
                      daty TIMESTAMP,
                      idCrypto INTEGER,
                      PRIMARY KEY(idCours),
                      FOREIGN KEY(idCrypto) REFERENCES Crypto(idCrypto)
);

CREATE TABLE transaction(
                            idTransaction SERIAL,
                            nom VARCHAR(50) ,
                            PRIMARY KEY(idTransaction)
);

CREATE TABLE balance(
                        idBalance SERIAL,
                        minPrix DOUBLE PRECISION,
                        maxPrix DOUBLE PRECISION,
                        idCrypto INTEGER,
                        PRIMARY KEY(idBalance),
                        FOREIGN KEY(idCrypto) REFERENCES Crypto(idCrypto)
);

CREATE TABLE validation_transaction(
    idValidation_transaction serial,
    idHistoriqueTransaction int,
    idValidation int,
    PRIMARY KEY(idValidation_transaction),
    FOREIGN KEY(idHistoriqueTransaction) REFERENCES historiqueTransaction(idHistoriqueTransaction),
    FOREIGN KEY(idValidation) REFERENCES validation(idValidation)
);

CREATE TABLE validation(
    idValidation SERIAL,
    description VARCHAR(60),
    PRIMARY KEY (idValidation)
);

--historique
CREATE TABLE historiqueEchange(
                               idHistoriqueEchange SERIAL,
                               entree DOUBLE PRECISION,
                               sortie DOUBLE PRECISION,
                               daty TIMESTAMP,
                               idTransaction INTEGER,
                               idUtilisateur INTEGER,
                               valeur_portefeuille double precision,
                               idCrypto INTEGER,
                               PRIMARY KEY(idHistoriqueEchange),
                               FOREIGN KEY(idTransaction) REFERENCES transaction(idTransaction),
                               FOREIGN KEY(idUtilisateur) REFERENCES utilisateurs(idUtilisateur),
                               FOREIGN KEY(idCrypto) REFERENCES Crypto(idCrypto)
);

CREATE TABLE historiqueTransaction(
                               idHistoriqueTransaction SERIAL,
                               daty TIMESTAMP,
                               idTransaction INTEGER,
                               idUtilisateur INTEGER,
                               valeurs DOUBLE PRECISION,
                               PRIMARY KEY(idHistoriqueTransaction),
                               FOREIGN KEY(idTransaction) REFERENCES transaction(idTransaction),
                               FOREIGN KEY(idUtilisateur) REFERENCES utilisateurs(idUtilisateur)
);

CREATE TABLE TypeAnalyse (
                             idTypeAnalyse SERIAL PRIMARY KEY,
                             nomAnalyse VARCHAR(50) NOT NULL
);

CREATE TABLE commission (
                            idCommission serial primary key,
                            idTransaction int references transaction(idTransaction),
                            idCrypto INT REFERENCES Crypto(idCrypto),
                            pourcentage double precision,
                            daty timestamp
);

CREATE TABLE Admin(
                      idAdmin SERIAL PRIMARY KEY ,
                      nomAdmin VARCHAR(50),
                      mdp VARCHAR(50)
);

