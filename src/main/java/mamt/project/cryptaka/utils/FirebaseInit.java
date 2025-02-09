package mamt.project.cryptaka.utils;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import com.google.cloud.firestore.Firestore;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class FirebaseInit {
    private static Firestore firestore;

    public static Firestore initializeFirestore() throws IOException {
        if (firestore == null) {
            InputStream serviceAccount = new FileInputStream("src/main/resources/firebase-config.json");

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("✅ Firebase connecté !");
            }else {
                System.out.println("⚠️ Firebase déjà initialisé.");
            }

            firestore = FirestoreClient.getFirestore();
        }
        return firestore;
    }

    public static Firestore getFirestore() {
        if (firestore == null) {
            throw new IllegalStateException("Firebase n'est pas encore initialisé.");
        }
        return firestore;
    }
}
