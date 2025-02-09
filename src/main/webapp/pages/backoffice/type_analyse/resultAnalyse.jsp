<%@ page import="mamt.project.cryptaka.models.Cours" %>
<%@ include file="../../../templates/backoffice/sidebar.jsp" %>
<%@ include file="../../../templates/backoffice/header.jsp" %>
<% Cours resultat = (Cours) request.getAttribute("resultat"); %>

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
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white text-center">
                        <h5 class="mb-0">Resultat de l'Analyse</h5>
                    </div>
                    <div class="card-body">
                        <% if (resultat != null) { %>
                        <ul class="list-group list-group-flush">
<%--                            <li class="list-group-item"><strong>Id Crypto :</strong> <%= resultat.getIdCrypto() %></li>--%>
                            <li class="list-group-item"><strong>Nom Crypto :</strong> <%= resultat.getCrypto().getNom() %></li>
                            <li class="list-group-item"><strong>Valeur : </strong><%= String.format("%.2f", resultat.getValeur()) %> Ar</li>
                        </ul>
                        <% } else { %>
                        <div class="alert alert-danger text-center">
                            <strong>Erreur :</strong> <%= request.getAttribute("errorMessage") %>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>


<%@ include file="../../../templates/backoffice/footer.jsp" %>
