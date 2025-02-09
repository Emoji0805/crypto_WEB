<!DOCTYPE html>
<html>
<head>
	<title>Login Form</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/assets/css/login.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<img class="wave" src="<%= request.getContextPath() %>/assets/images/wave.png">
	<div class="container">
		<div class="img">
			<img src="<%= request.getContextPath() %>/assets/images/login.png">
		</div>
		<div class="login-content">
			<form action="">
				<img src="<%= request.getContextPath() %>/assets/images/avatar.jpg">
				<h2 class="title">Log in</h2>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>Email</h5>
           		   		<input type="email" class="input">
           		   </div>
           		</div>
           		<div class="input-div pass">
           		   <div class="i"> 
           		    	<i class="fas fa-lock"></i>
           		   </div>
           		   <div class="div">
           		    	<h5>Password</h5>
           		    	<input type="password" class="input">
            	   </div>
            	</div>
            	<a href="#">Forgot Password?</a>
            	<input type="submit" class="btn" value="Login">
            </form>
        </div>
    </div>
    <script type="text/javascript" src="<%= request.getContextPath() %>/assets/css/main.js"></script>
</body>
</html>
