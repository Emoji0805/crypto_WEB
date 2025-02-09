<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.HistoriqueEchange" %>
<%@ page import="mamt.project.cryptaka.models.Transaction" %>
<%@ page import="mamt.project.cryptaka.models.Utilisateur" %>
<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<HistoriqueEchange> historiqueVenteAchat = (List<HistoriqueEchange>) request.getAttribute("historiqueVenteAchat");
    List<Transaction> transactionAchatVente = (List<Transaction>) request.getAttribute("transactionVenteAchat");
    List<Crypto> cryptos = (List<Crypto>) request.getAttribute("cryptos");
    List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs");
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
                        <div class="card-title">Rechercher Historique des Achats et Ventes</div>
                        <hr>
                        <form action="HistoriqueVenteAchat" method="post">
                            <div class="form-group">
                                <label for="id_transaction">Type de Transaction :</label>
                                <select name="id_transaction" id="id_transaction" class="form-control">
                                    <option value="">Tous</option>
                                    <% if(transactionAchatVente != null && !transactionAchatVente.isEmpty()) {
                                        for (Transaction t : transactionAchatVente) { %>
                                    <option value="<%= t.getIdTransaction() %>"><%= t.getNom() %></option>
                                    <%  }
                                    } else { %>
                                    <option value="">Aucune Transaction</option>
                                    <% } %>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="id_crypto">Crypto :</label>
                                <select name="id_crypto" id="id_crypto" class="form-control">
                                    <option value="">Tous</option>
                                    <% if(cryptos != null && !cryptos.isEmpty()) {
                                        for (Crypto c : cryptos) { %>
                                    <option value="<%= c.getIdCrypto() %>"><%= c.getNom() %></option>
                                    <%  }
                                    } else { %>
                                    <option value="">Aucun Crypto</option>
                                    <% } %>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="id_utilisateur">Utilisateur :</label>
                                <select name="id_utilisateur" id="id_utilisateur" class="form-control">
                                    <option value="">Tous les utilisateurs</option>
                                    <% if(utilisateurs != null && !utilisateurs.isEmpty()) {
                                        for (Utilisateur u : utilisateurs) { %>
                                    <option value="<%= u.getIdUtilisateur() %>"><%= u.getNom() %></option>
                                    <%  }
                                    } else { %>
                                    <option value="">Aucun Utilisateur trouver !</option>
                                    <% } %>

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="date_debut">Date Début :</label>
                                <input type="date" name="date_debut" id="date_debut" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="date_fin">Date Fin :</label>
                                <input type="date" name="date_fin" id="date_fin" class="form-control">
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
                                    <th>Crypto</th>
                                    <th>Type de Transaction</th>
                                    <th>Date</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% if (historiqueVenteAchat != null && !historiqueVenteAchat.isEmpty()) {
                                    for (HistoriqueEchange he : historiqueVenteAchat) { %>
                                <tr>
                                    <td><%= he.getUtilisateur().getNom() %></td>
                                    <td><%= he.getUtilisateur().getEmail() %></td>
                                    <td><%= he.getCrypto().getNom() %></td>
                                    <td><%= he.getTransaction().getNom() %></td>
                                    <td><%= he.getDaty() %></td>
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
