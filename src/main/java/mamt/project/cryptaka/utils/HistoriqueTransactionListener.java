package mamt.project.cryptaka.utils;

import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.HistoriqueTransaction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import com.google.cloud.Timestamp;


public class HistoriqueTransactionListener {
    private Firestore db;
    private ListenerRegistration listenerTransaction;

    public HistoriqueTransactionListener() {
        try {
            FirebaseInit.initializeFirestore();
            db = FirebaseInit.getFirestore();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'initialisation de Firebase.");
        }
    }

    public void startListening() {
        CollectionReference transactionsRef = db.collection("historiquetransaction");

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
                                System.out.println("La connexion PostgreSQL est nulle.");
                            } else {
                                System.out.println("Connexion PostgreSQL réussie.");
                            }


                            Timestamp timestampFirestore = doc.getTimestamp("daty");
                            java.sql.Timestamp daty = timestampFirestore != null ? timestampFirestore.toSqlTimestamp() : null;

//                            Timestamp daty = Timestamp.valueOf(datyStr.replace("T", " ") + ":00");
                            long idTransaction = doc.getLong("idtransaction");
                            int idTransactionInt = (int) idTransaction;

                            long idUtilisateur = doc.getLong("idutilisateur");
                            int idUtilisateurInt = (int) idUtilisateur;

                            long valeur = doc.getLong("valeurs");
                            double valeurDouble = (double) valeur;

//                            long idUtilisateur = doc.getLong("idutilisateur");
//                            int idUtilisateurInt = (int) idUtilisateur;
//                            double valeurs = doc.getDouble("valeurs");

                            System.out.println(idTransaction);
                            System.out.println(idUtilisateur);
                            System.out.println(valeur);

                            // 📌 Créer un objet HistoriqueTransaction
                            HistoriqueTransaction historique = new HistoriqueTransaction();
                            historique.setDaty(daty);
                            historique.setIdTransaction(idTransactionInt);
                            historique.setIdUtilisateur(idUtilisateurInt);
                            historique.setValeurs(valeurDouble);

                            // 💾 Insérer dans PostgreSQL
                            HistoriqueTransaction.insert(historique, conn);
                            System.out.println("✅ Transaction insérée : " + doc.getId());

                            // 🗑️ Supprimer le document Firestore après insertion
                            doc.getReference().delete();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                            System.out.println("❌ Erreur lors de l'insertion en PostgreSQL");
                        } catch (Exception ex) {
                            throw new RuntimeException(ex);
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
