<%@ page import="mamt.project.cryptaka.models.TypeAnalyse" %>
<%@ page import="java.util.List" %>
<%@ page import="mamt.project.cryptaka.models.Crypto" %>
<%@ include file="../../../templates/backoffice/sidebar.jsp" %>
<%@ include file="../../../templates/backoffice/header.jsp" %>


<div class="clearfix"></div>

<div class="content-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Faire des Analyses</div>
                        <hr>
                        <form action="TypeAnalyseServlet" method="post">
                            <div class="form-group">
                                <label for="typeAnalyse">Type d'Analyse :</label>
                                <select name="typeAnalyse" id="typeAnalyse" class="form-control">
                                    <%
                                        List<TypeAnalyse> typesAnalyse = (List<TypeAnalyse>) request.getAttribute("typesAnalyse");
                                        if (typesAnalyse != null) {
                                            for (TypeAnalyse type : typesAnalyse) {
                                    %>
                                    <option value="<%= type.getId_type_analyse() %>"><%= type.getNom_analyse() %></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Choisissez les Cryptos :</label><br>
                                <input type="checkbox" name="crypto" value="all" checked> Tous<br>
                                <%
                                    List<Crypto> cryptos = (List<Crypto>) request.getAttribute("cryptos");
                                    if (cryptos != null) {
                                        for (Crypto crypto : cryptos) {
                                %>
                                <input type="checkbox" name="crypto" value="<%= crypto.getIdCrypto() %>"> <%= crypto.getNom() %><br>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <div class="form-group">
                                <label for="dateMin">Date et Heure Min :</label>
                                <input type="datetime-local" id="dateMin" name="dateMin" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="dateMax">Date et Heure Max :</label>
                                <input type="datetime-local" id="dateMax" name="dateMax" class="form-control">
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-light btn-round px-5">Valider</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div><!--End Row-->




    <%@ include file="../../../templates/backoffice/footer.jsp" %>