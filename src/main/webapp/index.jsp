<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index page design</title>


    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/index.css">
</head>

<body>
<!--header section starts -->
<header>
    <input type="checkbox" name="" id="toggler">
    <label for="toggler" class="fas fa-bars"></label>

    <a href="" class="logo">Crypt<span>.</span></a>
    <nav class="navbar">
        <a href="#home">Home</a>
        <a href="#about">About</a>
    </nav>

<%--    <div class="icons">--%>
<%--        <a href="sign.jsp"><button class="bouton">Sign in</button></a>--%>
<%--        <a href="login.jsp"><button class="bouton">Log in</button></a>--%>
<%--        <a href="GestionPortefeuilleServlet"><button class="bouton">Gestion portefeuille</button></a>--%>
<%--        <a href="EchangeServlet"><button class="bouton">Echange</button></a>--%>
<%--        <a href="TransactionServlet"><button class="bouton">Transaction</button></a>--%>
<%--        <a href="CoursServlet?mode=not_random"><button class="bouton">Cours</button></a>--%>
    </div>
</header>
<!--header section ends -->

<!--home section starts -->
<section class="home" id="home">
    <div class="content">
        <h3>PICSOU Wallet</h3>
        <span>Achat et vente de cryptomonnaie</span>
        <p>
            Cryptomoney is ...
        </p>
        <a href="#" class="btn">Start now</a>
    </div>
    <div class="back">
        <img src="<%= request.getContextPath() %>/templates/assets/images/picsou2.png" alt="Back picture" style="margin-top: 10%;">
    </div>
</section>
<!--home section ends -->

<!--about section starts -->
<section class="about" id="about">

    <h1 class="heading"><span> about </span> us</h1>

    <div class="row">
        <div class="video-container">
            <video src="<%= request.getContextPath() %>/assets/images/about_video.mp4" loop autoplay muted></video>
            <h3>Just chill</h3>
        </div>

        <div class="content">
            <h3>Why choose us?</h3>
            <p>
                Our products are not trashes like the others after using them for some time.
                We can repay you back if you are not satisfied by our products but it does not risk to happen.
            </p>
            <p>
                We do have experiments to satisfy client's expectations.
                You don't have to be afraid of how you can get your commands, we ensure everything.
            </p>
            <a href="#" class="btn">Learn more</a>
        </div>
    </div>
</section>
<!--about section ends -->

<!--icons section starts -->
<section class="icons-container">
    <div class="icons">
        <img src="<%= request.getContextPath() %>/assets/images/icon_1.png" alt="">
        <div class="info">
            <h3>Free delivery</h3>
            <span>on all orders</span>
        </div>
    </div>

    <div class="icons">
        <img src="<%= request.getContextPath() %>/assets/images/icon_2.png" alt="">
        <div class="info">
            <h3>10 days return</h3>
            <span>money back guarantee</span>
        </div>
    </div>

    <div class="icons">
        <img src="<%= request.getContextPath() %>/assets/images/icon_3.png" alt="">
        <div class="info">
            <h3>Offer & Gifts</h3>
            <span>on all orders (but don(t expect too much!)) </span>
        </div>
    </div>

    <div class="icons">
        <img src="<%= request.getContextPath() %>/assets/images/icon_4.png" alt="">
        <div class="info">
            <h3>Secure payments</h3>
            <span>protected by paypal </span>
        </div>
    </div>
</section>

<!--icons section ends -->

<!--footer section starts -->
<section class="footer">
    <div class="box-container">
        <div class="box">
            <h3>Quick Links</h3>
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">Log In</a>
        </div>

        <div class="box">
            <h3>Member of the group</h3>
            <a href="#">Mamitiana </a>
            <a href="#">Mamihery</a>
            <a href="#">Isaia</a>
            <a href="#">Toky</a>
        </div>

    </div>

</section>
<!--footer section ends -->

</body>

</html>