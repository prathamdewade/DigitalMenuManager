package com.example.servlet;

import com.example.dao.UserDao;
import com.example.model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = new User(0, name, email, password);
        UserDao dao = new UserDao();

        if (dao.register(user)) {
            resp.sendRedirect("login.jsp");
        } else {
            resp.sendRedirect("register.jsp?error=1");
        }
    }
}
