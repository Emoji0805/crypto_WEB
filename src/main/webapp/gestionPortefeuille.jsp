<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mamt.project.cryptaka.models.Portefeuille" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.Utilisateur" %>

<%@ include file="templates/frontoffice/sidebar.jsp" %>
<%@ include file="templates/frontoffice/header.jsp" %>
<%
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateurs");
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
                            <h5 class="text-white mb-0">Fond : <%= String.format("%.2f", utilisateur.getFond()) %> <span class="float-right"><i class="fa fa-google-wallet"></i></span></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Mon portefeuille</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Crypto</th>
                                    <th>Quantite</th>
<%--                                    <th>ID Utilisateur</th>--%>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    List<Portefeuille> portefeuilles = (List<Portefeuille>) request.getAttribute("portefeuilles");
                                    if (portefeuilles != null && !portefeuilles.isEmpty()) {
                                        for (Portefeuille portefeuille : portefeuilles) {
                                %>
                                <tr>
                                    <td><%= portefeuille.getCrypto().getNom() %></td>
                                    <td><%= portefeuille.getQuantite() %></td>
<%--                                    <td><%= portefeuille.getIdUtilisateur() %></td>--%>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="4" class="text-center">Aucun portefeuille trouvé pour cet utilisateur.</td>
                                </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="templates/frontoffice/footer.jsp" %>

