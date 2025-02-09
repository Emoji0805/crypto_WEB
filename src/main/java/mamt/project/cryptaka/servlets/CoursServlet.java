package mamt.project.cryptaka.servlets;

import com.google.gson.JsonObject;
import mamt.project.cryptaka.models.Cours;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mamt.project.cryptaka.connexion.ConnexionPost;
import mamt.project.cryptaka.models.Crypto;

@WebServlet("/CoursServlet")
public class CoursServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnexionPost.getConnectionPost()) {
            if(request.getParameter("mode").equals("not_random")){
                List<Cours> coursList = Cours.getAll(connection);
                request.setAttribute("cours" , coursList);
                request.getRequestDispatcher("graphe_cours.jsp").forward(request, response);
            }

            if(request.getParameter("mode").equals("random")){
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                List<Cours> cours = Cours.getAll(connection);

                if(cours.isEmpty() || !cours.isEmpty()){
                    List<Crypto> cryptos = Crypto.getAll(connection);
                    for(Crypto crypto : cryptos){
                        Cours.insertCours(connection , crypto.getIdCrypto());
                    }
                }


                List<JsonObject> jsonList = new ArrayList<>();

                List<Cours> coursList = Cours.getAll(connection);
                for (Cours cour : coursList) {
                    JsonObject json = new JsonObject();
                    json.addProperty("idCours", cour.getIdCours());
                    json.addProperty("valeur", cour.getValeur());
                    json.addProperty("daty", cour.getDaty().toString());
                    json.addProperty("idCrypto", cour.getIdCrypto());
                    json.addProperty("nom_crypto", cour.getCrypto().getNom());
                    jsonList.add(json);
                }

                response.getWriter().write(jsonList.toString());

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
