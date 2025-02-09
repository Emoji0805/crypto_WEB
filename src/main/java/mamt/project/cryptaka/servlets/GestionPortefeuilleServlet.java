package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Portefeuille;
import mamt.project.cryptaka.models.Utilisateur;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/GestionPortefeuilleServlet")
public class GestionPortefeuilleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = ConnexionPost.getConnectionPost()) {
            HttpSession session = request.getSession();

            int id_utilisateur = (int) request.getSession().getAttribute("idutilisateur");
            //soloina reefa tena izy
//            session.setAttribute("utilisateurId", 5);

            List<Portefeuille> portefeuilles = Portefeuille.getAllCryptoByUser(connection, id_utilisateur);
            Utilisateur user = Utilisateur.getById(connection , id_utilisateur);
            request.setAttribute("portefeuilles", portefeuilles);
            request.setAttribute("utilisateurs" , user);
            request.getRequestDispatcher("/gestionPortefeuille.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


}
