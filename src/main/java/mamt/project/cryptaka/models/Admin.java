package mamt.project.cryptaka.models;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Admin {
    private int idAdmin;
    private String nomAdmin;
    private String mdp;

    public int getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getNomAdmin() {
        return nomAdmin;
    }

    public void setNomAdmin(String nomAdmin) {
        this.nomAdmin = nomAdmin;
    }



    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }



    public static Admin login(Connection connection, String prenomAdmin, String mdp) throws SQLException {
        String sql = "SELECT idAdmin, nomAdmin, mdp FROM admin WHERE nomAdmin = ? AND mdp = ?";
        Admin membre = null;

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, prenomAdmin);
            preparedStatement.setString(2, mdp);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    membre = new Admin();
                    membre.setIdAdmin(resultSet.getInt("idAdmin"));
                    membre.setNomAdmin(resultSet.getString("nomAdmin"));
                    membre.setMdp(resultSet.getString("mdp")); // Si tu ne veux pas renvoyer le mot de passe, supprime cette ligne.
                }
            }
        } catch (SQLException e) {
            System.out.println("Erreur lors de la tentative de connexion : " + e.getMessage());
            throw e;
        }
        return membre;
    }

}

