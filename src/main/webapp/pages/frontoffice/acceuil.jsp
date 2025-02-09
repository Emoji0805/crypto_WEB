<%@ include file="../../templates/frontoffice/sidebar.jsp" %>
<%@ include file="../../templates/frontoffice/header.jsp" %>
<style>
    .crypto-card {
        color: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0px 6px 25px rgba(0, 0, 0, 0.25);
        transition: transform 0.3s ease-in-out;
        max-width: 1000px; /* Largeur augmentée */
        height: 700px; /* Hauteur augmentée */
        padding-top: 100px;
    }

    .crypto-card:hover {
        transform: translateY(-5px);
    }

    .crypto-img-container {
        height: 100%;
    }

    .crypto-img {
        border-top-left-radius: 20px;
        border-bottom-left-radius: 20px;
        object-fit: cover;
        height: 100%; /* Image occupe toute la hauteur */
        width: 100%;
    }

    .crypto-card .card-body {
        padding: 50px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 100%;
    }

    .crypto-title {
        font-size: 3rem; /* Titre encore plus grand */
        font-weight: bold;
        text-transform: uppercase;
        background: linear-gradient(90deg, #fbc531, #e84118);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        display: inline-block;
        margin-bottom: 20px;
    }

    .crypto-description {
        font-size: 1.4rem; /* Texte plus grand */
        line-height: 1.8;
        opacity: 0.9;
    }

    .crypto-footer {
        font-size: 1rem;
        font-style: italic;
        opacity: 0.8;
    }
</style>

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
            <div class="col-lg-10 mx-auto">
                <div class="card shadow-lg crypto-card">
                    <div class="row g-0">
                        <div class="col-md-5 crypto-img-container">
                            <img src="${pageContext.request.contextPath}/templates/assets/images/picsou2.png" class="img-fluid rounded-start" alt="Crypto Monnaie">
                        </div>
                        <div class="col-md-7">
                            <div class="card-body">
                                <h3 class="card-title text-primary crypto-title">Crypto Monnaie</h3>
                                <p class="card-text crypto-description">
                                    Decouvrez le monde fascinant des crypto-monnaies.
                                    Investissez, echangez et suivez en temps reel les tendances des monnaies numeriques.
                                    Avec notre plateforme, restez informe sur les dernieres evolutions du marche crypto.
                                </p>
                                <p class="card-text crypto-footer">
                                    <small class="text-muted">Mise a jour en temps reel</small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%@ include file="../../templates/frontoffice/footer.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>