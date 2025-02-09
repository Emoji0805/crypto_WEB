<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin dashboard</title>
    <head>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/dashboard.css">
    </head>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <ul class="menu">
                <li class="active">
                    <a href="#">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-user"></i>
                        <span>Profile</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-chart-bar"></i>
                        <span>Statistics</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-briefcase"></i>
                        <span>Careers</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-question-circle"></i>
                        <span>FAQ</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-star"></i>
                        <span>Testimonials</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
                <li class="logout">
                    <a href="#">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Log out</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- main content body-->
    <div class="main--content">
        <div class="header--wrapper">
            <div class="header--title">
                <span>Crypto</span>
                <h2>Dashboard</h2>
            </div>
            <div class="user--info">
                <div class="search--box">
                    <i class="fa-solid fa-search"></i>
                    <input type="text" placeholder="Search">
                </div>
                <img src="<%= request.getContextPath() %>/assets/images/isaia1.jpg" alt="">
            </div>
        </div>

    </div>

    
</body>
</html>