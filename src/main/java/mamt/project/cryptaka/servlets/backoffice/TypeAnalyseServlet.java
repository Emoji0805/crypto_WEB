package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/TypeAnalyseServlet")
public class TypeAnalyseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnexionPost.getConnectionPost()) {
            List<TypeAnalyse> typesAnalyse = TypeAnalyse.getAll(connection);
            List<Crypto> cryptos = Crypto.getAll(connection);

            request.setAttribute("typesAnalyse", typesAnalyse);
            request.setAttribute("cryptos", cryptos);

            request.getRequestDispatcher("/pages/backoffice/type_analyse/analyse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeAnalyseStr = request.getParameter("typeAnalyse");
        String[] selectedCryptos = request.getParameterValues("crypto");
        String dateMinStr = request.getParameter("dateMin");
        String dateMaxStr = request.getParameter("dateMax");

        if (typeAnalyseStr == null || selectedCryptos == null) {
            request.setAttribute("errorMessage", "Veuillez sélectionner un type d'analyse et des cryptos.");
            request.getRequestDispatcher("analyse.jsp").forward(request, response);
            return;
        }

        int typeAnalyse = Integer.parseInt(typeAnalyseStr);
        String cryptoFilter = "";
        if (!selectedCryptos[0].equals("all")) {
            cryptoFilter = "AND co.idCrypto IN (" + String.join(",", selectedCryptos) + ")";
        }

        Timestamp timestampMin = null, timestampMax = null;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        try {
            if (dateMinStr != null && !dateMinStr.isEmpty()) {
                timestampMin = Timestamp.valueOf(LocalDateTime.parse(dateMinStr, formatter));
            }
            if (dateMaxStr != null && !dateMaxStr.isEmpty()) {
                timestampMax = Timestamp.valueOf(LocalDateTime.parse(dateMaxStr, formatter));
            }

            try (Connection connection = ConnexionPost.getConnectionPost()) {
                Cours resultat = TypeAnalyse.effectuerAnalyse(connection, typeAnalyse, timestampMin, timestampMax, cryptoFilter);
                request.setAttribute("resultat", resultat);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
        }

        request.getRequestDispatcher("/pages/backoffice/type_analyse/resultAnalyse.jsp").forward(request, response);
    }
}
