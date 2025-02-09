package mamt.project.cryptaka.servlets.backoffice;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.*;
import mamt.project.cryptaka.utils.Functions;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

@WebServlet("/CommissionServlet")
public class CommissionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mod=request.getParameter("mod");
        try (Connection connection = ConnexionPost.getConnectionPost()) {
            if(mod.equals("web")) {
                List<Crypto> cryptos = Crypto.getAll(connection);
                request.setAttribute("cryptos", cryptos);
//                Commission commAchat = Commission.getByIdTransaction(connection, 1);
//                Commission commVente = Commission.getByIdTransaction(connection, 2);
//
//                request.setAttribute("commAchat", commAchat);
//                request.setAttribute("commVente", commVente);
                request.getRequestDispatcher("/pages/backoffice/commission/commission.jsp?mod=webupdate").forward(request, response);
            }
            if(mod.equals("liste")) {
                List<Crypto> cryptos = Crypto.getAll(connection);
                request.setAttribute("cryptos", cryptos);
                request.getRequestDispatcher("/pages/backoffice/commission/commission.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mod=request.getParameter("mod");
        try (Connection connection = ConnexionPost.getConnectionPost()) {
            if(mod.equals("update")) {
                List<Crypto> cryptos = Crypto.getAll(connection);
                request.setAttribute("cryptos", cryptos);
                int idtransaction = Integer.parseInt(request.getParameter("transaction"));
                int idcrypto = Integer.parseInt(request.getParameter("idcrypto"));

                double pourcentage = Double.parseDouble(request.getParameter("valeur"));

                Commission commission = new Commission(idtransaction, idcrypto, pourcentage);

                int res = Commission.insert(connection, commission);
                if(res != 0) {
                    response.setContentType("text/html; charset=UTF-8");
                    PrintWriter out = response.getWriter();

                    // Vous pouvez remplacer "targetPage.jsp" par la page vers laquelle vous souhaitez rediriger
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Modification réussie');");
                    out.println("window.location.href = 'CommissionServlet?mod=web';");
                    out.println("</script>");
                    out.println("</head>");
                    out.println("<body></body>");
                    out.println("</html>");
                } else {
                    System.out.println("erreeuuuuur");
                }
            }
            if(mod.equals("showcommission")) {
                List<Crypto> cryptos = Crypto.getAll(connection);
                request.setAttribute("cryptos", cryptos);

                int idCrypto = Integer.parseInt(request.getParameter("idcrypto"));
                int transaction = Integer.parseInt(request.getParameter("transaction"));
                String dateStr = request.getParameter("daty");

                Timestamp timestamp = Functions.convertToTimestamp(dateStr);

                Commission commission = Commission.get(connection, transaction, idCrypto, timestamp);

                if(commission == null) {
                    response.sendRedirect("CommissionServlet?mod=web&error=commissionNotFound");
                } else {
                    request.setAttribute("commission", commission);
                    request.getRequestDispatcher("/pages/backoffice/commission/commission.jsp?mod=webupdate&result=true").forward(request, response);
                }
            } if(mod.equals("liste")) {
                int type_analyse = Integer.parseInt(request.getParameter("type_analyse"));
                int idcrypto = Integer.parseInt(request.getParameter("idcrypto"));
                String datyMin = request.getParameter("dateMin");
                String datyMax = request.getParameter("dateMax");

                Timestamp dateMinT = Functions.convertToTimestamp(datyMin);
                Timestamp dateMaxT = Functions.convertToTimestamp(datyMax);

                List<HashMap<String, Object>> liste = Commission.filtre(connection, type_analyse, idcrypto, dateMinT, dateMaxT);
                List<Crypto> cryptos = Crypto.getAll(connection);
                request.setAttribute("cryptos", cryptos);
                request.setAttribute("liste", liste);
                request.getRequestDispatcher("/pages/backoffice/commission/commission.jsp?mod=webliste").forward(request, response);
            }
        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
