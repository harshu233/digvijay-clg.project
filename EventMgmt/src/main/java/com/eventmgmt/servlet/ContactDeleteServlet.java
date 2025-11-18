package com.eventmgmt.servlet;

import com.eventmgmt.dao.ContactDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ContactDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ContactDAO dao = new ContactDAO();
        dao.deleteMessage(id);

        response.sendRedirect("admin/view_contacts.jsp");
    }
}
