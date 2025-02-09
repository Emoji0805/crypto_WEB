<%--
  Created by IntelliJ IDEA.
  User: Mamihery
  Date: 10/01/2025
  Time: 12:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    double resultat = (double) request.getAttribute("resultat");
%>
<html>
<head>
    <title>Resultat Analyse</title>
</head>
<body>
    <h1>Resultat Analyse</h1>
    <% if (resultat != 0) { %>
        <b><%= resultat %> </b>
    <% } %>
</body>
</html>
