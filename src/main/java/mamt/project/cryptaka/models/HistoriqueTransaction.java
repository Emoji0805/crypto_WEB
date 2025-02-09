package mamt.project.cryptaka.models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoriqueTransaction {
    private int idHistoriqueTransaction;
    private Timestamp daty;
    private int idTransaction;
    private int idUtilisateur;
    private int idCrypto;
    private double valeurs;
    Transaction transaction;
    Utilisateur utilisateur;

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public double getValeurs() {
        return valeurs;
    }

    public void setValeurs(double valeurs) {
        this.valeurs = valeurs;
    }

    // Getters and Setters
    public int getIdHistoriqueTransaction() {
        return idHistoriqueTransaction;
    }

    public void setIdHistoriqueTransaction(int idHistoriqueTransaction) {
        this.idHistoriqueTransaction = idHistoriqueTransaction;
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


    public HistoriqueTransaction(int idTransaction, int idUtilisateur,Timestamp daty,  double valeurs) {
        this.daty = daty;
        this.idTransaction = idTransaction;
        this.idUtilisateur = idUtilisateur;
        this.valeurs = valeurs;
    }

    public HistoriqueTransaction() {
    }

    // Method to retrieve all records
    public static List<HistoriqueTransaction> getAll(Connection connection) throws SQLException {
        List<HistoriqueTransaction> mouvements = new ArrayList<>();
        String query = "SELECT * FROM historiquetransaction";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                HistoriqueTransaction historique = new HistoriqueTransaction();
                historique.setIdHistoriqueTransaction(resultSet.getInt("idHistoriqueTransaction"));
                historique.setDaty(resultSet.getTimestamp("daty"));
                historique.setIdTransaction(resultSet.getInt("idTransaction"));
                historique.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
                mouvements.add(historique);
            }
        }
        return mouvements;
    }


    public List<HistoriqueTransaction> getHistoriqueRetraitDepotAllUsers(Connection connection, Integer id_transaction, Integer idUtilisateur,Timestamp date) throws SQLException {
        List<HistoriqueTransaction> historiqueEchanges = new ArrayList<>();
        String query = "SELECT * FROM v_historiqueRetraitDepot_utilisateurs WHERE 1=1";

        List<Object> parameters = new ArrayList<>();

        if (id_transaction != null) {
            query += " AND idtransaction = ?";
            parameters.add(id_transaction);
        }
        if (date != null) {
            query += " AND daty = ?";
            parameters.add(date);
        }
        if(idUtilisateur != null){
            query += " AND idutilisateur = ?";
            parameters.add(idUtilisateur);
        }
        System.out.println("Query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    HistoriqueTransaction historiqueTransaction = new HistoriqueTransaction();

                    Transaction transaction = new Transaction();
                    transaction.setNom(resultSet.getString("transaction_nom"));
                    transaction.setIdTransaction(resultSet.getInt("idtransaction"));

                    historiqueTransaction.setTransaction(transaction);

                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setNom(resultSet.getString("utilisateur_nom"));
                    utilisateur.setEmail(resultSet.getString("email"));
                    utilisateur.setIdUtilisateur(resultSet.getInt("idutilisateur"));
                    historiqueTransaction.setUtilisateur(utilisateur);


                    historiqueTransaction.setDaty(resultSet.getTimestamp("daty"));
                    historiqueTransaction.setValeurs(resultSet.getDouble("valeurs"));
                    historiqueTransaction.setIdTransaction(resultSet.getInt("idTransaction"));

                    historiqueEchanges.add(historiqueTransaction);
                }
            }
        }
        return historiqueEchanges;
    }


    public static void updateValidationTransaction(Connection conn, int idHistoriqueTransaction, int idValidation) throws SQLException {

        String updateQuery = "UPDATE validation_transaction SET idvalidation = ? WHERE idhistoriquetransaction = ?";

        try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
            stmt.setInt(1, idValidation);
            stmt.setInt(2, idHistoriqueTransaction);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("Échec de la mise à jour : aucune ligne affectée.");
            }
        }
    }


    // Method to insert a new record
    public static void insert(HistoriqueTransaction historique, Connection connection) throws SQLException {
        String query = "INSERT INTO historiquetransaction (daty, idTransaction, idUtilisateur,valeurs) " +
                "VALUES ( ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setTimestamp(1, historique.getDaty());
            statement.setInt(2, historique.getIdTransaction());
            statement.setInt(3, historique.getIdUtilisateur());
            statement.setDouble(4, historique.getValeurs());



            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        historique.setIdHistoriqueTransaction(generatedKeys.getInt(1));
                        System.out.println("HistoriqueTransaction inserted with ID: " + historique.getIdHistoriqueTransaction());
                    }
                }
            }
        }
    }
}