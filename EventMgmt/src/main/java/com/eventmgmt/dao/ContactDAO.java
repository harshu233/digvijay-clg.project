package com.eventmgmt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.eventmgmt.model.ContactMessage;

public class ContactDAO {

    // Save Contact
    public boolean saveMessage(ContactMessage msg) {
        boolean success = false;
        String sql = "INSERT INTO contact_messages (name, email, phone, message) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getPhone());
            ps.setString(4, msg.getMessage());

            success = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Fetch All + Search Support
    public List<ContactMessage> getAllMessages(String search) {
        List<ContactMessage> list = new ArrayList<>();
        String sql;

        if (search != null && !search.trim().isEmpty()) {
            search = "%" + search + "%";
            sql = "SELECT * FROM contact_messages WHERE name LIKE ? OR email LIKE ? ORDER BY submitted_at DESC";
        } else {
            sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (sql.contains("LIKE")) {
                ps.setString(1, search);
                ps.setString(2, search);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ContactMessage cm = new ContactMessage();
                    cm.setId(rs.getInt("id"));
                    cm.setName(rs.getString("name"));
                    cm.setEmail(rs.getString("email"));
                    cm.setPhone(rs.getString("phone"));
                    cm.setMessage(rs.getString("message"));
                    cm.setSubmittedAt(rs.getTimestamp("submitted_at"));
                    list.add(cm);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete Message
    public boolean deleteMessage(int id) {
        String sql = "DELETE FROM contact_messages WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
