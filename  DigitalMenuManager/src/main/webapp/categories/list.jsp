<%@ page import="java.util.*, com.example.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Categories</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: white;
            background: #007bff;
            padding: 8px 14px;
            border-radius: 4px;
            margin-right: 8px;
            font-size: 14px;
        }
        a:hover {
            background: #0056b3;
        }
        .link-secondary {
            background: #6c757d;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px 14px;
            text-align: left;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        tr:hover {
            background: #e9f4ff;
        }
        .actions a {
            padding: 5px 10px;
            font-size: 13px;
        }
        .actions a:first-child {
            background: #28a745;
        }
        .actions a:first-child:hover {
            background: #1e7e34;
        }
        .actions a:last-child {
            background: #dc3545;
        }
        .actions a:last-child:hover {
            background: #a71d2a;
        }
    </style>
</head>
<body>

<h2>Categories</h2>
<a href="categories?action=create">Add Category</a>
<a href="/_DigitalMenuManager" class="link-secondary">Home</a>

<br><br>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Description</th>
    <th>Actions</th>
</tr>
<%
  List<Category> cats = (List<Category>) request.getAttribute("categories");
  if(cats != null && !cats.isEmpty()){
    for(Category c: cats){
%>
<tr>
  <td><%=c.getId()%></td>
  <td><%=c.getName()%></td>
  <td><%=c.getDescription()%></td>
  <td class="actions">
    <a href="categories?action=edit&id=<%=c.getId()%>">Edit</a>
    <a href="categories?action=delete&id=<%=c.getId()%>" onclick="return confirm('Delete this category?')">Delete</a>
  </td>
</tr>
<%    }
  } else { %>
<tr>
    <td colspan="4" style="text-align:center; color:#888;">No categories found</td>
</tr>
<% } %>
</table>

</body>
</html>
