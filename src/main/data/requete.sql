SELECT
    SUM(he.entree) AS total_achat,
    SUM(he.sortie) AS total_vente,
    u.nom,
    u.idutilisateur,
    u.email,
    (SELECT valeur_portefeuille
     FROM historiqueechange h2
     WHERE h2.idutilisateur = u.idutilisateur
       AND h2.daty <= '2025-02-01 13:42:00 '
     ORDER BY h2.daty DESC
                      LIMIT 1) AS valeur_portefeuille,
     (SELECT daty
         FROM historiqueechange h2
         WHERE h2.idutilisateur = u.idutilisateur
           AND h2.daty <= '2025-02-01 13:42:00 '
         ORDER BY h2.daty DESC
                          LIMIT 1) AS daty

FROM historiqueechange he
    JOIN utilisateurs u ON he.idutilisateur = u.idutilisateur
    WHERE he.daty <= '2025-02-01 13:42:00'
GROUP BY u.nom, u.idutilisateur,u.email;

