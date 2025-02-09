package mamt.project.cryptaka.models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Cours {
        private int idCours;
        private double valeur;
        private Timestamp daty;

        private Crypto crypto;

        private int idCrypto;

        public static List<Cours> getAll(Connection connection) throws SQLException {
            List<Cours> coursList = new ArrayList<>();
            String query = "SELECT * FROM v_cours_crypto";
            try (PreparedStatement statement = connection.prepareStatement(query);
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Cours cours = new Cours();
                    Crypto crypto = new Crypto();

                    cours.setIdCours(resultSet.getInt("idCours"));
                    cours.setValeur(resultSet.getDouble("valeur"));
                    cours.setDaty(resultSet.getTimestamp("daty"));

                    crypto.setNom(resultSet.getString("nom_crypto"));
                    cours.setCrypto(crypto);

                    cours.setIdCrypto(resultSet.getInt("idCrypto"));
                    coursList.add(cours);
                }
            }
            return coursList;
        }
    public static List<Cours> getAllCrypto(Connection connection, int offset) throws SQLException {
        List<Cours> coursList = new ArrayList<>();
        String query = "SELECT * FROM cours limit 10 offset ?";
        try (PreparedStatement statement = connection.prepareStatement(query)){
             statement.setInt(1, offset);
             ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Cours cours = new Cours();
                cours.setIdCours(resultSet.getInt("idCours"));
                cours.setValeur(resultSet.getDouble("valeur"));
                cours.setDaty(resultSet.getTimestamp("daty"));
                cours.setIdCrypto(resultSet.getInt("idCrypto"));
                coursList.add(cours);
            }
        }
        return coursList;
    }
    public static void update(Cours cours, Connection connection) throws SQLException {
        String query = "UPDATE cours SET valeur = ?, daty = ?, idCrypto = ? WHERE idCours = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDouble(1, cours.getValeur());
            statement.setTimestamp(2, cours.getDaty());
            statement.setInt(3, cours.getIdCrypto());
            statement.setInt(4, cours.getIdCours());
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Cours with ID " + cours.getIdCours() + " updated successfully.");
            } else {
                System.out.println("No cours found with ID " + cours.getIdCours() + ".");
            }
        }
    }

    //mila asiana idCrypto
    public static Cours getLastCrypto(Connection connection, int idCrypto) throws SQLException {
        Cours cours = null;
        String query = "SELECT * FROM cours WHERE idCrypto = ? ORDER BY idCours DESC LIMIT 1";
        try (PreparedStatement statement = connection.prepareStatement(query)){
            statement.setInt(1, idCrypto);
            ResultSet resultSet = statement.executeQuery() ;
            if (resultSet.next()) {
                cours = new Cours();
                cours.setIdCours(resultSet.getInt("idCours"));
                cours.setValeur(resultSet.getDouble("valeur"));
                cours.setDaty(resultSet.getTimestamp("daty"));
                cours.setIdCrypto(resultSet.getInt("idCrypto"));
            }
        }

        return cours;
    }

    public static void insertCours(Connection connection, int idCrypto) throws SQLException {
        Balance balance = Balance.getById(connection, idCrypto);
        if (balance.getIdBalance() == 0) {
            System.out.println("Balance not found for crypto ID: " + idCrypto);
            return;
        }
        double newValue = balance.getMinPrix() + (Math.random() * (balance.getMaxPrix() - balance.getMinPrix()));

        String query = "INSERT INTO cours (valeur, daty, idCrypto) VALUES (?, NOW(), ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDouble(1, newValue);
            statement.setInt(2, idCrypto);
            statement.executeUpdate();
        }
    }


    public int getIdCours() {
            return idCours;
        }

    public Crypto getCrypto() {
        return crypto;
    }

    public void setCrypto(Crypto crypto) {
        this.crypto = crypto;
    }

    public void setIdCours(int idCours) {
            this.idCours = idCours;
        }

        public double getValeur() {
            return valeur;
        }

        public void setValeur(double valeur) {
            this.valeur = valeur;
        }

        public Timestamp getDaty() {
            return daty;
        }

        public void setDaty(Timestamp daty) {
            this.daty = daty;
        }

        public int getIdCrypto() {
            return idCrypto;
        }

        public void setIdCrypto(int idCrypto) {
            this.idCrypto = idCrypto;
        }

}
