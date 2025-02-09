<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Inscription d'un Client</title>
    <!-- loader-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/pace.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/templates/assets/js/pace.min.js"></script>
    <!--favicon-->
    <link rel="icon" href="${pageContext.request.contextPath}/templates/assets/images/picsou2.png" type="image/x-icon">
    <!-- Bootstrap core CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- animate CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/animate.css" rel="stylesheet" type="text/css"/>
    <!-- Icons CSS-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/icons.css" rel="stylesheet" type="text/css"/>
    <!-- Custom Style-->
    <link href="${pageContext.request.contextPath}/templates/assets/css/app-style.css" rel="stylesheet"/>

</head>

<body class="bg-theme bg-theme8">

<!-- start loader -->
<div id="pageloader-overlay" class="visible incoming"><div class="loader-wrapper-outer"><div class="loader-wrapper-inner" ><div class="loader"></div></div></div></div>
<!-- end loader -->

<!-- Start wrapper-->
<div id="wrapper">

    <div class="card card-authentication1 mx-auto my-4">
        <div class="card-body">
            <div class="card-content p-2">
                <div class="text-center">
                    <img src="${pageContext.request.contextPath}/templates/assets/images/picsou.png" alt="logo icon" style="width: 108px; height: 109px;">
                </div>
                <div class="card-title text-uppercase text-center py-3">Inscription</div>
                <form method="post">
                    <div class="form-group">
                        <label for="exampleInputName" class="sr-only">Nom</label>
                        <div class="position-relative has-icon-right">
                            <input type="text" id="exampleInputName" class="form-control input-shadow" placeholder="Enter Your Name" name="nom" required>
                            <div class="form-control-position">
                                <i class="icon-user"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmailId" class="sr-only">Email ID</label>
                        <div class="position-relative has-icon-right">
                            <input type="text" id="exampleInputEmailId" class="form-control input-shadow" placeholder="Enter Your Email ID" name="email" required>
                            <div class="form-control-position">
                                <i class="icon-envelope-open"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword" class="sr-only">Mot de passe</label>
                        <div class="position-relative has-icon-right">
                            <input type="text" id="exampleInputPassword" class="form-control input-shadow" placeholder="Choose Password" name="password" required>
                            <div class="form-control-position">
                                <i class="icon-lock"></i>
                            </div>
                        </div>
                    </div>


                    <button type="submit" class="btn btn-light btn-block waves-effect waves-light">S'inscrire</button>
                    <div class="text-center mt-3">S'inscrire avec</div>

                </form>
            </div>
        </div>
        <div class="card-footer text-center py-3">
            <p class="text-warning mb-0">Deja un compte? <a href="index.jsp"> Se Connecter</a></p>
        </div>
    </div>

    <!--Start Back To Top Button-->
    <a href="javaScript:void(0);" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

    <!--start color switcher-->
    <div class="right-sidebar">
        <div class="switcher-icon">
            <i class="zmdi zmdi-settings zmdi-hc-spin"></i>
        </div>
        <div class="right-sidebar-content">

            <p class="mb-0">Gaussion Texture</p>
            <hr>

            <ul class="switcher">
                <li id="theme1"></li>
                <li id="theme2"></li>
                <li id="theme3"></li>
                <li id="theme4"></li>
                <li id="theme5"></li>
                <li id="theme6"></li>
            </ul>

            <p class="mb-0">Gradient Background</p>
            <hr>

            <ul class="switcher">
                <li id="theme7"></li>
                <li id="theme8"></li>
                <li id="theme9"></li>
                <li id="theme10"></li>
                <li id="theme11"></li>
                <li id="theme12"></li>
                <li id="theme13"></li>
                <li id="theme14"></li>
                <li id="theme15"></li>
            </ul>

        </div>
    </div>
    <!--end color switcher-->

</div><!--wrapper-->

<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/templates/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/templates/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/templates/assets/js/bootstrap.min.js"></script>

<!-- sidebar-menu js -->
<script src="${pageContext.request.contextPath}/templates/assets/js/sidebar-menu.js"></script>
<script src="${pageContext.request.contextPath}/templates/assets/js/app-script.js"></script>

<script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
    import { getAuth, createUserWithEmailAndPassword, updateProfile } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-auth.js";

    // Configuration Firebase
    const firebaseConfig = {
        apiKey: "AIzaSyBmW2_rJJZpQhDS6CqwAoIKXsaco8o_pkQ",
        authDomain: "crypto-test-50468.firebaseapp.com",
        databaseURL: "https://crypto-test-50468-default-rtdb.firebaseio.com",
        projectId: "crypto-test-50468",
        storageBucket: "crypto-test-50468.firebasestorage.app",
        messagingSenderId: "697811289321",
        appId: "1:697811289321:web:5f58bbd99cb7c506439c78",
        measurementId: "G-GFWCECBBH4"
    };

    const app = initializeApp(firebaseConfig);
    const auth = getAuth(app);

    document.querySelector("form").addEventListener("submit", function (event) {
        event.preventDefault();

        let nom = document.getElementById("exampleInputName").value;
        let email = document.getElementById("exampleInputEmailId").value;
        let password = document.getElementById("exampleInputPassword").value;

        var data = {
            email: email,
            mdp: password,
            nom: nom
        };

        if (!nom || !email || !password) {
            alert("Veuillez remplir tous les champs !");
            return;
        }

        // 🔥 Inscription dans Firebase
        createUserWithEmailAndPassword(auth, email, password)
            .then((userCredential) => {
                let user = userCredential.user;

                return updateProfile(user, { displayName: nom }).then(() => user);
            })

        fetch('http://localhost:8000/api/test-mail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (data.redirect) {
                    alert("Inscription reussie !...");
                    window.location.href = data.redirect;
                } else {
                    alert(data.message);
                }
            })
            .catch(error => alert(error));

    });
</script>


</body>
</html>
