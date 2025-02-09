package mamt.project.cryptaka.servlets;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.HistoriqueEchange;
import mamt.project.cryptaka.models.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/totalAchatVente")
public class TotalAchatVenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try{
            conn = ConnexionPost.getConnectionPost();
            HistoriqueEchange he = new HistoriqueEchange();

            List<HistoriqueEchange> historiqueEchanges = he.getTotalAchatVenteAllUsers(conn , null);

            request.setAttribute("historiqueVenteAchat" , historiqueEchanges);
            request.getRequestDispatcher("/pages/frontoffice/historique_VenteAchat/totalAchatVente.jsp").forward(request, response);

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
            conn = ConnexionPost.getConnectionPost();
            HistoriqueEchange he = new HistoriqueEchange();
            String date_maxStr = request.getParameter("date_max");

            Timestamp dateMaxTimestamp = null;

            if (date_maxStr != null && !date_maxStr.isEmpty()) {
                if (date_maxStr.length() == 16) {
                    date_maxStr += ":00";
                }

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
                LocalDateTime dateMax = LocalDateTime.parse(date_maxStr, formatter);

                dateMaxTimestamp = Timestamp.valueOf(dateMax);
                System.out.println(dateMaxTimestamp);
            }

            List<HistoriqueEchange> historiqueEchanges = he.getTotalAchatVenteAllUsers(conn , dateMaxTimestamp);

            request.setAttribute("historiqueVenteAchat" , historiqueEchanges);
            request.getRequestDispatcher("/pages/frontoffice/historique_VenteAchat/totalAchatVente.jsp").forward(request, response);

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
}
