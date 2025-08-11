<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="com.example.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>Welcome - Digital Menu Manager</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            text-align: center;
            padding-top: 50px;
        }
        h1 { color: #333; }
        .links { margin-top: 30px; }
        a {
            text-decoration: none;
            background: #007bff;
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            margin: 10px;
            display: inline-block;
        }
        a:hover { background: #0056b3; }
        .auth {
            margin-top: 20px;
        }
        .welcome {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h1>Digital Menu Manager</h1>

    <%
        if (user == null) {
    %>
        <p class="welcome">Please login or register to manage menus.</p>

        <div class="auth">
            <a href="login.jsp">Login</a>
            <a href="register.jsp" style="background:#28a745;">Register</a>
        </div>
    <%
        } else {
    %>
        <p class="welcome">Welcome, <strong><%= user.getName() %></strong>!</p>

        <p>Manage your categories and menus easily</p>

        <div class="links">
            <a href="categories">Manage Categories</a>
            <a href="menus">Manage Menus</a>
            <a href="logout" style="background:#dc3545;">Logout</a>
        </div>
    <%
        }
    %>
</body>
</html>
