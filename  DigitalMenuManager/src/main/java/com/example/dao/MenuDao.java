package com.example.dao;

import com.example.model.MenuItem;
import com.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDao {
    private static MenuDao instance = new MenuDao();

    private MenuDao() {}

    public static MenuDao getInstance() {
        return instance;
    }

    public MenuItem save(MenuItem m) {
        try (Connection conn = DBUtil.getConnection()) {
            if (m.getId() <= 0) {
                String sql = "INSERT INTO menu_items(name, description, category_id, price) VALUES(?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, m.getName());
                ps.setString(2, m.getDescription());
                if (m.getCategoryId() > 0) {
                    ps.setInt(3, m.getCategoryId());
                } else {
                    ps.setNull(3, Types.INTEGER);
                }
                ps.setDouble(4, m.getPrice());
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    m.setId(rs.getInt(1));
                }
            } else {
                String sql = "UPDATE menu_items SET name=?, description=?, category_id=?, price=? WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, m.getName());
                ps.setString(2, m.getDescription());
                if (m.getCategoryId() > 0) {
                    ps.setInt(3, m.getCategoryId());
                } else {
                    ps.setNull(3, Types.INTEGER);
                }
                ps.setDouble(4, m.getPrice());
                ps.setInt(5, m.getId());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return m;
    }

    public MenuItem findById(int id) {
        MenuItem m = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM menu_items WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                m = new MenuItem(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getInt("category_id"), rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return m;
    }

    public List<MenuItem> findAll() {
        List<MenuItem> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM menu_items";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                list.add(new MenuItem(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getInt("category_id"), rs.getDouble("price")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void delete(int id) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM menu_items WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean existsWithCategory(int categoryId) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT COUNT(*) FROM menu_items WHERE category_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
