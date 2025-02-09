<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Crypto Monnaie Back Office</title>
    <!-- loader-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/pace.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/templates/assets/js/pace.min.js"></script>
    <!--favicon-->
    <link rel="icon" href="${pageContext.request.contextPath}/templates/assets/images/favicon.ico" type="image/x-icon">
    <!-- Vector CSS -->
    <link href="${pageContext.request.contextPath}/templates/assets/plugins/vectormap/jquery-jvectormap-2.0.2.css" rel="stylesheet"/>
    <!-- simplebar CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
    <!-- Bootstrap core CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- animate CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/animate.css" rel="stylesheet" type="text/css"/>
    <!-- Icons CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/icons.css" rel="stylesheet" type="text/css"/>
    <!-- Sidebar CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/sidebar-menu.css" rel="stylesheet"/>
    <!-- Custom Style-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/app-style.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Import de Chart.js -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery pour AJAX -->
</head>

<body class="bg-theme bg-theme1">

<!-- Start wrapper-->
<div id="wrapper">

    <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
        <div class="brand-logo">
            <a href="index.html">
                <img src="${pageContext.request.contextPath}/templates/assets/images/picsou2.png" class="logo-icon" alt="logo icon">
                <h5 class="logo-text">CRYPTO</h5>
            </a>
        </div>
        <ul class="sidebar-menu do-nicescrol">
            <li class="sidebar-header">MAIN NAVIGATION</li>
            <li>
                <a href="${pageContext.request.contextPath}/validationTransaction">
                    <i class="fa fa-check-circle"></i> <span>Validation des Transactions</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/CommissionServlet?mod=liste">
                    <i class="fa fa-percent"></i> <span>Commissions</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/TypeAnalyseServlet">
                    <i class="fa fa-file"></i> <span>Type Analyse</span>
                </a>
            </li>
        </ul>

    </div>
    <!--End sidebar-wrapper-->
