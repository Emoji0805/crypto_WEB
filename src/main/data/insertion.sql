INSERT INTO Crypto (nom) VALUES
                             ('Bitcoin'),
                             ('Ethereum'),
                             ('Ripple'),
                             ('Litecoin'),
                             ('Cardano'),
                             ('Solana'),
                             ('Polkadot'),
                             ('Dogecoin'),
                             ('Shiba Inu'),
                             ('Avalanche');

INSERT INTO utilisateurs (nom, email, mdp, fond) VALUES
                                                     ('Mamihery', 'mamihery.rabiazamaholy@gmail.com', encode(digest('2003', 'sha1'), 'hex'), 10);
                                                     ('Bob', 'bob@example.com', 'password456', 10000.00),
                                                     ('Charlie', 'charlie@example.com', 'password789', 15000.00),
                                                     ('Mamt', 'mamt@example.com', 'mamt', 5000.00);

INSERT INTO portefeuille (quantite,idCrypto,idUtilisateur) VALUES
                                                               (0,2,3);

INSERT INTO cours (valeur, daty, idCrypto) VALUES
                                               (40000.00, '2025-01-01 12:00:00', 1),  -- Bitcoin
                                               (2000.00, '2025-01-01 12:00:00', 2),   -- Ethereum
                                               (0.50, '2025-01-01 12:00:00', 3),      -- Ripple
                                               (100.00, '2025-01-01 12:00:00', 4),    -- Litecoin
                                               (1.00, '2025-01-01 12:00:00', 5);      -- Cardano
INSERT INTO transaction (nom) VALUES
                                  ('Achat'),
                                  ('Vente'),
                                  ('Depot'),
                                  ('Retrait');
INSERT INTO balance (minPrix, maxPrix, idCrypto) VALUES
                                                     (35000.00, 45000.00, 1),  -- Bitcoin
                                                     (1800.00, 2200.00, 2),    -- Ethereum
                                                     (0.40, 0.60, 3),          -- Ripple
                                                     (90.00, 110.00, 4),       -- Litecoin
                                                     (0.80, 1.20, 5);          -- Cardano
INSERT INTO historiqueEchange (entree, sortie, daty, idTransaction, idUtilisateur, idCrypto) VALUES
                                                                                              (2.00, 0.00, '2025-01-01 12:00:00', 1, 1, 1),  -- Alice achète 2 Bitcoin
                                                                                              (0.00, 5.00, '2025-01-02 14:00:00', 2, 2, 2),  -- Bob vend 5 Ethereum
                                                                                              (1.00, 0.00, '2025-01-03 16:00:00', 3, 3, 3);  -- Charlie échange 1 Ripple
INSERT INTO TypeAnalyse (nomAnalyse) VALUES
                                         ('1er quartile'),
                                         ('Maximum'),
                                         ('Minimum'),
                                         ('Moyenne'),
                                         ('Ecart-type');
INSERT INTO validation(description) VALUES
                                        ('Valider'),
                                        ('Annuler');

INSERT INTO commission (idTransaction, idCrypto, pourcentage, daty) VALUES
                                                                        (1, 1, 0.5, '2024-02-01 10:30:00'), -- Commission de 0.5% pour une transaction d'achat de la crypto 1
                                                                        (2, 1, 0.7, '2024-02-02 12:45:00'), -- Commission de 0.7% pour une transaction de vente de la crypto 1
                                                                        (1, 2, 0.6, '2024-02-03 14:20:00'), -- Commission de 0.6% pour une transaction d'achat de la crypto 2
                                                                        (2, 2, 0.8, '2024-02-04 16:10:00'), -- Commission de 0.8% pour une transaction de vente de la crypto 2
                                                                        (2, 3, 0.55, '2024-02-05 09:00:00'), -- Commission de 0.55% pour une transaction d'achat de la crypto 3
                                                                        (1, 3, 0.75, '2024-02-06 11:30:00'); -- Commission de 0.75% pour une transaction de vente de la crypto 3

INSERT INTO Admin (nomAdmin,mdp) VALUES
    ('admin','admin');

-- drop table Crypto cascade ;
-- drop table utilisateurs cascade ;
-- drop table portefeuille cascade ;
-- drop table cours cascade ;
-- drop table transaction cascade ;
-- drop table balance cascade ;
-- drop table historiqueEchange cascade ;
-- drop table historiqueTransaction cascade ;
-- drop table TypeAnalyse cascade ;
