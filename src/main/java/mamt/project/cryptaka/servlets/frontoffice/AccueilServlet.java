package mamt.project.cryptaka.servlets.frontoffice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/acceuilServlet")
public class AccueilServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int userId =Integer.parseInt( request.getParameter("id"));
        try {

            // Stocker l'ID utilisateur en session
            request.getSession().setAttribute("idutilisateur", userId);
            response.sendRedirect(request.getContextPath() + "/pages/frontoffice/acceuil.jsp");
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
