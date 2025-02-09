package mamt.project.cryptaka.utils;

//package com.mg.test.models;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.WriteResult;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.Map;

public class FirebaseUsing {
    private FirebaseAuth auth;
    private Firestore firestore;
    private DatabaseReference realtimeDb;

    public FirebaseUsing(String serviceAccountPath) throws IOException {
        FileInputStream serviceAccount = new FileInputStream(serviceAccountPath);

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://crypto-test-50468-default-rtdb.firebaseio.com")
                .build();

        FirebaseApp.initializeApp(options);
        this.auth = FirebaseAuth.getInstance();

        FirestoreOptions firestoreOptions = FirestoreOptions.getDefaultInstance().toBuilder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .build();

        this.firestore = firestoreOptions.getService();
        this.realtimeDb = FirebaseDatabase.getInstance().getReference();
    }

    public String createUser(String email, String password, String nom) throws Exception {
        UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                .setEmail(email)
                .setDisplayName(nom)
                .setPassword(password);

        UserRecord userRecord = auth.createUser(request);
        return userRecord.getUid();
    }

    public void syncLocalToFirestore(String collectionName, String documentId, Map<String, Object> data) throws ExecutionException, InterruptedException {
        DocumentReference docRef = firestore.collection(collectionName).document(documentId);
        WriteResult result = docRef.set(data).get();
        System.out.println("Data synced at: " + result.getUpdateTime());
    }
}

