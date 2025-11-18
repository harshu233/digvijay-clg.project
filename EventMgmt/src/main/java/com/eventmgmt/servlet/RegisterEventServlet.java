package com.eventmgmt.servlet;

import com.eventmgmt.dao.RegistrationDAO;
import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp?next=events.jsp");
            return;
        }
        User user = (User) s.getAttribute("user");
        int eventId = Integer.parseInt(req.getParameter("eventId"));

        // check capacity
        EventDAO eventDAO = new EventDAO();
        com.eventmgmt.model.Event ev = eventDAO.getById(eventId);
        if (ev == null) {
            resp.sendRedirect("events.jsp?error=notfound");
            return;
        }
        RegistrationDAO regDAO = new RegistrationDAO();
        int current = regDAO.getCountForEvent(eventId);
        if (current >= ev.getCapacity()) {
            resp.sendRedirect("event_details.jsp?id=" + eventId + "&error=full");
            return;
        }
        boolean ok = regDAO.register(user.getId(), eventId);
        if (ok) resp.sendRedirect("event_details.jsp?id=" + eventId + "&registered=1");
        else resp.sendRedirect("event_details.jsp?id=" + eventId + "&error=1");
    }
}
