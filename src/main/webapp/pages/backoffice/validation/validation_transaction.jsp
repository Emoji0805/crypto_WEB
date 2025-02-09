<%@ page import="mamt.project.cryptaka.models.TransactionValidation, mamt.project.cryptaka.models.Validation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="mamt.project.cryptaka.models.Transaction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Validation> validations = (List<Validation>) request.getAttribute("validations");
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

<%@ include file="../../../templates/backoffice/sidebar.jsp" %>
<%@ include file="../../../templates/backoffice/header.jsp" %>

<div class="content-wrapper">
    <div class="container-fluid">
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
                                    <th>Date Transaction</th>
                                    <th>Valeurs</th>
                                    <th>Opération</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    List<TransactionValidation> transactions = (List<TransactionValidation>) request.getAttribute("transactions");
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                    for (TransactionValidation transaction : transactions) {
                                %>
                                <tr>
                                    <td><%= transaction.getUtilisateur().getNom() %></td>
                                    <td><%= sdf.format(transaction.getDate_transaction()) %></td>
                                    <td><%= transaction.getValeurs() %></td>
                                    <td><%= transaction.getTransaction().getNom() %></td>
                                    <td>
                                        <% if (transaction.getValidation().getDescription() == null) { %>
                                            <% if (validations != null) { %>
                                            <form style="display:inline;">
                                                <button class="btn btn-success btn-sm" onclick="validerDemande(
                                                    1,
                                                    <%= transaction.getIdhistorique_transaction() %>,
                                                    <%= transaction.getTransaction().getIdTransaction() %>,
                                                    <%= transaction.getUtilisateur().getIdUtilisateur() %>,
                                                    <%= transaction.getValeurs() %>,
                                                        this
                                                        )">Valider</button>

                                                <button class="btn btn-danger btn-sm" onclick="refuserDemande(
                                                    2,
                                                    <%= transaction.getIdhistorique_transaction() %>,
                                                    <%= transaction.getTransaction().getIdTransaction() %>,
                                                    <%= transaction.getUtilisateur().getIdUtilisateur() %>,
                                                    <%= transaction.getValeurs() %>,
                                                        this
                                                        )">Refuser</button>

                                            </form>
                                            <% }  %>

                                        <% } else { %>
                                            <h5>Deja <%= transaction.getValidation().getDescription() %> </h5>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function validerDemande(idValidation, idHistoriqueTransaction, idTransaction, idUtilisateur, valeurs, bouton) {
                const formData = new FormData();
                formData.append('idValidation', idValidation);
                formData.append('idHistoriqueTransaction', idHistoriqueTransaction);
                formData.append('idTransaction', idTransaction);
                formData.append('idUtilisateur', idUtilisateur);
                formData.append('valeurs', valeurs);

                console.log(formData);
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "http://localhost:8080/cryptaka-1.0-SNAPSHOT/validationTransaction", true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        console.log(xhr.responseText);
                        const response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            const row = bouton.closest("tr");
                            const actionCell = row.querySelector("td:last-child");
                            actionCell.innerHTML = '<span style="color: green; font-weight: bold;">Validé</span>';
                        } else {
                            alert("Erreur : Impossible de valider la demande.");
                        }
                    }
                };
                xhr.send(formData); // Envoi de FormData
            }

            function refuserDemande(idValidation, idHistoriqueTransaction, idTransaction, idUtilisateur, valeurs, bouton) {
                const formData = new FormData();
                formData.append('idValidation', idValidation);
                formData.append('idHistoriqueTransaction', idHistoriqueTransaction);
                formData.append('idTransaction', idTransaction);
                formData.append('idUtilisateur', idUtilisateur);
                formData.append('valeurs', valeurs);

                console.log(formData);
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "http://localhost:8080/cryptaka-1.0-SNAPSHOT/validationTransaction", true); // Nouvelle URL pour refus

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        console.log(xhr.responseText);
                        const response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            const row = bouton.closest("tr");
                            const actionCell = row.querySelector("td:last-child");
                            actionCell.innerHTML = '<span style="color: red; font-weight: bold;">Refusé</span>';
                        } else {
                            alert("Erreur : Impossible de refuser la demande.");
                        }
                    }
                };
                xhr.send(formData); // Envoi de FormData
            }


        </script>
<%@ include file="../../../templates/backoffice/footer.jsp" %>


