<%@ page import="java.util.*, com.example.model.MenuItem, com.example.dao.CategoryDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Menu Items</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f4f6f8;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .actions {
            margin-bottom: 20px;
            text-align: center;
        }
        .actions a {
            display: inline-block;
            margin: 0 10px;
            padding: 8px 14px;
            background: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .actions a:hover {
            background: #217dbb;
        }
        table {
            border-collapse: collapse;
            margin: auto;
            width: 90%;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        a.table-link {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        a.table-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Menu Items</h2>

<div class="actions">
    <a href="menus?action=create">Add New Item</a>
    <a href="../_DigitalMenuManager">Home</a>
</div>

<table>
  <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Category</th>
      <th>Price</th>
      <th>Actions</th>
  </tr>
  <%
    List<MenuItem> items = (List<MenuItem>) request.getAttribute("items");
    CategoryDao cdao = CategoryDao.getInstance();
    if(items!=null){
      for(MenuItem it: items){
  %>
  <tr>
    <td><%=it.getId()%></td>
    <td><%=it.getName()%></td>
    <td><%= (cdao.findById(it.getCategoryId())!=null? cdao.findById(it.getCategoryId()).getName() : "—") %></td>
    <td><%=String.format("%.2f", it.getPrice())%></td>
    <td>
      <a class="table-link" href="menus?action=view&id=<%=it.getId()%>">View</a> |
      <a class="table-link" href="menus?action=edit&id=<%=it.getId()%>">Edit</a> |
      <a class="table-link" href="menus?action=delete&id=<%=it.getId()%>" onclick="return confirm('Delete this item?')">Delete</a>
    </td>
  </tr>
  <%   }
    } else { %>
  <tr><td colspan="5">No items found.</td></tr>
  <% } %>
</table>

</body>
</html>
