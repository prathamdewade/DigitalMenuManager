package com.example.servlet;
import com.example.dao.CategoryDao;
import com.example.dao.MenuDao;
import com.example.model.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CategoryServlet extends HttpServlet {
    private CategoryDao dao = CategoryDao.getInstance();
    private MenuDao mdao = MenuDao.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action==null) action="list";
        try {
            switch(action){
                case "create":
                    req.setAttribute("formAction","create");
                    req.getRequestDispatcher("/categories/form.jsp").forward(req,resp);
                    break;
                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("category", dao.findById(id));
                    req.setAttribute("formAction","edit");
                    req.getRequestDispatcher("/categories/form.jsp").forward(req,resp);
                    break;
                case "delete":
                    int did = Integer.parseInt(req.getParameter("id"));
                    // prevent deletion if category used
                    if(mdao.existsWithCategory(did)) {
                        req.setAttribute("error","Cannot delete category in use by menu items.");
                        list(req,resp); break;
                    }
                    dao.delete(did);
                    resp.sendRedirect("categories");
                    break;
                default:
                    list(req,resp);
            }
        } catch(Exception ex){
            req.setAttribute("error", ex.getMessage());
            list(req,resp);
        }
    }
    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", dao.findAll());
        req.getRequestDispatcher("/categories/list.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if("create".equals(action)){
                Category c = new Category();
                c.setName(req.getParameter("name"));
                c.setDescription(req.getParameter("description"));
                if(c.getName()==null || c.getName().trim().isEmpty()){
                    throw new IllegalArgumentException("Name is required");
                }
                dao.save(c);
                resp.sendRedirect("categories");
            } else if("edit".equals(action)){
                int id = Integer.parseInt(req.getParameter("id"));
                Category c = dao.findById(id);
                if(c==null) throw new IllegalStateException("Category not found");
                c.setName(req.getParameter("name"));
                c.setDescription(req.getParameter("description"));
                dao.save(c);
                resp.sendRedirect("categories");
            } else {
                resp.sendRedirect("categories");
            }
        } catch(Exception ex){
            req.setAttribute("error", ex.getMessage());
            doGet(req,resp);
        }
    }
}
