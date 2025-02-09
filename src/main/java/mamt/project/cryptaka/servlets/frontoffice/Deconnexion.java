package mamt.project.cryptaka.servlets.frontoffice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deconnexion_frontoffice")
public class Deconnexion extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate(); // Supprime la session
        }

        response.sendRedirect(request.getContextPath() + "/pages/frontoffice/index.jsp");
    }
}
