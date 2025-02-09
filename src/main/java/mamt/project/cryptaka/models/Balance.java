package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Balance {
    private int idBalance;
    private double minPrix;
    private double maxPrix;
    private int idCrypto;

    public static Balance getById(Connection connection , int idCrypto)throws SQLException{
        Balance balance = new Balance();
        String query = "SELECT * FROM balance where idCrypto = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)){
            statement.setInt(1, idCrypto);
             ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                balance.setIdBalance(resultSet.getInt("idBalance"));
                balance.setMinPrix(resultSet.getDouble("minPrix"));
                balance.setMaxPrix(resultSet.getDouble("maxPrix"));
                balance.setIdCrypto(resultSet.getInt("idCrypto"));
            }
        }
        return balance;
    }
    public static List<Balance> getAll(Connection connection) throws SQLException {
        List<Balance> balances = new ArrayList<>();
        String query = "SELECT * FROM balance";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Balance balance = new Balance();
                balance.setIdBalance(resultSet.getInt("idBalance"));
                balance.setMinPrix(resultSet.getDouble("minPrix"));
                balance.setMaxPrix(resultSet.getDouble("maxPrix"));
                balance.setIdCrypto(resultSet.getInt("idCrypto"));
                balances.add(balance);
            }
        }
        return balances;
    }

    public int getIdBalance() {
        return idBalance;
    }

    public void setIdBalance(int idBalance) {
        this.idBalance = idBalance;
    }

    public double getMinPrix() {
        return minPrix;
    }

    public void setMinPrix(double minPrix) {
        this.minPrix = minPrix;
    }

    public double getMaxPrix() {
        return maxPrix;
    }

    public int getIdCrypto() {
        return idCrypto;
    }

    public void setIdCrypto(int idCrypto) {
        this.idCrypto = idCrypto;
    }

    public void setMaxPrix(double maxPrix) {
        this.maxPrix = maxPrix;
    }
}