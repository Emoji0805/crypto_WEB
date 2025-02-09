package mamt.project.cryptaka.utils;

import com.google.cloud.firestore.*;
import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.HistoriqueEchange;
import mamt.project.cryptaka.models.Transaction;
import mamt.project.cryptaka.models.Utilisateur;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

public class HistoriqueEchangeListener {
    private Firestore db;
    private ListenerRegistration listenerTransaction;

    public HistoriqueEchangeListener() {
        try {
            FirebaseInit.initializeFirestore();
            db = FirebaseInit.getFirestore();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Erreur lors de l'initialisation de Firebase.");
        }
    }

    public void startListening() {
        CollectionReference transactionsRef = db.collection("historiqueechange");

        listenerTransaction = transactionsRef.addSnapshotListener((querySnapshot, e) -> {
            if (e != null) {
                System.out.println("❌ Erreur Firestore: " + e.getMessage());
                return;
            }

            if (querySnapshot != null) {
                for (DocumentChange dc : querySnapshot.getDocumentChanges()) {
                    if (dc.getType() == DocumentChange.Type.ADDED) {
                        DocumentSnapshot doc = dc.getDocument();

                        try (Connection conn = ConnexionPost.getConnectionPost()) {
                            if (conn == null) {
                                System.out.println("🚨 Connexion PostgreSQL échouée !");
                            } else {
                                System.out.println("✅ Connexion PostgreSQL réussie !");
                            }

                            com.google.cloud.Timestamp timestampFirestore = doc.getTimestamp("daty");
                            java.sql.Timestamp daty = timestampFirestore != null ? timestampFirestore.toSqlTimestamp() : null;

                            long idTransaction = doc.getLong("idtransaction");
                            int idTransactionInt = (int) idTransaction;

                            long idUtilisateur = doc.getLong("idutilisateur");
                            int idUtilisateurInt = (int) idUtilisateur;

                            long idCrypto = doc.getLong("idcrypto");
                            int idCryptoInt = (int) idCrypto;

                            long quantite = doc.getLong("quantite");
                            double quantiteDouble = (double) quantite;

                            System.out.println("📅 Date Firestore : " + doc.getTimestamp("daty"));
                            System.out.println("🔢 ID Transaction : " + doc.getLong("idtransaction"));
                            System.out.println("👤 ID Utilisateur : " + doc.getLong("idutilisateur"));
                            System.out.println("💰 Quantité : " + doc.getLong("quantite"));


                            if (idTransactionInt == 1){ //Achat
                                System.out.println("Tafiditra 1");
                                mamt.project.cryptaka.models.Transaction transaction= new mamt.project.cryptaka.models.Transaction();
                                transaction.transaction_achat(conn,quantiteDouble, idCryptoInt, idUtilisateurInt);
                                Utilisateur u = Utilisateur.getById(conn, idUtilisateurInt);

                                HistoriqueEchange mouvementStock = new HistoriqueEchange();
                                mouvementStock.setEntree(quantiteDouble);
                                mouvementStock.setSortie(0);
                                mouvementStock.setDaty(daty);
                                mouvementStock.setIdTransaction(idTransactionInt);
                                mouvementStock.setIdUtilisateur(idUtilisateurInt);
                                mouvementStock.setIdCrypto(idCryptoInt);
                                mouvementStock.setValeur_portefeuille(u.getFond());

                                HistoriqueEchange.insert(mouvementStock, conn);

                            }else if(idTransactionInt == 2){ //vente
                                System.out.println("Tafiditra 2");

                                System.out.println("📌 Avant transaction_vente()");
                                    mamt.project.cryptaka.models.Transaction transaction= new Transaction();
                                    transaction.transaction_vente(conn ,quantiteDouble,idCryptoInt,idUtilisateurInt);
                                System.out.println("✅ Après transaction_vente()");

                                Utilisateur u = Utilisateur.getById(conn, idUtilisateurInt);

                                HistoriqueEchange mouvementStock = new HistoriqueEchange();
                                mouvementStock.setEntree(0);
                                mouvementStock.setSortie(quantiteDouble);
                                mouvementStock.setDaty(daty);
                                mouvementStock.setIdTransaction(idTransactionInt);
                                mouvementStock.setIdUtilisateur(idUtilisateurInt);
                                mouvementStock.setIdCrypto(idCryptoInt);
                                mouvementStock.setValeur_portefeuille(u.getFond());

                                System.out.println("📌 Avant HistoriqueEchange.insert()");
                                HistoriqueEchange.insert(mouvementStock, conn);
                                System.out.println("✅ Après HistoriqueEchange.insert()");
                            }
                            System.out.println("✅ Échange inséré dans PostgreSQL : " + doc.getId());

                            doc.getReference().delete();
                            System.out.println("🗑️ Document supprimé de Firestore : " + doc.getId());

                        } catch (SQLException ex) {
                            ex.printStackTrace();
                            System.out.println("❌ Erreur lors de l'insertion en PostgreSQL");
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            }
        });
    }

    public void stopListening() {
        if (listenerTransaction != null) {
            listenerTransaction.remove();
            System.out.println("🛑 Listener Firestore arrêté.");
        }
    }
}
