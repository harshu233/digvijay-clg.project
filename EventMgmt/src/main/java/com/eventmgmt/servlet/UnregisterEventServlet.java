package com.eventmgmt.servlet;

import com.eventmgmt.dao.RegistrationDAO;
import com.eventmgmt.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/UnregisterEventServlet")
public class UnregisterEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User u = (User) session.getAttribute("user");

        if (u == null) {
            // user not logged in
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = u.getId();
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        RegistrationDAO dao = new RegistrationDAO();
        dao.unregister(userId, eventId);

        response.sendRedirect("event_details.jsp?id=" + eventId);
    }
}
