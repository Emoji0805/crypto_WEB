package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Crypto {
    private int idCrypto;
    private String nom;

    public static List<Crypto> getAll(Connection connection) throws SQLException {
        List<Crypto> cryptos = new ArrayList<>();
        String query = "SELECT * FROM Crypto";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Crypto crypto = new Crypto();
                crypto.setIdCrypto(resultSet.getInt("idCrypto"));
                crypto.setNom(resultSet.getString("nom"));
                cryptos.add(crypto);
            }
        }
        return cryptos;
    }

    public int getIdCrypto() {
        return idCrypto;
    }

    public void setIdCrypto(int idCrypto) {
        this.idCrypto = idCrypto;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}