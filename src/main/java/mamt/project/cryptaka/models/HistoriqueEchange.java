package mamt.project.cryptaka.models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoriqueEchange {
    private int idHistoriqueEchange;
    private double entree;
    private double sortie;
    private Timestamp daty;
    private int idTransaction;
    private int idUtilisateur;
    private int idCrypto;
    private Transaction transaction;
    private Crypto crypto;
    private double valeur_portefeuille;
    private Utilisateur utilisateur;
    // Getters and Setters

    public double getValeur_portefeuille() {
        return valeur_portefeuille;
    }

    public void setValeur_portefeuille(double valeur_portefeuille) {
        this.valeur_portefeuille = valeur_portefeuille;
    }

    public Crypto getCrypto() {
        return crypto;
    }

    public void setCrypto(Crypto crypto) {
        this.crypto = crypto;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public int getIdHistoriqueEchange() {
        return idHistoriqueEchange;
    }

    public void setIdHistoriqueEchange(int idHistoriqueEchange) {
        this.idHistoriqueEchange = idHistoriqueEchange;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public Timestamp getDaty() {
        return daty;
    }

    public void setDaty(Timestamp daty) {
        this.daty = daty;
    }

    public int getIdTransaction() {
        return idTransaction;
    }

    public void setIdTransaction(int idTransaction) {
        this.idTransaction = idTransaction;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public int getIdCrypto() {
        return idCrypto;
    }

    public void setIdCrypto(int idCrypto) {
        this.idCrypto = idCrypto;
    }

    // Method to retrieve all records
    public static List<HistoriqueEchange> getAll(Connection connection) throws SQLException {
        List<HistoriqueEchange> mouvements = new ArrayList<>();
        String query = "SELECT * FROM historiqueechange";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                HistoriqueEchange mouvement = new HistoriqueEchange();
                mouvement.setIdHistoriqueEchange(resultSet.getInt("idHistoriqueEchange"));
                mouvement.setEntree(resultSet.getDouble("entree"));
                mouvement.setSortie(resultSet.getDouble("sortie"));
                mouvement.setDaty(resultSet.getTimestamp("daty"));
                mouvement.setIdTransaction(resultSet.getInt("idTransaction"));
                mouvement.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
                mouvement.setIdCrypto(resultSet.getInt("idCrypto"));
                mouvements.add(mouvement);
            }
        }
        return mouvements;
    }


    public List<HistoriqueEchange> getHistoriqueAchatVentsAllUsers(Connection connection, Integer id_transaction,Integer id_crypto, Integer id_utilisateur, Date date_debut, Date date_fin) throws SQLException {
        List<HistoriqueEchange> historiqueEchanges = new ArrayList<>();
        String query = "SELECT * FROM v_historiqueVenteAchat_utilisateurs WHERE 1=1";

        List<Object> parameters = new ArrayList<>();

        if(id_utilisateur != null){
            query += " AND idutilisateur = ?";
            parameters.add(id_utilisateur);
        }
        if(id_crypto != null){
            query += " AND idcrypto = ?";
            parameters.add(id_crypto);
        }
        if (id_transaction != null) {
            query += " AND idtransaction = ?";
            parameters.add(id_transaction);
        }
        if (date_debut != null) {
            query += " AND daty >= ?";
            parameters.add(date_debut);
        }
        if (date_fin != null) {
            query += " AND daty <= ?";
            parameters.add(date_fin);
        }

        System.out.println("Query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    HistoriqueEchange historiqueEchange = new HistoriqueEchange();

                    Transaction transaction = new Transaction();
                    transaction.setNom(resultSet.getString("transaction_nom"));
                    transaction.setIdTransaction(resultSet.getInt("idtransaction"));

                    historiqueEchange.setTransaction(transaction);

                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setNom(resultSet.getString("utilisateur_nom"));
                    utilisateur.setEmail(resultSet.getString("email"));
                    utilisateur.setIdUtilisateur(resultSet.getInt("idutilisateur"));
                    historiqueEchange.setUtilisateur(utilisateur);

                    Crypto crypto = new Crypto();
                    crypto.setNom(resultSet.getString("crypto_nom"));
                    crypto.setIdCrypto(resultSet.getInt("idcrypto"));
                    historiqueEchange.setCrypto(crypto);

                    historiqueEchange.setDaty(resultSet.getTimestamp("daty"));
                    historiqueEchange.setIdTransaction(resultSet.getInt("idTransaction"));

                    historiqueEchanges.add(historiqueEchange);
                }
            }
        }
        return historiqueEchanges;
    }


    public List<HistoriqueEchange> getTotalAchatVenteAllUsers(Connection connection, Timestamp date_max) {
        List<HistoriqueEchange> historiqueList = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT " +
                "    SUM(he.entree) AS total_achat, " +
                "    SUM(he.sortie) AS total_vente, " +
                "    u.nom, " +
                "    u.email, " +
                "    u.idutilisateur, " +
                "    (SELECT valeur_portefeuille " +
                "     FROM historiqueechange h2 " +
                "     WHERE h2.idutilisateur = u.idutilisateur ");

        if (date_max != null) {
            query.append(" AND h2.daty <= ? ");
        }

        query.append("     ORDER BY h2.daty DESC " +
                "     LIMIT 1) AS valeur_portefeuille ," +

                "    (SELECT daty " +
                "     FROM historiqueechange h2 " +
                "     WHERE h2.idutilisateur = u.idutilisateur ");

        if (date_max != null) {
            query.append(" AND h2.daty <= ? ");
        }

        query.append("     ORDER BY h2.daty DESC " +
                "     LIMIT 1) AS daty " +


                "FROM historiqueechange he " +
                "JOIN utilisateurs u ON he.idutilisateur = u.idutilisateur ");

        if (date_max != null) {
            query.append(" WHERE he.daty <= ? ");
        }

        query.append("GROUP BY u.nom, u.idutilisateur, u.email;");
        System.out.println(query);

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;

            if (date_max != null) {
                statement.setTimestamp(paramIndex++, date_max);
                statement.setTimestamp(paramIndex++, date_max);
                statement.setTimestamp(paramIndex++, date_max);
            }

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                HistoriqueEchange historiqueEchange = new HistoriqueEchange();

                Transaction transaction = new Transaction();
                transaction.setTotal_achat(resultSet.getDouble("total_achat"));
                transaction.setTotal_vente(resultSet.getDouble("total_vente"));
                historiqueEchange.setTransaction(transaction);

                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setNom(resultSet.getString("nom"));
                utilisateur.setIdUtilisateur(resultSet.getInt("idutilisateur"));
                utilisateur.setEmail(resultSet.getString("email"));
                historiqueEchange.setUtilisateur(utilisateur);

                historiqueEchange.setValeur_portefeuille(resultSet.getDouble("valeur_portefeuille"));
                historiqueEchange.setDaty(resultSet.getTimestamp("daty"));

                historiqueList.add(historiqueEchange);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de l'exécution de la requête SQL", e);
        }

        return historiqueList;
    }


    public static void insert(HistoriqueEchange mouvement, Connection connection) throws SQLException {
        String query = "INSERT INTO historiqueechange (entree, sortie, daty, idTransaction, idUtilisateur, idCrypto, valeur_portefeuille) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setDouble(1, mouvement.getEntree());
            statement.setDouble(2, mouvement.getSortie());
            statement.setTimestamp(3, mouvement.getDaty());
            statement.setInt(4, mouvement.getIdTransaction());
            statement.setInt(5, mouvement.getIdUtilisateur());
            statement.setInt(6, mouvement.getIdCrypto());
            statement.setDouble(7, mouvement.getValeur_portefeuille());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        mouvement.setIdHistoriqueEchange(generatedKeys.getInt(1));
                        System.out.println("MouvementStock inserted with ID: " + mouvement.getIdHistoriqueEchange());
                    }
                }
            }
        }
    }
}