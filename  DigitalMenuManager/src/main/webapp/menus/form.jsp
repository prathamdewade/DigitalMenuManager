<%@ page import="com.example.model.MenuItem, java.util.*, com.example.dao.CategoryDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  MenuItem item = (MenuItem) request.getAttribute("item");
  String action = (String) request.getAttribute("formAction");
  List categories = CategoryDao.getInstance().findAll();
%>
<html>
<head>
    <title><%= (item==null? "Create":"Edit") %> Menu Item</title>
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
            max-width: 600px;
            margin: auto;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 6px;
        }
        table {
            width: 100%;
        }
        td {
            padding: 8px;
            vertical-align: top;
        }
        input[type="text"], input[type="number"], textarea, select {
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
        select {
            background: white;
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

<h2><%= (item==null? "Create":"Edit") %> Menu Item</h2>
<form method="post" action="menus">
  <input type="hidden" name="id" value="<%= (item!=null? item.getId() : "") %>" />
  <input type="hidden" name="action" value="<%=action%>"/>
  <table>
    <tr>
        <td>Name:</td>
        <td><input type="text" name="name" value="<%= (item!=null?item.getName():"") %>" required/></td>
    </tr>
    <tr>
        <td>Description:</td>
        <td><textarea name="description"><%= (item!=null?item.getDescription():"") %></textarea></td>
    </tr>
    <tr>
        <td>Category:</td>
        <td>
          <select name="categoryId" required>
            <option value="">-- Select --</option>
            <% for(Object o: categories){ 
                   com.example.model.Category c = (com.example.model.Category)o; %>
              <option value="<%=c.getId()%>" <%= (item!=null && item.getCategoryId()==c.getId() ? "selected":"") %>>
                  <%=c.getName()%>
              </option>
            <% } %>
          </select>
        </td>
    </tr>
    <tr>
        <td>Price:</td>
        <td><input name="price" type="number" step="0.01" value="<%= (item!=null? item.getPrice():"0.00") %>" required/></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: right;">
            <button type="submit">Save</button>
            <a href="menus">Cancel</a>
        </td>
    </tr>
  </table>
</form>

</body>
</html>
