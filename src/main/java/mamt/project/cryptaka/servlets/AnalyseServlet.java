package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Crypto;
import mamt.project.cryptaka.models.Portefeuille;
import mamt.project.cryptaka.models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/analyse")
public class AnalyseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnexionPost.getConnectionPost()) {
            String typeAnalyse = request.getParameter("typeAnalyse");
            String[] cryptos = request.getParameterValues("crypto");
            String dateMin = request.getParameter("dateMin");
            String dateMax = request.getParameter("dateMax");

            boolean allSelected = false;
            if (cryptos != null) {
                for (String crypto : cryptos) {
                    if ("all".equals(crypto)) {
                        allSelected = true;
                        break;
                    }
                }
            }

            double resultat = 0;
//            if (allSelected) {
//
//            } else {
//                resultat = TypeAnalyse.executeAnalyseForSpecificCryptos(connection, typeAnalyse, cryptos, dateMin, dateMax);
//            }

            request.setAttribute("resultat", resultat);
            request.getRequestDispatcher("resultat_analyse  .jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = ConnexionPost.getConnectionPost()) {
//            List<Portefeuille> portefeuilles = Portefeuille.getAllCryptoByUser(connection,1);
            List<Crypto> cryptos = Crypto.getAll(connection);
            List<TypeAnalyse> typeAnalyses = TypeAnalyse.getAll(connection);

            request.setAttribute("typeAnalyses", typeAnalyses);
            request.setAttribute("cryptos", cryptos);

            request.getRequestDispatcher("analyse.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


}
