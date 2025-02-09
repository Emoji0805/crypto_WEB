package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class TypeAnalyse {

    int id_type_analyse;
    String nom_analyse;

    public TypeAnalyse(int id_type_analyse, String nom_analyse) {
        this.id_type_analyse = id_type_analyse;
        this.nom_analyse = nom_analyse;
    }

    public int getId_type_analyse() {
        return id_type_analyse;
    }

    public void setId_type_analyse(int id_type_analyse) {
        this.id_type_analyse = id_type_analyse;
    }

    public String getNom_analyse() {
        return nom_analyse;
    }

    public void setNom_analyse(String nom_analyse) {
        this.nom_analyse = nom_analyse;
    }

    public static List<TypeAnalyse> getAll(Connection connection) throws Exception {
        List<TypeAnalyse> typesAnalyse = new ArrayList<>();
        String query = "SELECT idTypeAnalyse, nomAnalyse FROM typeAnalyse";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                TypeAnalyse typeAnalyse = new TypeAnalyse(
                        resultSet.getInt("idTypeAnalyse"),
                        resultSet.getString("nomAnalyse")
                );
                typesAnalyse.add(typeAnalyse);
            }
        }

        return typesAnalyse;
    }

    public static TypeAnalyse getByID(Connection connection, int idTypeAnalyse) throws Exception {
        TypeAnalyse typeAnalyse = null;
        String query = "SELECT idTypeAnalyse, nomAnalyse FROM TypeAnalyse WHERE idTypeAnalyse = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, idTypeAnalyse);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    typeAnalyse = new TypeAnalyse(
                            resultSet.getInt("idTypeAnalyse"),
                            resultSet.getString("nomAnalyse")
                    );
                }
            }
        }

        return typeAnalyse;
    }

    public static Cours effectuerAnalyse(Connection connection, int typeAnalyse, Timestamp dateMin, Timestamp dateMax, String cryptoFilter) throws Exception {
        String query = "";
        Cours cours = null;

        String dateCondition = "";
        if (dateMin != null && dateMax != null) {
            dateCondition = "WHERE daty BETWEEN ? AND ? ";
        } else if (dateMin != null) {
            dateCondition = "WHERE daty >= ? ";
        } else if (dateMax != null) {
            dateCondition = "WHERE daty <= ? ";
        }

        switch (typeAnalyse) {
            case 1:
                query = "SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY co.valeur) AS result, co.idCrypto, cr.nom " +
                        "FROM cours co JOIN crypto cr ON co.idCrypto = cr.idCrypto " +
                        dateCondition + cryptoFilter +
                        " GROUP BY co.idCrypto, cr.nom";
                break;
            case 2:
                query = "SELECT MAX(co.valeur) AS result, co.idCrypto, cr.nom " +
                        "FROM cours co JOIN crypto cr ON co.idCrypto = cr.idCrypto " +
                        dateCondition + cryptoFilter +
                        " GROUP BY co.idCrypto, cr.nom";
                break;
            case 3:
                query = "SELECT MIN(co.valeur) AS result, co.idCrypto, cr.nom " +
                        "FROM cours co JOIN crypto cr ON co.idCrypto = cr.idCrypto " +
                        dateCondition + cryptoFilter +
                        " GROUP BY co.idCrypto, cr.nom";
                break;
            case 4:
                query = "SELECT AVG(co.valeur) AS result, co.idCrypto, cr.nom " +
                        "FROM cours co JOIN crypto cr ON co.idCrypto = cr.idCrypto " +
                        dateCondition + cryptoFilter +
                        " GROUP BY co.idCrypto, cr.nom";
                break;
            case 5:
                query = "SELECT STDDEV(co.valeur) AS result, co.idCrypto, cr.nom " +
                        "FROM cours co JOIN crypto cr ON co.idCrypto = cr.idCrypto " +
                        dateCondition + cryptoFilter +
                        " GROUP BY co.idCrypto, cr.nom";
                break;
            default:
                throw new IllegalArgumentException("Type d'analyse non valide.");
        }

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            int paramIndex = 1;
            if (dateMin != null) {
                statement.setTimestamp(paramIndex++, dateMin);
            }
            if (dateMax != null) {
                statement.setTimestamp(paramIndex++, dateMax);
            }

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                cours = new Cours();
                cours.setValeur(resultSet.getDouble("result"));
                cours.setIdCrypto(resultSet.getInt("idCrypto"));

                Crypto crypto = new Crypto();
                crypto.setIdCrypto(resultSet.getInt("idCrypto"));
                crypto.setNom(resultSet.getString("nom"));
                cours.setCrypto(crypto);

                return cours;
            } else {
                throw new Exception("Aucune donnée trouvée.");
            }
        }
    }



}
