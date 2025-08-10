<%@ page import="com.example.model.MenuItem, com.example.dao.CategoryDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  MenuItem item = (MenuItem) request.getAttribute("item");
  CategoryDao cdao = CategoryDao.getInstance();
%>
<html>
<head>
    <title>View Menu Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f4f6f8;
        }
        .container {
            background: #fff;
            padding: 25px;
            max-width: 500px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        p {
            font-size: 16px;
            margin: 8px 0;
        }
        strong {
            color: #555;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 14px;
            background: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        a:hover {
            background: #217dbb;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Menu Item Details</h2>
    <p><strong>ID:</strong> <%=item.getId()%></p>
    <p><strong>Name:</strong> <%=item.getName()%></p>
    <p><strong>Description:</strong> <%=item.getDescription()!=null?item.getDescription():"-" %></p>
    <p><strong>Category:</strong> <%= (cdao.findById(item.getCategoryId())!=null? cdao.findById(item.getCategoryId()).getName() : "—") %></p>
    <p><strong>Price:</strong> <%=String.format("%.2f", item.getPrice())%></p>
    <a href="menus">Back to List</a>
</div>

</body>
</html>
