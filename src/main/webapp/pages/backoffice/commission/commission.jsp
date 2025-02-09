<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.Commission" %>
<%@ page import="java.util.HashMap" %>

<%@ include file="../../../templates/backoffice/sidebar.jsp" %>
<%@ include file="../../../templates/backoffice/header.jsp" %>

<%
    List<Crypto> cryptos = (List<Crypto>) request.getAttribute("cryptos");
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


<div class="clearfix"></div>

<div class="content-wrapper">
    <div class="container-fluid">

        <div class="card mt-3">
            <div class="card-content">
                <div class="row row-group m-0">
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <a href="<%= request.getContextPath() %>/CommissionServlet?mod=web"> <button class="btn btn-light btn-round px-5">Modifier</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">

                        <% if(request.getParameter("mod").equals("webupdate")) { %>
                            <div class="card-title">Choisissez d'abord le Crypto puis de donner sa Commission par rapport a la transaction</div>
                            <hr>
                            <form action="CommissionServlet?mod=showcommission" method="post">
                                <div class="form-group">
                                    <label for="idCrypto">Cryptos :</label>
                                    <select name="idcrypto" id="idCrypto" class="form-control">
                                        <% for(Crypto c : cryptos) { %>
                                        <option value="<%= c.getIdCrypto() %>"><%= c.getNom() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="transaction">Transaction : </label>
                                    <select name="transaction" id="transaction" class="form-control">
                                        <option value="1">Achat</option>
                                        <option value="2">Vente</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-light btn-round px-5">Rechercher</button>
                                </div>
                                <% if(request.getParameter("error") != null) { %>
                                <p style="color: red"><%= request.getParameter("error") %></p>
                                <% } %>

                                        <% if(request.getParameter("result") != null) {
                                            Commission commission = (Commission) request.getAttribute("commission");
                                        %>
                                        <form action="CommissionServlet?mod=update" method="post">
                                            <div class="form-group">
                                                <input type="hidden" value="<%= commission.getIdTransaction() %>" name="transaction">
                                                <input type="hidden" value="<%= commission.getIdCrypto() %>" name="idcrypto">
                                            </div>
                                            <div class="form-group">
                                                <label for="valeur">Valeur : </label>
                                                <input type="number" name="valeur" id="valeur" step="0.01" value="<%= commission.getPourcentage() %>" required class="form-control">
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" class="btn btn-light btn-round px-5" value="Modifier">
                                            </div>

                                        </form>
                                <% } %>

                        <% } else { %>
                                <div class="card-title">Rechercher La Somme ou la moyenne de commission d'un/plusieurs CRYPTO</div>
                                <hr>
                        <form action="CommissionServlet?mod=liste" method="POST">
                            <div class="form-group">
                                <label for="type_analyse">Type Analyse : </label>
                                <select name="type_analyse" id="type_analyse" class="form-control">
                                    <option value="1">Somme</option>
                                    <option value="2">Moyenne</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="idcrypto2">Cryptos :</label>
                                <select name="idcrypto" id="idcrypto2" class="form-control">
                                    <option value="0">Tous</option>
                                    <% for(Crypto c : cryptos) { %>
                                    <option value="<%= c.getIdCrypto() %>"><%= c.getNom() %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="dateMin">Date Heure Min :</label>
                                <input type="datetime-local" name="dateMin" id="dateMin" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="dateMax">Date Heure Max :</label>
                                <input type="datetime-local" name="dateMax" id="dateMax" class="form-control">
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-light btn-round px-5">Filtrer</button>
                            </div>
                        </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div><!--End Row-->

        <%
            if(request.getParameter("mod").equals("webliste")) {
                List<HashMap<String, Object>> liste = (List<HashMap<String, Object>>) request.getAttribute("liste");
        %>

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Resultat de l'Analyse</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Id Crypto</th>
                                    <th>Nom Crypto</th>
                                    <th>Bilan</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% if (liste != null && !liste.isEmpty()) {
                                    for (HashMap<String, Object> he : liste) { %>
                                <tr>
                                    <td><%= he.get("idcrypto") %></td>
                                    <td><%= he.get("nomcrypto") %></td>
                                    <% if(he.get("bilan") != null) { %>
                                    <td><%= he.get("bilan") %></td>
                                    <% } %>
                                </tr>
                                <%  }
                                } else { %>
                                <tr>
                                    <td colspan="4">Aucune commission trouvée.</td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>


<%@ include file="../../../templates/backoffice/footer.jsp" %>