package com.eventmgmt.servlet;

import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.Event;
import com.eventmgmt.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AdminEventServlet extends HttpServlet {

    private SimpleDateFormat formFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    private SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User u = (User) s.getAttribute("user");
        if (!u.isAdmin()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");
        EventDAO dao = new EventDAO();

        try {
            if ("add".equals(action)) {

                Event e = new Event();
                e.setTitle(req.getParameter("title"));
                e.setDescription(req.getParameter("description"));
                e.setLocation(req.getParameter("location"));

                // Parse input date (Date object) from HTML form
                Date sd = formFormat.parse(req.getParameter("start_date"));
                Date ed = formFormat.parse(req.getParameter("end_date"));

                // Convert to string for Event.java
                e.setStartDate(dbFormat.format(sd));
                e.setEndDate(dbFormat.format(ed));

                e.setCapacity(Integer.parseInt(req.getParameter("capacity")));

                dao.addEvent(e);
                resp.sendRedirect("admin/events_admin.jsp?msg=added");

            } else if ("update".equals(action)) {

                Event e = new Event();
                e.setId(Integer.parseInt(req.getParameter("id")));
                e.setTitle(req.getParameter("title"));
                e.setDescription(req.getParameter("description"));
                e.setLocation(req.getParameter("location"));

                Date sd = formFormat.parse(req.getParameter("start_date"));
                Date ed = formFormat.parse(req.getParameter("end_date"));

                e.setStartDate(dbFormat.format(sd));
                e.setEndDate(dbFormat.format(ed));

                e.setCapacity(Integer.parseInt(req.getParameter("capacity")));

                dao.updateEvent(e);
                resp.sendRedirect("admin/events_admin.jsp?msg=updated");

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteEvent(id);
                resp.sendRedirect("admin/events_admin.jsp?msg=deleted");

            } else {
                resp.sendRedirect("admin/events_admin.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendRedirect("admin/events_admin.jsp?error=1");
        }
    }
}
