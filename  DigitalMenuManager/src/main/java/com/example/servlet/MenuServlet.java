package com.example.servlet;
import com.example.dao.MenuDao;
import com.example.dao.CategoryDao;
import com.example.model.MenuItem;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MenuServlet extends HttpServlet {
    private MenuDao dao = MenuDao.getInstance();
    private CategoryDao cdao = CategoryDao.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action==null) action="list";
        try {
            switch(action){
                case "create":
                    req.setAttribute("formAction","create");
                    req.getRequestDispatcher("/menus/form.jsp").forward(req,resp);
                    break;
                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("item", dao.findById(id));
                    req.setAttribute("formAction","edit");
                    req.getRequestDispatcher("/menus/form.jsp").forward(req,resp);
                    break;
                case "view":
                    int vid = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("item", dao.findById(vid));
                    req.getRequestDispatcher("/menus/view.jsp").forward(req,resp);
                    break;
                case "delete":
                    int did = Integer.parseInt(req.getParameter("id"));
                    dao.delete(did);
                    resp.sendRedirect("menus");
                    break;
                default:
                    req.setAttribute("items", dao.findAll());
                    req.getRequestDispatcher("/menus/list.jsp").forward(req,resp);
            }
        } catch(Exception ex){
            req.setAttribute("error", ex.getMessage());
            req.getRequestDispatcher("/menus/list.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if("create".equals(action)){
                MenuItem m = new MenuItem();
                m.setName(req.getParameter("name"));
                m.setDescription(req.getParameter("description"));
                String catId = req.getParameter("categoryId");
                m.setCategoryId((catId==null || catId.isEmpty())? 0: Integer.parseInt(catId));
                m.setPrice(Double.parseDouble(req.getParameter("price")));
                if(m.getName()==null || m.getName().trim().isEmpty()) throw new IllegalArgumentException("Name is required");
                dao.save(m);
                resp.sendRedirect("menus");
            } else if("edit".equals(action)){
                int id = Integer.parseInt(req.getParameter("id"));
                MenuItem m = dao.findById(id);
                if(m==null) throw new IllegalStateException("Item not found");
                m.setName(req.getParameter("name"));
                m.setDescription(req.getParameter("description"));
                String catId = req.getParameter("categoryId");
                m.setCategoryId((catId==null || catId.isEmpty())? 0: Integer.parseInt(catId));
                m.setPrice(Double.parseDouble(req.getParameter("price")));
                dao.save(m);
                resp.sendRedirect("menus");
            } else {
                resp.sendRedirect("menus");
            }
        } catch(Exception ex){
            req.setAttribute("error", ex.getMessage());
            doGet(req,resp);
        }
    }
}
