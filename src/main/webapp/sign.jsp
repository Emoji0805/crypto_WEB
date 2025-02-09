<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In Form</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/sign.css">
</head>
<body>
    <header>
        <input type="checkbox" name="" id="toggler">
        <label for="toggler" class="fas fa-bars"></label>

        <a href="" class="logo">Project<span>.</span></a>
        <nav class="navbar">
            <a href="index.jsp">Home</a>
        </nav>
    </header>

    <div class="container">
        <!-- Section Image -->
        <div class="image">
            <img src="<%= request.getContextPath() %>/assets/images/sign.jpg" alt="Placeholder Image">
        </div>

        <!-- Section Form -->
        <div class="content">
            <h2>Sign In</h2>
            <div class="form-container">
                <form action="http://localhost:8000/api/test-mail" method="post">
                    <h5>Email</h5>
                    <input type="email" placeholder="Email" name="email" required>
                    <h5>Nom</h5>
                    <input type="nom" placeholder="Nom" name="nom" required>
                    <h5>Password</h5>
                    <input type="password" placeholder="Password" name="mdp" required>
                    <button type="submit">Sign In</button>
                </form>
            </div>
        </div>

    </div>
</body>
</html>

