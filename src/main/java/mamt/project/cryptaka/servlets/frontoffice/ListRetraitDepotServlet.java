package mamt.project.cryptaka.servlets.frontoffice;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.HistoriqueEchange;
import mamt.project.cryptaka.models.HistoriqueTransaction;
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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("HistoriqueRetraitDepot")
public class ListRetraitDepotServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try{
            if(request.getParameter("mode").equals("all") && request.getParameter("mode") != null){
                conn = ConnexionPost.getConnectionPost();
                HistoriqueTransaction historiqueTransaction = new HistoriqueTransaction();

                List<HistoriqueTransaction> historiqueTransactions = historiqueTransaction.getHistoriqueRetraitDepotAllUsers(conn , null,null,null);
                List<Transaction> transactionRetraitDepot = Transaction.getDepotRetrait(conn);

                request.setAttribute("historiqueRetraitDepot" , historiqueTransactions);
                request.setAttribute("transactionRetraitDepot" , transactionRetraitDepot);
                request.getRequestDispatcher("/pages/frontoffice/historique/historique_RetraitDepot.jsp").forward(request, response);
            }
            if(request.getParameter("mode").equals("utilisateur") && request.getParameter("mode") != null
                && request.getParameter("idutilisateur") != null
            ){
                Integer id_utilisateur = null;
                String idUtilisateur_Str = request.getParameter("idutilisateur");
                if(!idUtilisateur_Str.isEmpty()){
                    id_utilisateur = Integer.parseInt(idUtilisateur_Str);
                }
                conn = ConnexionPost.getConnectionPost();
                HistoriqueTransaction historiqueTransaction = new HistoriqueTransaction();

                List<HistoriqueTransaction> historiqueTransactions = historiqueTransaction.getHistoriqueRetraitDepotAllUsers(conn , null,id_utilisateur,null);
                List<Transaction> transactionRetraitDepot = Transaction.getDepotRetrait(conn);
                Utilisateur user = Utilisateur.getById(conn, id_utilisateur);

                request.setAttribute("utilisateur" , user);
                request.setAttribute("historiqueRetraitDepot" , historiqueTransactions);
                request.setAttribute("transactionRetraitDepot" , transactionRetraitDepot);
                request.getRequestDispatcher("/pages/frontoffice/historique/historique_RetraitDepotUser.jsp").forward(request, response);
            }

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

            HistoriqueTransaction he = new HistoriqueTransaction();
            conn = ConnexionPost.getConnectionPost();
            String date_heureStr = request.getParameter("date_heure");
            String id_transactionStr = request.getParameter("id_transaction");

            Timestamp dateHeureTimestamp = null;

            if (date_heureStr != null && !date_heureStr.isEmpty()) {
                if (date_heureStr.length() == 16) {
                    date_heureStr += ":00";
                }

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
                LocalDateTime dateMax = LocalDateTime.parse(date_heureStr, formatter);

                dateHeureTimestamp = Timestamp.valueOf(dateMax);
                System.out.println(dateHeureTimestamp);
            }

            Integer id_transaction = (id_transactionStr == null || id_transactionStr.isEmpty()) ? null : Integer.parseInt(id_transactionStr);
            Integer id_utilisateur = null;

            if(!request.getParameter("id_utilisateur").isEmpty()){
                id_utilisateur = Integer.parseInt(request.getParameter("id_utilisateur"));
                Utilisateur user = Utilisateur.getById(conn, id_utilisateur);


                List<HistoriqueTransaction> historiqueTransactions = he.getHistoriqueRetraitDepotAllUsers(conn , id_transaction,id_utilisateur, dateHeureTimestamp);
                List<Transaction> transactionRetraitDepot = Transaction.getDepotRetrait(conn);

                request.setAttribute("transactionRetraitDepot" , transactionRetraitDepot);
                request.setAttribute("historiqueRetraitDepot" , historiqueTransactions);
                request.setAttribute("utilisateur" , user);
                request.getRequestDispatcher("/pages/frontoffice/historique/historique_RetraitDepotUser.jsp").forward(request, response);

            }

            List<HistoriqueTransaction> historiqueTransactions = he.getHistoriqueRetraitDepotAllUsers(conn , id_transaction,id_utilisateur, dateHeureTimestamp);
            List<Transaction> transactionRetraitDepot = Transaction.getDepotRetrait(conn);

            request.setAttribute("transactionRetraitDepot" , transactionRetraitDepot);
            request.setAttribute("historiqueRetraitDepot" , historiqueTransactions);
            request.getRequestDispatcher("/pages/frontoffice/historique/historique_RetraitDepot.jsp").forward(request, response);

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
