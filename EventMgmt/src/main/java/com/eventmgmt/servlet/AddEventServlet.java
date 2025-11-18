package com.eventmgmt.servlet;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.eventmgmt.model.Event;
import com.eventmgmt.dao.EventDAO;

@WebServlet("/AddEventServlet")
@MultipartConfig
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Get form data
        String title = request.getParameter("event_name");
        String desc = request.getParameter("event_desc");
        String location = request.getParameter("event_location");
        int capacity = Integer.parseInt(request.getParameter("event_capacity"));

        String startDate = request.getParameter("start_date");
        String startTime = request.getParameter("start_time");
        String startDateTime = startDate + " " + startTime + ":00";

        String endDate = request.getParameter("end_date");
        String endTime = request.getParameter("end_time");
        String endDateTime = endDate + " " + endTime + ":00";

        // Handle image upload
        Part filePart = request.getPart("event_image");
        String filename = filePart.getSubmittedFileName();

        String uploadPath = request.getServletContext().getRealPath("/event_images/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        filePart.write(uploadPath + File.separator + filename);

        // Create Event object
        Event event = new Event();
        event.setTitle(title);
        event.setDescription(desc);
        event.setLocation(location);
        event.setStartDate(startDateTime);
        event.setEndDate(endDateTime);
        event.setCapacity(capacity);
        event.setImageFile(filename);

        // Insert into DB
        EventDAO.addEvent(event);

        // Redirect
        response.sendRedirect("admin/events_admin.jsp?success=1");
    }
}
