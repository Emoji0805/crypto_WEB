<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="mamt.project.cryptaka.models.*" %>

<%
    List<HistoriqueTransaction> historiqueRetraitDepot = (List<HistoriqueTransaction>) request.getAttribute("historiqueRetraitDepot");
    List<Transaction> transactionRetraitDepot = (List<Transaction>) request.getAttribute("transactionRetraitDepot");
%>

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

<%@ include file="../../../templates/frontoffice/sidebar.jsp" %>
<%@ include file="../../../templates/frontoffice/header.jsp" %>



<div class="clearfix"></div>

<div class="content-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Rechercher Historique des Retraits et Depots</div>
                        <hr>
                        <form action="HistoriqueRetraitDepot" method="post">
                            <input type="hidden" name="id_utilisateur" value="">
                            <div class="form-group">
                                <label for="id_transaction">Type de Transaction :</label>
                                <select name="id_transaction" id="id_transaction" class="form-control">
                                    <option value="">Tous</option>
                                    <% if(transactionRetraitDepot != null && !transactionRetraitDepot.isEmpty()) {
                                        for (Transaction t : transactionRetraitDepot) { %>
                                    <option value="<%= t.getIdTransaction() %>"><%= t.getNom() %></option>
                                    <%  }
                                    } else { %>
                                    <option value="">Aucune Transaction</option>
                                    <% } %>

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="date_heure">Date et Heure :</label>
                                <input type="datetime-local" name="date_heure" id="date_heure" class="form-control">
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
                                    <th>Type de Transaction</th>
                                    <th>Valeur</th>
                                    <th>Date</th>
                                    <th>Voir historique</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% if (historiqueRetraitDepot != null && !historiqueRetraitDepot.isEmpty()) {
                                    for (HistoriqueTransaction he : historiqueRetraitDepot) { %>
                                <tr>
                                    <td><%= he.getUtilisateur().getNom() %></td>
                                    <td><%= he.getUtilisateur().getEmail() %></td>
                                    <td><%= he.getTransaction().getNom() %></td>
                                    <td><%= he.getValeurs() %></td>
                                    <td><%= he.getDaty() %></td>
                                    <td><a href="HistoriqueRetraitDepot?mode=utilisateur&&idutilisateur=<%= he.getUtilisateur().getIdUtilisateur()%>"><button class="btn btn-light btn-round px-5">Voir son historique</button></a></td>
                                </tr>
                                <%  }
                                } else { %>
                                <tr>
                                    <td colspan="8">Aucune transaction trouvée.</td>
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

