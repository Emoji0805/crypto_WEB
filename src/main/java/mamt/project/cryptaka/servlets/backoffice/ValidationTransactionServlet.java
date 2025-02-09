package mamt.project.cryptaka.servlets.backoffice;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.HistoriqueTransaction;
import mamt.project.cryptaka.models.Transaction;
import mamt.project.cryptaka.models.TransactionValidation;
import mamt.project.cryptaka.models.Validation;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/validationTransaction")
@MultipartConfig
public class ValidationTransactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = ConnexionPost.getConnectionPost();

            List<TransactionValidation> transactions = TransactionValidation.getAll(conn);

            List<Validation> validations = Validation.getAll(conn);

            request.setAttribute("transactions", transactions);
            request.setAttribute("validations", validations);
            request.getRequestDispatcher("/pages/backoffice/validation/validation_transaction.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json;charset=UTF-8");

        String idValidationParam = readPart(request.getPart("idValidation"));
        String idHistoriqueTransactionParam = readPart(request.getPart("idHistoriqueTransaction"));
        String idUtilisateurParam = readPart(request.getPart("idUtilisateur"));
        String idTransactionParam = readPart(request.getPart("idTransaction"));
        String valeurStr = readPart(request.getPart("valeurs"));


        if (idValidationParam == null || idHistoriqueTransactionParam == null || idUtilisateurParam == null || idTransactionParam == null || valeurStr == null) {
            response.getWriter().write("{\"success\": false, \"error\": \"Missing parameters\"}");
            return;
        }

        int idValidation = Integer.parseInt(idValidationParam);
        int idHistoriqueTransaction = Integer.parseInt(idHistoriqueTransactionParam);
        int idUtilisateur = Integer.parseInt(idUtilisateurParam);
        int idTransaction = Integer.parseInt(idTransactionParam);
        double valeurs = Double.parseDouble(valeurStr);

        try (Connection conn = ConnexionPost.getConnectionPost()) {
            if(idValidation == 1){
                if(idTransaction == 4){
                    Transaction transaction= new Transaction();
                    transaction.transaction_retrait(conn ,valeurs,idUtilisateur);
                }
                if(idTransaction == 3){
                    Transaction transaction= new Transaction();
                    transaction.transaction_depot(conn ,valeurs,idUtilisateur);
                }
                HistoriqueTransaction.updateValidationTransaction(conn, idHistoriqueTransaction, idValidation);
            }
            if(idValidation == 2){
                HistoriqueTransaction.updateValidationTransaction(conn, idHistoriqueTransaction, idValidation);
            }

            response.getWriter().write("{\"success\": true}");
        } catch (SQLException e) {
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    private String readPart(Part part) throws IOException {
        if (part != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            return sb.toString();
        }
        return null;
    }

}
