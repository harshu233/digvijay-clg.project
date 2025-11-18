package com.eventmgmt.servlet;

import com.eventmgmt.dao.UserDAO;
import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.Event;
import com.eventmgmt.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.findByEmailAndPassword(email, password);

        if (user != null) {

            HttpSession s = req.getSession();
            s.setAttribute("user", user);

            // ✅ Only for Non-Admin Users: Check New Event Notification
            if (!user.isAdmin()) {

                Event latestEvent = EventDAO.getLatestEvent();
                
                if (latestEvent != null) {
                    // Show notification only if user hasn't seen this latest event
                    if (user.getLastEventSeen() == null || latestEvent.getCreatedAt().after(user.getLastEventSeen())) {
                        s.setAttribute("newEventNotification", latestEvent.getTitle());
                    }

                    // Update last seen timestamp
                    UserDAO.updateLastEventSeen(user.getId());
                }
            }

            // ✅ Keep login redirection EXACTLY as before
            if (user.isAdmin()) {
                resp.sendRedirect("admin/admin_dashboard.jsp");
            } else {
                resp.sendRedirect("events.jsp");
            }

        } else {
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}
