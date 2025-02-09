create or replace view v_cours_crypto as
select c.*, cr.nom as nom_crypto
    from cours c
    join crypto cr on c.idcrypto = cr.idcrypto;

-- historique des ventes et achat
create or replace view v_historiqueVenteAchat_utilisateurs as
select he.*, c.nom as crypto_nom , t.nom as transaction_nom ,u.nom as utilisateur_nom, u.email from historiqueEchange he
    join utilisateurs u on he.idutilisateur = u.idutilisateur
    join transaction t on he.idtransaction = t.idtransaction
    join crypto c on he.idcrypto = c.idcrypto;

-- historique des retraits et depots
CREATE OR REPLACE VIEW v_historiqueRetraitDepot_utilisateurs as
select ht.daty, ht.idtransaction, t.nom as transaction_nom, u.idutilisateur, u.nom utilisateur_nom,u.email, ht.valeurs from historiquetransaction ht
JOIN transaction t on t.idtransaction = ht.idtransaction
JOIN utilisateurs u on u.idutilisateur = ht.idutilisateur;

-- requete pour avoir l'historique des ventes et achat
-- select * from v_historique_utilisateurs where idtransaction = 1 and daty = ? ;

CREATE OR REPLACE VIEW v_validation_transaction as
select vt.idValidation_transaction, ht.idhistoriquetransaction,u.idutilisateur,
       u.nom, ht.daty as date_transaction,
       ht.valeurs, t.nom as operation,t.idtransaction,
       v.description as type_validation
FROM validation_transaction vt
         JOIN historiquetransaction ht on vt.idhistoriquetransaction = ht.idhistoriquetransaction
         JOIN utilisateurs u ON u.idutilisateur = ht.idutilisateur
         JOIN transaction t ON ht.idtransaction = t.idtransaction
         LEFT JOIN validation v ON v.idvalidation = vt.idvalidation;


-- vue pour le portefeuille de l'utilitsateur
CREATE OR REPLACE VIEW v_portefeuille_utilisateur as
select c.idcrypto,c.nom as crypto, p.quantite, u.idutilisateur, u.nom ,u.fond from portefeuille p
JOIN crypto c ON c.idcrypto = p.idcrypto
JOIN utilisateurs u ON u.idutilisateur = p.idutilisateur;

-- vue des commissions
create or replace view v_commission as
select c.idcommission, t.idtransaction, t.nom as nomTransaction, cr.idcrypto, cr.nom as nomCrypto, c.pourcentage, c.daty
from commission c
         join transaction t on t.idTransaction = c.idTransaction
         join Crypto cr on cr.idCrypto = c.idCrypto;
