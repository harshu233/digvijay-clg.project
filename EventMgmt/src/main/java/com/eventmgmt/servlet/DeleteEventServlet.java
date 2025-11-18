package com.eventmgmt.servlet;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.Event;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        EventDAO dao = new EventDAO();
        Event e = dao.getById(id);

        // Delete image if exists
        if (e.getImageFile() != null && !e.getImageFile().isEmpty()) {
            String imagePath = request.getServletContext().getRealPath("/event_images/") 
                                + File.separator + e.getImageFile();
            File img = new File(imagePath);
            if (img.exists()) img.delete();
        }

        // Delete DB record
        dao.deleteEvent(id);

        response.sendRedirect("admin/events_admin.jsp?deleted=1");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST same as GET
        doGet(request, response);
    }
}
