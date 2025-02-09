package mamt.project.cryptaka.models;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionValidation {
    private Utilisateur utilisateur;
    private Timestamp date_transaction;
    private Validation validation;
    double valeurs;
    Transaction transaction;

    private int idhistoriquetransaction;
    public TransactionValidation() {
    }

    public TransactionValidation(Utilisateur utilisateur, Timestamp date_transaction, Validation validation, double valeurs, Transaction transaction) {
        this.utilisateur = utilisateur;
        this.date_transaction = date_transaction;
        this.validation = validation;
        this.valeurs = valeurs;
        this.transaction = transaction;
    }

    public static List<TransactionValidation> getAll(Connection connection) throws SQLException {
        List<TransactionValidation> mouvements = new ArrayList<>();
        String query = "SELECT * FROM v_validation_transaction";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                TransactionValidation tv = new TransactionValidation();
                tv.setIdhistorique_transaction(resultSet.getInt("idhistoriquetransaction"));

                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setNom(resultSet.getString("nom"));
                utilisateur.setIdUtilisateur(resultSet.getInt("idutilisateur"));
                tv.setUtilisateur(utilisateur);

                tv.setDate_transaction(resultSet.getTimestamp("date_transaction"));
                tv.setValeurs(resultSet.getDouble("valeurs"));

                Transaction t = new Transaction();
                t.setNom(resultSet.getString("operation"));
                t.setIdTransaction(resultSet.getInt("idtransaction"));
                tv.setTransaction(t);

                Validation v = new Validation();
                v.setDescription(resultSet.getString("type_validation"));

                tv.setValidation(v);

                mouvements.add(tv);
            }
        }
        return mouvements;
    }

    public int getIdhistorique_transaction() {
        return idhistoriquetransaction;
    }

    public void setIdhistorique_transaction(int idvalidation_transaction) {
        this.idhistoriquetransaction = idvalidation_transaction;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Timestamp getDate_transaction() {
        return date_transaction;
    }

    public void setDate_transaction(Timestamp date_transaction) {
        this.date_transaction = date_transaction;
    }

    public Validation getValidation() {
        return validation;
    }

    public void setValidation(Validation validation) {
        this.validation = validation;
    }

    public double getValeurs() {
        return valeurs;
    }

    public void setValeurs(double valeurs) {
        this.valeurs = valeurs;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
}
