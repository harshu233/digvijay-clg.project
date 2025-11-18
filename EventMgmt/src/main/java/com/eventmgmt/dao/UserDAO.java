package com.eventmgmt.dao;

import com.eventmgmt.model.User;
import java.sql.*;

public class UserDAO {

    public boolean addUser(User u) {
        String sql = "INSERT INTO users (name,email,password,is_admin) VALUES (?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setInt(4, u.isAdmin() ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public User findByEmailAndPassword(String email, String password) {
        String sql = "SELECT id,name,email,is_admin FROM users WHERE email=? AND password=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setAdmin(rs.getInt("is_admin") == 1);
                return u;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
    
    public static void updateLastEventSeen(int userId) {
        String sql = "UPDATE users SET last_event_seen = NOW() WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
