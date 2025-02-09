<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.HistoriqueEchange" %>
<%@ page import="mamt.project.cryptaka.models.Transaction" %>
<%@ page import="mamt.project.cryptaka.models.Utilisateur" %>
<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<HistoriqueEchange> historiqueVenteAchat = (List<HistoriqueEchange>) request.getAttribute("historiqueVenteAchat");
%>

<%@ include file="../../../templates/frontoffice/sidebar.jsp" %>
<%@ include file="../../../templates/frontoffice/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery pour AJAX -->
<script>
    function fetchCryptoData() {
        $.ajax({
            url: 'CoursServlet?mode=random',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                if (data.message) {
                    console.warn("Aucune donnée disponible.");
                    return;
                }

                localStorage.setItem("cryptoData", JSON.stringify(data));
                localStorage.setItem("lastUpdate", Date.now());

                console.log("Mise à jour des données des cryptos !");
            },
            error: function (err) {
                console.error("Erreur de récupération des données:", err);
            }
        });
    }

    $(document).ready(function () {
        fetchCryptoData();
        setInterval(fetchCryptoData, 10000);
    });

</script>

<div class="clearfix"></div>

<div class="content-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Total des Achats et Ventes d'un Utilisateur</div>
                        <hr>
                        <form action="totalAchatVente" method="post">
                            <div class="form-group">
                                <label for="date_max">Date Max :</label>
                                <input type="datetime-local" name="date_max" id="date_max" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-light btn-round px-5">Filtrer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div><!--End Row-->

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Historique Des Ventes et Achats</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Utilisateur</th>
                                    <th>Email</th>
                                    <th>Total Achat</th>
                                    <th>Total Vente</th>
                                    <th>Valeur Portefeuille</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% if (historiqueVenteAchat != null && !historiqueVenteAchat.isEmpty()) {
                                    for (HistoriqueEchange he : historiqueVenteAchat) { %>
                                <tr>
                                    <td><%= he.getUtilisateur().getNom() %></td>
                                    <td><%= he.getUtilisateur().getEmail() %></td>
                                    <td><%= he.getTransaction().getTotal_achat() %></td>
                                    <td><%= he.getTransaction().getTotal_vente() %></td>
                                    <td><%= he.getValeur_portefeuille() %></td>
                                    <td><%= he.getDaty() %></td>
                                </tr>
                                <%  }
                                } else { %>
                                <tr>
                                    <td colspan="8">Aucune historique des totales ventes et achats trouvee.</td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


<%@ include file="../../../templates/frontoffice/footer.jsp" %>

