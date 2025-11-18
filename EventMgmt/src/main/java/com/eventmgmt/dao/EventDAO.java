package com.eventmgmt.dao;

import com.eventmgmt.model.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // Get all events
    public static List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY start_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event e = new Event();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setDescription(rs.getString("description"));
                e.setLocation(rs.getString("location"));
                e.setStartDate(rs.getString("start_date"));   // stored as string
                e.setEndDate(rs.getString("end_date"));
                e.setCapacity(rs.getInt("capacity"));
                e.setImageFile(rs.getString("image_file"));
                list.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get event by ID
    public static Event getById(int id) {
        String sql = "SELECT * FROM events WHERE id=?";
        Event e = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                e = new Event();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setDescription(rs.getString("description"));
                e.setLocation(rs.getString("location"));
                e.setStartDate(rs.getString("start_date"));
                e.setEndDate(rs.getString("end_date"));
                e.setCapacity(rs.getInt("capacity"));
                e.setImageFile(rs.getString("image_file"));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return e;
    }

    // Add event
    public static boolean addEvent(Event e) {
        String sql = "INSERT INTO events (title, description, location, start_date, end_date, capacity, image_file) VALUES (?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setString(3, e.getLocation());
            ps.setString(4, e.getStartDate());
            ps.setString(5, e.getEndDate());
            ps.setInt(6, e.getCapacity());
            ps.setString(7, e.getImageFile());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Update event
    public static boolean updateEvent(Event e) {
        String sql = "UPDATE events SET title=?, description=?, location=?, start_date=?, end_date=?, capacity=?, image_file=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setString(3, e.getLocation());
            ps.setString(4, e.getStartDate());
            ps.setString(5, e.getEndDate());
            ps.setInt(6, e.getCapacity());
            ps.setString(7, e.getImageFile());
            ps.setInt(8, e.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Delete event
    public static boolean deleteEvent(int id) {
        String sql = "DELETE FROM events WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    public static Event getLatestEvent() {
        Event e = null;
        String sql = "SELECT * FROM events ORDER BY created_at DESC LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                e = new Event();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return e;
    }


    
}
