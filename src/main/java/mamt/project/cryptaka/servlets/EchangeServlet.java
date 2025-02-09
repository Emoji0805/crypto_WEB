package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Crypto;
import mamt.project.cryptaka.models.HistoriqueEchange;
import mamt.project.cryptaka.models.*;
import mamt.project.cryptaka.models.Portefeuille;
import mamt.project.cryptaka.models.Transaction;


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

@WebServlet("/EchangeServlet")
public class EchangeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        HttpSession session = request.getSession();

        try (Connection connection = ConnexionPost.getConnectionPost()) {
//            int idUtilisateur = (int) session.getAttribute("utilisateurId");

            List<Crypto> crypto = Crypto.getAll(connection);
            List<Transaction> venteAchat = Transaction.getAchatVente(connection);

            request.setAttribute("crypto", crypto);
            request.setAttribute("venteAchat", venteAchat);

            request.getRequestDispatcher("echange.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//                HttpSession session = request.getSession();

        try (Connection connection = ConnexionPost.getConnectionPost()) {
//            int idUtilisateur = (int) session.getAttribute("utilisateurId");
            int idUtilisateur = (int) request.getSession().getAttribute("idutilisateur");
//            int idUtilisateur = 5;
            int idCrypto = Integer.parseInt(request.getParameter("idCrypto"));
            int idTransaction = Integer.parseInt(request.getParameter("idTransaction"));
            double quantite = Double.parseDouble(request.getParameter("quantite"));

            String daty = request.getParameter("daty");
            Timestamp datyVrais = Timestamp.valueOf(daty.replace("T", " ") + ":00");

            if (idTransaction == 1){ //Achat
                Transaction transaction= new Transaction();
                transaction.transaction_achat(connection,quantite,idCrypto,idUtilisateur);
                Utilisateur u = Utilisateur.getById(connection, idUtilisateur);

                HistoriqueEchange mouvementStock = new HistoriqueEchange();
                mouvementStock.setEntree(quantite);
                mouvementStock.setSortie(0);
                mouvementStock.setDaty(datyVrais);
                mouvementStock.setIdTransaction(idTransaction);
                mouvementStock.setIdUtilisateur(idUtilisateur);
                mouvementStock.setIdCrypto(idCrypto);
                mouvementStock.setValeur_portefeuille(u.getFond());

                HistoriqueEchange.insert(mouvementStock,connection);

            }else {//vente
                Transaction transaction= new Transaction();
                transaction.transaction_vente(connection,quantite,idCrypto,idUtilisateur);

                Utilisateur u = Utilisateur.getById(connection, idUtilisateur);

                HistoriqueEchange mouvementStock = new HistoriqueEchange();
                mouvementStock.setEntree(0);
                mouvementStock.setSortie(quantite);
                mouvementStock.setDaty(datyVrais);
                mouvementStock.setIdTransaction(idTransaction);
                mouvementStock.setIdUtilisateur(idUtilisateur);
                mouvementStock.setIdCrypto(idCrypto);
                mouvementStock.setValeur_portefeuille(u.getFond());

                HistoriqueEchange.insert(mouvementStock,connection);
            }



            request.getRequestDispatcher("/HistoriqueVenteAchat").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


}
