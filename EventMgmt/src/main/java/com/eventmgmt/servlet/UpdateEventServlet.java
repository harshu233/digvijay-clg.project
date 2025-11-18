package com.eventmgmt.servlet;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.Event;

@WebServlet("/UpdateEventServlet")
@MultipartConfig
public class UpdateEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Get form values
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("event_name");
        String desc = request.getParameter("event_desc");
        String location = request.getParameter("event_location");
        int capacity = Integer.parseInt(request.getParameter("event_capacity"));

        // Date-Time inputs from form (datetime-local)
        String startDT = request.getParameter("start_date_time"); // "Y-M-DTH:M"
        String endDT = request.getParameter("end_date_time");

        // Convert to "YYYY-MM-DD HH:mm:ss"
        String startDateTime = startDT.replace("T", " ") + ":00";
        String endDateTime = endDT.replace("T", " ") + ":00";

        // Get old image name (hidden input)
        String oldImage = request.getParameter("old_image");

        // Handle new image upload
        Part filePart = request.getPart("event_image");
        String newImage = filePart.getSubmittedFileName();

        String finalImage = oldImage; // default = keep old one

        if (newImage != null && !newImage.trim().isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/event_images/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + newImage);
            finalImage = newImage; // update to new image
        }

        // Build event object
        Event event = new Event();
        event.setId(id);
        event.setTitle(title);
        event.setDescription(desc);
        event.setLocation(location);
        event.setStartDate(startDateTime);
        event.setEndDate(endDateTime);
        event.setCapacity(capacity);
        event.setImageFile(finalImage);

        // Update DB
        EventDAO dao = new EventDAO();
        dao.updateEvent(event);

        // Redirect back
        response.sendRedirect("admin/events_admin.jsp?updated=1");
    }
}
