package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Utilisateur {
    private int idUtilisateur;
    private String nom;
    private String email;
    private String mdp;
    private double fond;

    private Portefeuille portefeuille;

    public Portefeuille getPortefeuille() {
        return portefeuille;
    }

    public void setPortefeuille(Portefeuille portefeuille) {
        this.portefeuille = portefeuille;
    }

    public static List<Utilisateur> getAll(Connection connection) throws SQLException {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String query = "SELECT * FROM utilisateurs";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
                utilisateur.setNom(resultSet.getString("nom"));
                utilisateur.setEmail(resultSet.getString("email"));
                utilisateur.setMdp(resultSet.getString("mdp"));
                utilisateur.setFond(resultSet.getDouble("fond"));

                utilisateurs.add(utilisateur);
            }
        }
        return utilisateurs;
    }
    public static void updateFondByUser(int userId, double newFond, Connection connection) throws SQLException {
        String query = "UPDATE utilisateurs SET fond = ? WHERE idUtilisateur = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDouble(1, newFond);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Fond updated successfully for user ID: " + userId);
            } else {
                System.out.println("No user found with ID: " + userId);
            }
        }
    }
    public static boolean checkFond(int userId, double fondDemande, Connection connection) throws SQLException {
        String query = "SELECT fond FROM Utilisateurs WHERE idUtilisateur = ? ";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int fondDispo = resultSet.getInt("fond");
                    if (fondDispo >= fondDemande) {
                        System.out.println("Stock suffisant: Quantité disponible = " + fondDispo);
                        return true;
                    } else {
                        System.out.println("Stock insuffisant: Quantité disponible = " + fondDispo);
                        return false;
                    }
                } else {
                    System.out.println("Aucun portefeuille trouvé pour l'utilisateur ID: " + userId );
                    return false;
                }
            }
        }
    }
    public static Utilisateur getById( Connection connection,Integer idUtilisateur) throws SQLException {
        String query = "SELECT * FROM utilisateurs WHERE idUtilisateur = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, idUtilisateur);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
                    utilisateur.setNom(resultSet.getString("nom"));
                    utilisateur.setEmail(resultSet.getString("email"));
                    utilisateur.setMdp(resultSet.getString("mdp"));
                    utilisateur.setFond(resultSet.getDouble("fond"));
                    return utilisateur;
                } else {
                    System.out.println("Aucun utilisateur trouvé avec l'ID: " + idUtilisateur);
                    return null;
                }
            }
        }
    }


    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public double getFond() {
        return fond;
    }

    public void setFond(double fond) {
        this.fond = fond;
    }
}
