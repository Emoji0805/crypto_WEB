package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        HttpSession session = request.getSession();

        try (Connection connection = ConnexionPost.getConnectionPost()) {
//            int idUtilisateur = (int) session.getAttribute("utilisateurId");

            List<Transaction> depotRetrait = Transaction.getDepotRetrait(connection);

            request.setAttribute("depotRetrait", depotRetrait);

            request.getRequestDispatcher("transaction.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//                HttpSession session = request.getSession();

        try (Connection connection = ConnexionPost.getConnectionPost()) {

            int idUtilisateur = (int) request.getSession().getAttribute("idutilisateur");

//            int idUtilisateur = 3;
            int idTransaction = Integer.parseInt(request.getParameter("idTransaction"));
            double valeurs = Double.parseDouble(request.getParameter("valeurs"));

            String daty = request.getParameter("daty");
            Timestamp datyVrais = Timestamp.valueOf(daty.replace("T", " ") + ":00");


            HistoriqueTransaction historiqueTransaction = new HistoriqueTransaction();

            historiqueTransaction.setDaty(datyVrais);
            historiqueTransaction.setIdTransaction(idTransaction);
            historiqueTransaction.setIdUtilisateur(idUtilisateur);
            historiqueTransaction.setValeurs(valeurs);


            HistoriqueTransaction.insert(historiqueTransaction,connection);
            response.sendRedirect(request.getContextPath() + "/HistoriqueRetraitDepot?mode=all");


        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


}
