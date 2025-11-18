package com.eventmgmt.servlet;

import com.eventmgmt.dao.ContactDAO;
import com.eventmgmt.model.ContactMessage;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        ContactMessage msg = new ContactMessage(name, email, phone, message);
        ContactDAO dao = new ContactDAO();

        boolean saved = dao.saveMessage(msg);

        if (saved) {
            request.setAttribute("contactStatus", "success");
        } else {
            request.setAttribute("contactStatus", "error");
        }

        // Stay on same section (scroll to #contact)
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp#contact");
        dispatcher.forward(request, response);
    }
}
