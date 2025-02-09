<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>Inscription d'un Admin</title>
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
        <div class="card-title text-uppercase text-center py-3">Validation du code PIN</div>
        <form onsubmit="submitForm(event)">
          <div class="form-group">
            <label for="pin" class="sr-only">Code PIN</label>
            <div class="position-relative has-icon-right">
              <input type="text" id="pin" class="form-control input-shadow" placeholder="Enter le code PIN" required>
              <div class="form-control-position">
                <i class="icon-user"></i>
              </div>
            </div>
          </div>
          <button type="submit" class="btn btn-light btn-block waves-effect waves-light">Verifier</button>
        </form>

        <script>
          function submitForm(event) {
            event.preventDefault();

            var pin = document.getElementById("pin").value;

            var data = {
              pin: pin
            };

            fetch('http://localhost:8000/mfa/verify-pin', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify(data)
            })
                    .then(response => response.json())
                    .then(data => {
                      if (data.redirect) {
                        window.location.href = data.redirect;
                      } else {
                        alert(data.message);
                      }
                    })
                    .catch(error => console.error("Erreur:", error));
          }

        </script>
      </div>
    </div>
    <div class="card-footer text-center py-3">
      <p class="text-warning mb-0">Already have an account? <a href="../backoffice/index.jsp"> Sign In here</a></p>
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

<!-- Custom scripts -->
<script src="${pageContext.request.contextPath}/templates/assets/js/app-script.js"></script>

</body>
</html>
