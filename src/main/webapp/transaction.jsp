<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.Transaction" %>
<%@ include file="/templates/frontoffice/sidebar.jsp" %>
<%@ include file="templates/frontoffice/header.jsp" %>

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
                        <div class="card-title">Faire une transaction</div>
                        <hr>
                        <form action="TransactionServlet" method="post">
                            <div class="form-group">
                                <label for="id_transaction">Type de Transaction :</label>
                                <select name="idTransaction" id="id_transaction" class="form-control">
                                    <%
                                        List<Transaction> depotRetraits =(List<Transaction>) request.getAttribute("depotRetrait");
                                        for (int i = 0; i < depotRetraits.size(); i++)
                                        {
                                            Transaction depotRetrait = depotRetraits.get(i);
                                    %>
                                    <option value="<%= depotRetrait.getIdTransaction() %>"><%= depotRetrait.getNom() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="valeur">Valeur :</label>
                                <input type="text" name="valeurs" id="valeur" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="daty">Date de transaction :</label>
                                <input type="datetime-local" name="daty" id="daty" class="form-control" required>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>