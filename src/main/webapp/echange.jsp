<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.Transaction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/templates/frontoffice/sidebar.jsp" %>
<%@ include file="/templates/frontoffice/header.jsp" %>
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
                        <div class="card-title">Faire une echange</div>
                        <hr>
                        <form action="EchangeServlet" method="post">
                            <div class="form-group">
                                <label for="id_crypto">Crypto :</label>
                                <select name="idCrypto" class="form-control" id="id_crypto">
                                    <%
                                        List<Crypto> cryptos =(List<Crypto>) request.getAttribute("crypto");
                                        for (int i = 0; i < cryptos.size(); i++)
                                        {
                                            Crypto crypto = cryptos.get(i);
                                    %>
                                    <option value="<%= crypto.getIdCrypto() %>"><%= crypto.getNom() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="type_echange">Type d'echange :</label>
                                <select name="idTransaction" class="form-control" id="type_echange">
                                    <%
                                        List<Transaction> transactions =(List<Transaction>) request.getAttribute("venteAchat");
                                        for (int i = 0; i < transactions.size(); i++)
                                        {
                                            Transaction transaction = transactions.get(i);
                                    %>
                                    <option value="<%= transaction.getIdTransaction() %>"><%= transaction.getNom() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="quantite">Quantite :</label>
                                <input type="text" name="quantite" id="quantite" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="date_echange">Date d'Echange :</label>
                                <input type="datetime-local" name="daty" id="date_echange" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-light btn-round px-5">Confirmer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div><!--End Row-->

 <%@ include file="templates/frontoffice/footer.jsp" %>
