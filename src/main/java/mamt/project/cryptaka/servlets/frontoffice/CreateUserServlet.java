package mamt.project.cryptaka.servlets.frontoffice;

//package com.mg.test.testsignup;

import mamt.project.cryptaka.utils.FirebaseUsing;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.net.URL;

@WebServlet("/createUser")
public class CreateUserServlet extends HttpServlet {

    private FirebaseUsing firebaseUsing;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Récupération du chemin du fichier de compte de service depuis le contexte ou définissez-le directement.
            String serviceAccountPath = getServletContext().getInitParameter("SERVICE_ACCOUNT_PATH");
            if (serviceAccountPath == null) {
                // Vous pouvez également définir directement le chemin ici.
                serviceAccountPath = "E:\\ITUniversity\\INFORMATIQUE\\S5\\Web-Service\\exam\\cryptaka\\src\\main\\webapp\\google-service.json";
            }
            firebaseUsing = new FirebaseUsing(serviceAccountPath);
        } catch (IOException e) {
            throw new ServletException("Erreur lors de l'initialisation de FirebaseUsing", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Récupération des paramètres envoyés en POST
        String email = req.getParameter("email");
        String nom = req.getParameter("nom");
        String password = req.getParameter("password");

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.println("Les paramètres 'email' et 'password' sont obligatoires.");
            return;
        }

        new Thread(() -> {
            try {
                // Remplacez par l'URL de votre action Symfony
                URL symfonyUrl = new URL("http://127.0.0.1:8000/api/test-mail");
                HttpURLConnection conn = (HttpURLConnection) symfonyUrl.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                conn.setConnectTimeout(5000);
                conn.setReadTimeout(5000);
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                // Construction du corps de la requête POST
                String postData = "email=" + URLEncoder.encode(email, "UTF-8")
                        + "&nom=" + URLEncoder.encode(nom, "UTF-8")
                        + "&mdp=" + URLEncoder.encode(password, "UTF-8");
                byte[] postDataBytes = postData.getBytes("UTF-8");

                try (OutputStream os = conn.getOutputStream()) {
                    os.write(postDataBytes);
                    os.flush();
                }

                int responseCode = conn.getResponseCode();
                System.out.println("Appel à Symfony terminé avec le code : " + responseCode);

                // Optionnel : lecture de la réponse
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        try {
            String uid = firebaseUsing.createUser(email, password, nom);
            out.println("Utilisateur créé avec UID: " + uid);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("Erreur lors de la création de l'utilisateur : " + e.getMessage());
        }
    }
}


