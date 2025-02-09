<%@ include file="templates/frontoffice/sidebar.jsp" %>
<%@ include file="templates/frontoffice/header.jsp" %>



<div class="clearfix"></div>

<div class="content-wrapper">
    <div class="container-fluid">
        <div id="charts-container">
            <canvas id="cryptoChart" style="color: #fff; width: 100%"></canvas>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById('cryptoChart').getContext('2d');
        const MAX_POINTS = 10; // 🔥 Définir le nombre maximal de points affichés

        const colors = [
            'rgba(255, 99, 132, 1)',    // Rouge
            'rgba(54, 162, 235, 1)',    // Bleu
            'rgba(255, 206, 86, 1)',    // Jaune
            'rgba(75, 192, 192, 1)',    // Vert
            'rgba(153, 102, 255, 1)',   // Violet
            'rgba(255, 159, 64, 1)',    // Orange
            'rgba(0, 255, 127, 1)',     // Vert clair
            'rgba(128, 0, 128, 1)',     // Pourpre
            'rgba(255, 69, 0, 1)',      // Rouge orangé
            'rgba(70, 130, 180, 1)'     // Bleu acier
        ];

        let cryptoChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: []
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        title: { display: true, text: 'Temps', color: 'white', font: { size: 14 } },
                        ticks: { color: '#fff', font: { size: 12 } }
                    },
                    y: {
                        title: { display: true, text: 'Valeur', color: 'white', font: { size: 14 } },
                        ticks: { color: '#fff', font: { size: 12 } }
                    }
                },
                plugins: {
                    legend: {
                        labels: { color: '#fff' , font: { size: 12 } },
                        display: true,
                        onClick: function (evt, legendItem, legend) {
                            let index = legendItem.datasetIndex;
                            let meta = legend.chart.getDatasetMeta(index);
                            meta.hidden = meta.hidden === null ? true : null;
                            legend.chart.update();
                        }
                    }
                }
            }
        });

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

                    let previousVisibility = {};
                    cryptoChart.data.datasets.forEach((dataset, index) => {
                        previousVisibility[dataset.label] = cryptoChart.getDatasetMeta(index).hidden;
                    });

                    let cryptoMap = {};
                    let updatedLabels = [];

                    data.forEach(cour => {
                        let cryptoId = cour.idCrypto;
                        let cryptoName = cour.nom_crypto;
                        let label = cryptoName;

                        if (!cryptoMap[cryptoId]) {
                            let existingDataset = cryptoChart.data.datasets.find(d => d.label === label);

                            cryptoMap[cryptoId] = existingDataset || {
                                label: label,
                                data: [],
                                borderColor: colors[Object.keys(cryptoMap).length % colors.length],
                                backgroundColor: colors[Object.keys(cryptoMap).length % colors.length].replace('1)', '0.2)'),
                                fill: false,
                                tension: 0.4
                            };
                        }

                        cryptoMap[cryptoId].data.push(cour.valeur);
                        updatedLabels.push(cour.daty);
                    });

                    updatedLabels = updatedLabels.slice(-MAX_POINTS);

                    Object.values(cryptoMap).forEach(dataset => {
                        dataset.data = dataset.data.slice(-MAX_POINTS);
                    });

                    cryptoChart.data.labels = updatedLabels;
                    cryptoChart.data.datasets = Object.values(cryptoMap);

                    cryptoChart.data.datasets.forEach(dataset => {
                        dataset.hidden = previousVisibility.hasOwnProperty(dataset.label) ? previousVisibility[dataset.label] : false;
                    });

                    cryptoChart.update();
                },
                error: function (err) {
                    console.error("Erreur de récupération des données:", err);
                }
            });
        }

        fetchCryptoData();
        setInterval(fetchCryptoData, 10000);
    });
</script>

<%@ include file="templates/frontoffice/footer.jsp" %>
