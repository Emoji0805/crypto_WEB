package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Crypto;
import mamt.project.cryptaka.models.HistoriqueEchange;
import mamt.project.cryptaka.models.Transaction;
import mamt.project.cryptaka.models.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/HistoriqueVenteAchat")
public class ListAchatVenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try{
            conn = ConnexionPost.getConnectionPost();
            HistoriqueEchange he = new HistoriqueEchange();

            List<HistoriqueEchange> historiqueEchanges = he.getHistoriqueAchatVentsAllUsers(conn , null,null, null, null,null);
            List<Transaction> transactionVenteAchat = Transaction.getAchatVente(conn);
            List<Crypto> cryptos = Crypto.getAll(conn);
            List<Utilisateur> utilisateurs = Utilisateur.getAll(conn);

            request.setAttribute("cryptos" , cryptos);
            request.setAttribute("utilisateurs" , utilisateurs);
            request.setAttribute("historiqueVenteAchat" , historiqueEchanges);
            request.setAttribute("transactionVenteAchat" , transactionVenteAchat);
            request.getRequestDispatcher("/pages/frontoffice/historique_VenteAchat/historique.jsp").forward(request, response);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try{
            HistoriqueEchange he = new HistoriqueEchange();
            conn = ConnexionPost.getConnectionPost();
            String date_debutStr = request.getParameter("date_debut");
            String date_finStr = request.getParameter("date_fin");
            String id_transactionStr = request.getParameter("id_transaction");
            String id_cryptoStr = request.getParameter("id_crypto");
            String id_utilisateurStr = request.getParameter("id_utilisateur");

            Integer id_transaction = (id_transactionStr == null || id_transactionStr.isEmpty()) ? null : Integer.parseInt(id_transactionStr);
            Integer id_crypto = (id_cryptoStr == null || id_cryptoStr.isEmpty()) ? null : Integer.parseInt(id_cryptoStr);
            Integer id_utilisateur = (id_utilisateurStr == null || id_utilisateurStr.isEmpty()) ? null : Integer.parseInt(id_utilisateurStr);

            Date date_debut = (date_debutStr == null || date_debutStr.isEmpty()) ? null : Date.valueOf(date_debutStr);
            Date date_fin = (date_finStr == null || date_finStr.isEmpty()) ? null : Date.valueOf(date_finStr);

            List<HistoriqueEchange> historiqueEchanges = he.getHistoriqueAchatVentsAllUsers(conn , id_transaction,id_crypto, id_utilisateur, date_debut,date_fin);
            List<Transaction> transactionVenteAchat = Transaction.getAchatVente(conn);
            List<Crypto> cryptos = Crypto.getAll(conn);
            List<Utilisateur> utilisateurs = Utilisateur.getAll(conn);

            request.setAttribute("cryptos" , cryptos);
            request.setAttribute("utilisateurs" , utilisateurs);
            request.setAttribute("transactionVenteAchat" , transactionVenteAchat);
            request.setAttribute("historiqueVenteAchat" , historiqueEchanges);
            request.getRequestDispatcher("pages/frontoffice/historique_VenteAchat/historique.jsp").forward(request, response);

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
