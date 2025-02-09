package mamt.project.cryptaka.models;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Commission {
    private int idCommission;
    private int idTransaction;
    private int idCrypto;
    private double pourcentage;
    private Timestamp daty;

    public Commission(int idCommission, int idTransaction, int idCrypto, double pourcentage, Timestamp daty) {
        this.idCommission = idCommission;
        this.idTransaction = idTransaction;
        this.idCrypto = idCrypto;
        this.pourcentage = pourcentage;
        this.daty = daty;
    }
    public Commission(int idTransaction, int idCrypto, double pourcentage) {
        this.idTransaction = idTransaction;
        this.idCrypto = idCrypto;
        this.pourcentage = pourcentage;
    }

    public int getIdCommission() { return idCommission; }
    public int getIdTransaction() { return idTransaction; }
    public int getIdCrypto() { return idCrypto; }
    public double getPourcentage() { return pourcentage; }
    public Timestamp getDaty() { return daty; }

    public void setIdTransaction(int idTransaction) { this.idTransaction = idTransaction; }
    public void setIdCrypto(int idCrypto) { this.idCrypto = idCrypto; }
    public void setPourcentage(double pourcentage) { this.pourcentage = pourcentage; }
    public void setDaty(Timestamp daty) { this.daty = daty; }

    // Récupérer toutes les commissions
    public static List<Commission> getAll(Connection connection) throws Exception {
        List<Commission> commissions = new ArrayList<>();
        String query = "SELECT * FROM commission";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                commissions.add(new Commission(
                        resultSet.getInt("idCommission"),
                        resultSet.getInt("idTransaction"),
                        resultSet.getInt("idCrypto"),
                        resultSet.getDouble("pourcentage"),
                        resultSet.getTimestamp("daty")
                ));
            }
        }
        return commissions;
    }

    // Récupérer une commission par son ID
    public static Commission getById(Connection connection, int idCommission) throws Exception {
        String query = "SELECT * FROM commission WHERE idCommission = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, idCommission);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Commission(
                            resultSet.getInt("idCommission"),
                            resultSet.getInt("idTransaction"),
                            resultSet.getInt("idCrypto"),
                            resultSet.getDouble("pourcentage"),
                            resultSet.getTimestamp("daty")
                    );
                }
            }
        }
        return null;
    }
    public static Commission get(Connection connection, int idTransaction, int idcrypto, Timestamp daty) throws Exception {
        String query = "SELECT * FROM commission WHERE idTransaction = ? and idcrypto = ? order by daty desc limit 1";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, idTransaction);
            statement.setInt(2, idcrypto);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Commission(
                            resultSet.getInt("idCommission"),
                            resultSet.getInt("idTransaction"),
                            resultSet.getInt("idCrypto"),
                            resultSet.getDouble("pourcentage"),
                            resultSet.getTimestamp("daty")
                    );
                }
            }
        }
        return null;
    }

    // Mettre à jour le pourcentage de commission
    public static void updatePourcentage(Connection connection, int idCommission, double newPourcentage) throws Exception {
        String query = "UPDATE commission SET pourcentage = ? WHERE idCommission = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDouble(1, newPourcentage);
            statement.setInt(2, idCommission);
            statement.executeUpdate();
        }
    }

    public static int insert(Connection connection, Commission commission) throws SQLException {
        String query = "INSERT INTO commission (idTransaction, idCrypto, pourcentage, daty) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, commission.getIdTransaction());
            statement.setInt(2, commission.getIdCrypto());
            statement.setDouble(3, commission.getPourcentage());
            statement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("L'insertion de la commission a échoué, aucune ligne ajoutée.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int newId = generatedKeys.getInt(1);
                    return newId;
                } else {
                    throw new SQLException("L'insertion de la commission a échoué, aucun ID généré.");
                }
            }
        }
    }

    public static List<HashMap<String, Object>> filtre (Connection connection, int type_analyse, int idcrypto, Timestamp date_min, Timestamp date_max) throws SQLException {
        List<HashMap<String, Object>> liste = new ArrayList<>();
        StringBuilder build = new StringBuilder();
        build.append("select idcrypto, nomcrypto ");

        if(type_analyse == 1) { // somme
            build.append(", sum(pourcentage) as bilan");
        }
        if(type_analyse == 2) { //moyenne
            build.append(", avg(pourcentage) as bilan");
        }

        build.append(" from v_commission where 1=1");

        if(idcrypto != 0) {
            build.append(" and idcrypto=? ");
        }

        if(date_min != null && date_min != null) {
            build.append(" and daty between ? and ?");
        }

        if (type_analyse == 1 || type_analyse == 2) {
            build.append(" GROUP BY idcrypto, nomcrypto ");
        }

        String query = build.toString();
        System.out.println("leo be "+query);

        try(PreparedStatement statement = connection.prepareStatement(query)) {
            int attribute = 1;
            if(idcrypto != 0) {
                statement.setInt(attribute++, idcrypto);
                System.out.println(attribute);
            }

            if(date_min != null && date_max != null) {
                statement.setTimestamp(attribute++, date_min);
                statement.setTimestamp(attribute++, date_max);
                System.out.println(attribute);
            }

            ResultSet res = statement.executeQuery();

            while(res.next()) {
                HashMap<String, Object> map = new HashMap<>();
                //build.append("select idcommission, idtransaction, nomtransaction, idcrypto, nomcrypto ");
                map.put("idcrypto", res.getInt("idcrypto"));
                map.put("nomcrypto", res.getString("nomcrypto"));
                if(type_analyse == 1 || type_analyse == 2) {
                    map.put("bilan", res.getDouble("bilan"));
                }
                liste.add(map);
            }

        } catch(SQLException e) {
            throw new SQLException("erreur filtre commission : "+e);
        }
        return liste;
//        idcommission | idtransaction | nomtransaction | idcrypto | nomcrypto | pourcentage |        daty
    }
}