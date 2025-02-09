package mamt.project.cryptaka.utils;

import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Test {

    public static void addTransaction(Firestore db) {
        try {
            db = FirestoreClient.getFirestore();

            // 🔥 Créer un document
            Map<String, Object> transaction = new HashMap<>();
            transaction.put("daty", "2025-02-07 11:05:00");
            transaction.put("idtransaction", 3);
            transaction.put("idutilisateur", 3);
            transaction.put("valeurs", 1500.0);

            db.collection("historiquetransaction")
                    .add(transaction)
                    .get();

            System.out.println("✅ Transaction ajoutée dans Firestore !");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
        FirebaseInit.initializeFirestore();
        Firestore db = FirebaseInit.getFirestore();
        addTransaction(db);
    }

}
