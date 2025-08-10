package com.example.dao;

import com.example.model.Category;
import com.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    private static CategoryDao instance = new CategoryDao();

    private CategoryDao() {}

    public static CategoryDao getInstance() {
        return instance;
    }

    public Category save(Category c) {
        try (Connection conn = DBUtil.getConnection()) {
            if (c.getId() <= 0) {
                String sql = "INSERT INTO categories(name, description) VALUES(?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, c.getName());
                ps.setString(2, c.getDescription());
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    c.setId(rs.getInt(1));
                }
            } else {
                String sql = "UPDATE categories SET name=?, description=? WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, c.getName());
                ps.setString(2, c.getDescription());
                ps.setInt(3, c.getId());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public Category findById(int id) {
        Category c = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM categories WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM categories";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void delete(int id) throws IllegalStateException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM categories WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new IllegalStateException("Category not found: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
