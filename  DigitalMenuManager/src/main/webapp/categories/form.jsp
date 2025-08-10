<%@ page import="com.example.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Category cat = (Category) request.getAttribute("category");
  String action = (String) request.getAttribute("formAction");
%>
<html>
<head>
    <title><%= (cat==null? "Create":"Edit") %> Category</title>
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
        form {
            background: white;
            padding: 20px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 6px;
        }
        table {
            width: 100%;
        }
        td {
            padding: 8px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        button {
            background: #28a745;
            color: white;
            padding: 8px 14px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        button:hover {
            background: #1e7e34;
        }
        a {
            text-decoration: none;
            background: #6c757d;
            color: white;
            padding: 8px 14px;
            border-radius: 4px;
            margin-left: 8px;
            font-size: 14px;
        }
        a:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>

<h2><%= (cat==null? "Create":"Edit") %> Category</h2>
<form method="post" action="categories">
  <input type="hidden" name="id" value="<%= (cat!=null? cat.getId() : "") %>" />
  <input type="hidden" name="action" value="<%=action%>"/>
  <table>
    <tr>
        <td>Name:</td>
        <td><input type="text" name="name" value="<%= (cat!=null?cat.getName():"") %>" required/></td>
    </tr>
    <tr>
        <td>Description:</td>
        <td><textarea name="description"><%= (cat!=null?cat.getDescription():"") %></textarea></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: right;">
            <button type="submit">Save</button>
            <a href="categories">Cancel</a>
        </td>
    </tr>
  </table>
</form>

</body>
</html>
