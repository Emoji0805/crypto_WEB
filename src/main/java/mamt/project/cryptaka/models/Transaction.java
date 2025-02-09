package mamt.project.cryptaka.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Transaction {
    private int idTransaction;
    private String nom;
    private double total_achat;
    private double total_vente;

    public Transaction() {
    }

    public double getTotal_achat() {
        return total_achat;
    }

    public void setTotal_achat(double total_achat) {
        this.total_achat = total_achat;
    }

    public double getTotal_vente() {
        return total_vente;
    }

    public void setTotal_vente(double total_vente) {
        this.total_vente = total_vente;
    }

    public static List<Transaction> getAll(Connection connection) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transaction";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Transaction transaction = new Transaction();
                transaction.setIdTransaction(resultSet.getInt("idTransaction"));
                transaction.setNom(resultSet.getString("nom"));
                transactions.add(transaction);
            }
        }
        return transactions;
    }

    public static List<Transaction> getAchatVente(Connection connection) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transaction where nom = 'Achat' or nom = 'Vente' order by idTransaction limit 2";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Transaction transaction = new Transaction();
                transaction.setIdTransaction(resultSet.getInt("idTransaction"));
                transaction.setNom(resultSet.getString("nom"));
                transactions.add(transaction);
            }
        }
        return transactions;
    }
    public static List<Transaction> getDepotRetrait(Connection connection) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transaction order by idTransaction limit 2 offset 2";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Transaction transaction = new Transaction();
                transaction.setIdTransaction(resultSet.getInt("idTransaction"));
                transaction.setNom(resultSet.getString("nom"));
                transactions.add(transaction);
            }
        }
        return transactions;
    }

    public void transaction_achat(Connection conn, double nbr_crypto,
                                  int id_crypto, int id_utilisateur) throws SQLException,Exception {

        Cours cours = Cours.getLastCrypto(conn , id_crypto);
        Utilisateur utilisateur = Utilisateur.getById(conn , id_utilisateur);
        Portefeuille portefeuille = Portefeuille.getCryptoOfUser(conn , id_utilisateur,id_crypto);
        double fondUser = utilisateur.getFond();
        double prixCryptoDemande = nbr_crypto * cours.getValeur();

        if(fondUser >= prixCryptoDemande){

            double newFondUtilisateur = utilisateur.getFond() - prixCryptoDemande;
            double newCryptoUtilisateur = portefeuille.getQuantite() + nbr_crypto;

            Utilisateur.updateFondByUser(id_utilisateur, newFondUtilisateur, conn);
            Portefeuille.updateQuantite(id_utilisateur,id_crypto,newCryptoUtilisateur,conn);
        } else if (fondUser < prixCryptoDemande) {
            throw new Exception("Votre fond est insuffisant !");
        }
    }

    public void transaction_vente(Connection conn, double nbr_crypto,
                                  int id_crypto, int id_utilisateur) throws SQLException,Exception {

        Cours cours = Cours.getLastCrypto(conn , id_crypto);
        Utilisateur utilisateur = Utilisateur.getById(conn,id_utilisateur);
        Portefeuille portefeuille = Portefeuille.getCryptoOfUser(conn , id_utilisateur,id_crypto);
        double quantiteCrypto = portefeuille.getQuantite();
        double prixCryptoDemande = nbr_crypto * cours.getValeur();
        if(quantiteCrypto >= nbr_crypto){

            double newFondUtilisateur = utilisateur.getFond() + prixCryptoDemande;
            double newCryptoUtilisateur = portefeuille.getQuantite() - nbr_crypto;

            Utilisateur.updateFondByUser(id_utilisateur, newFondUtilisateur, conn);
            Portefeuille.updateQuantite(id_utilisateur,id_crypto,newCryptoUtilisateur,conn);


        } else if (quantiteCrypto < nbr_crypto) {
            throw new Exception("Votre fond est insuffisant !");
        }
    }

    public void transaction_retrait(Connection conn, double valeurs, int id_utilisateur) throws SQLException,Exception {

        Utilisateur utilisateur = Utilisateur.getById(conn,id_utilisateur);
        double fond = utilisateur.getFond();
        if(valeurs <= fond){

            double newFondUtilisateur = fond - valeurs;

            Utilisateur.updateFondByUser(id_utilisateur, newFondUtilisateur, conn);


        } else if (valeurs > fond) {
            throw new Exception("Votre fond est insuffisant !");
        }
    }

    public void transaction_depot(Connection conn, double valeurs, int id_utilisateur) throws SQLException,Exception {

        Utilisateur utilisateur = Utilisateur.getById(conn,id_utilisateur);
        double fond = utilisateur.getFond();

        double newFondUtilisateur = fond + valeurs;

        Utilisateur.updateFondByUser(id_utilisateur, newFondUtilisateur, conn);
    }

    public int getIdTransaction() {
        return idTransaction;
    }

    public void setIdTransaction(int idTransaction) {
        this.idTransaction = idTransaction;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}