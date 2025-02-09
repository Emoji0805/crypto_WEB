package mamt.project.cryptaka.servlets.backoffice;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/LoginAdminServlet")
public class LoginAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nomAdmin = request.getParameter("nomAdmin");
        String mdp = request.getParameter("mdp");

        try (Connection connection = ConnexionPost.getConnectionPost()) {
            Admin admin = Admin.login(connection, nomAdmin, mdp);

            if (admin != null) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                request.getRequestDispatcher("/pages/backoffice/acceuil.jsp").forward(request, response); // Redirige vers une page d'accueil
            } else {
                request.setAttribute("error", "Prénom ou mot de passe incorrect.");
                request.getRequestDispatcher("/pages/backoffice/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Erreur lors de la connexion", e);
        }
    }
}
