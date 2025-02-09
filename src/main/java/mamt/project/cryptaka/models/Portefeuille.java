package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class Portefeuille {
    private int quantite;
    private int idCrypto;
    private int idUtilisateur;

    private Crypto crypto;

    public Crypto getCrypto() {
        return crypto;
    }

    public void setCrypto(Crypto crypto) {
        this.crypto = crypto;
    }

    public static List<Portefeuille> getAll(Connection connection) throws SQLException {
        List<Portefeuille> portefeuilles = new ArrayList<>();
        String query = "SELECT * FROM portefeuille";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Portefeuille portefeuille = new Portefeuille();
                portefeuille.setQuantite(resultSet.getInt("quantite"));
                portefeuille.setIdCrypto(resultSet.getInt("idCrypto"));
                portefeuille.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
                portefeuilles.add(portefeuille);
            }
        }
        return portefeuilles;
    }


    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public int getIdCrypto() {
        return idCrypto;
    }

    public void setIdCrypto(int idCrypto) {
        this.idCrypto = idCrypto;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public static List<Portefeuille> getAllCryptoByUser(Connection connection, int userId) throws SQLException {
        List<Portefeuille> portefeuilles = new ArrayList<>();
        String query = "SELECT * FROM v_portefeuille_utilisateur WHERE idUtilisateur = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Portefeuille portefeuille = new Portefeuille();
                    portefeuille.setQuantite(resultSet.getInt("quantite"));
                    portefeuille.setIdCrypto(resultSet.getInt("idCrypto"));
                    portefeuille.setIdUtilisateur(resultSet.getInt("idUtilisateur"));

                    Crypto crypto = new Crypto();
                    crypto.setNom(resultSet.getString("crypto"));
                    crypto.setIdCrypto(resultSet.getInt("idcrypto"));
                    portefeuille.setCrypto(crypto);


                    portefeuilles.add(portefeuille);
                }
            }
        }
        return portefeuilles;
    }


    public static Portefeuille getCryptoOfUser(Connection connection, int userId, int idCrypto) throws SQLException {
        String query = "SELECT * FROM portefeuille WHERE idUtilisateur = ? and idCrypto = ?";
        Portefeuille portefeuille = null;
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, idCrypto);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    portefeuille = new Portefeuille();
                    portefeuille.setQuantite(resultSet.getInt("quantite"));
                    portefeuille.setIdCrypto(resultSet.getInt("idCrypto"));
                    portefeuille.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
//                    portefeuilles.add(portefeuille);
                }
            }
        }
        return portefeuille;
    }

    
    public static void updateQuantite(int userId, int cryptoId, double newQuantite, Connection connection) throws SQLException {
        String query = "UPDATE portefeuille SET quantite = ? WHERE idUtilisateur = ? AND idCrypto = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDouble(1, newQuantite);
            statement.setInt(2, userId);
            statement.setInt(3, cryptoId);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Quantité mise à jour avec succès pour l'utilisateur ID: " + userId + " et la crypto ID: " + cryptoId);
            } else {
                System.out.println("Aucun portefeuille trouvé pour l'utilisateur ID: " + userId + " et la crypto ID: " + cryptoId);
            }
        }
    }
    public static boolean checkStock(int userId, int quantiteDemande, int cryptoId, Connection connection) throws SQLException {
        String query = "SELECT quantite FROM portefeuille WHERE idUtilisateur = ? AND idCrypto = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, cryptoId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int quantiteDisponible = resultSet.getInt("quantite");
                    if (quantiteDisponible >= quantiteDemande) {
                        System.out.println("Stock suffisant: Quantité disponible = " + quantiteDisponible);
                        return true;
                    } else {
                        System.out.println("Stock insuffisant: Quantité disponible = " + quantiteDisponible);
                        return false;
                    }
                } else {
                    System.out.println("Aucun portefeuille trouvé pour l'utilisateur ID: " + userId + " et la crypto ID: " + cryptoId);
                    return false;
                }
            }
        }
    }


}
