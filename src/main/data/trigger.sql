-- Création de la fonction du trigger
CREATE OR REPLACE FUNCTION ajouter_crypto_portefeuille()
RETURNS TRIGGER AS $$
BEGIN
    -- Insérer chaque crypto existant dans la table portefeuille avec une quantité de 0
INSERT INTO portefeuille (quantite, idCrypto, idUtilisateur)
SELECT 0, c.idCrypto, NEW.idUtilisateur
FROM Crypto c;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger qui s'exécute après l'insertion d'un utilisateur
CREATE TRIGGER trigger_ajout_portefeuille
    AFTER INSERT ON utilisateurs
    FOR EACH ROW
    EXECUTE FUNCTION ajouter_crypto_portefeuille();


-- trigger pour inserer dans validation_transaction apres insertion dans historiquetransaction
CREATE OR REPLACE FUNCTION insert_into_validation_transaction()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO validation_transaction (idhistoriquetransaction, idvalidation)
VALUES (NEW.idhistoriquetransaction, NULL);

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_historiquetransaction
    AFTER INSERT ON historiquetransaction
    FOR EACH ROW
    EXECUTE FUNCTION insert_into_validation_transaction();
