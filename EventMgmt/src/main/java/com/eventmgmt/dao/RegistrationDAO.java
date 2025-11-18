package com.eventmgmt.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.eventmgmt.model.Registration;
import com.eventmgmt.model.User;

public class RegistrationDAO {

    // Register user for event
    public boolean register(int userId, int eventId) {
        String sql = "INSERT INTO registrations (user_id, event_id) VALUES (?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Check if a user is already registered for event
    public boolean isUserRegistered(int userId, int eventId) {
        String sql = "SELECT id FROM registrations WHERE user_id=? AND event_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Unregister user from event
    public boolean unregister(int userId, int eventId) {
        String sql = "DELETE FROM registrations WHERE user_id=? AND event_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Count how many users registered for event
    public int getCountForEvent(int eventId) {
        String sql = "SELECT COUNT(*) FROM registrations WHERE event_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Get list of users who registered for a specific event
    public List<User> getRegisteredUsers(int eventId) {
        List<User> list = new ArrayList<>();

        String sql = "SELECT u.id, u.name, u.email, u.phone, r.reg_date " +
                     "FROM registrations r JOIN users u ON r.user_id = u.id " +
                     "WHERE r.event_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRegistrationDate(rs.getString("reg_date")); // new field

                list.add(user);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

}
