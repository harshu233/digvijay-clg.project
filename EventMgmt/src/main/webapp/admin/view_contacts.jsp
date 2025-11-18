<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.eventmgmt.dao.ContactDAO, com.eventmgmt.model.ContactMessage, java.util.List" %>
<%@ page import="com.eventmgmt.model.User" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !u.isAdmin()) { response.sendRedirect("../login.jsp"); return; }

    String search = request.getParameter("search");
    ContactDAO dao = new ContactDAO();
    List<ContactMessage> messages = dao.getAllMessages(search);
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Contact Messages | Admin Panel</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        :root {
            --accent-blue1: #007bff;
            --accent-blue2: #00bcd4;
            --accent-green1: #28a745;
            --accent-green2: #20c997;
            --teal: #00796b;
        }

        body {
            background: #f9fafb;
            font-family: "Inter", sans-serif;
            padding: 40px 20px;
        }

        .card-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            padding: 35px;
            max-width: 1150px;
            margin: 0 auto;
        }

        h2 {
            color: var(--teal);
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
        }

        .btn-reply {
            background: linear-gradient(90deg, var(--accent-blue1), var(--accent-blue2));
            border: none;
            color: #fff;
            font-weight: 500;
            border-radius: 6px;
            padding: 6px 12px;
            transition: 0.3s;
        }
        .btn-reply:hover {
            opacity: 0.9;
            transform: scale(1.03);
        }

        .btn-delete {
            background: linear-gradient(90deg, #ef4444, #dc2626);
            border: none;
            color: #fff;
            font-weight: 500;
            border-radius: 6px;
            padding: 6px 12px;
            transition: 0.3s;
        }
        .btn-delete:hover {
            opacity: 0.9;
            transform: scale(1.03);
        }

        .btn-search {
            background: linear-gradient(90deg, var(--accent-blue1), var(--accent-blue2));
            border: none;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
        }

        .table thead {
            background: var(--accent-green1);
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: #f1f5f9;
        }

        .back-link a {
            color: var(--teal);
            font-weight: 600;
            text-decoration: none;
        }
        .back-link a:hover {
            color: #009688;
        }
    </style>
</head>

<body>

<div class="card-container">

    <h2><i class="fa-solid fa-envelope-open-text me-2"></i>Contact Messages</h2>

    <form method="get" class="d-flex mb-4 justify-content-center">
        <input type="text" name="search" class="form-control form-control-lg w-50"
               placeholder="Search by name or email..."
               value="<%= search != null ? search : "" %>">
        <button class="btn btn-search ms-2"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered align-middle text-center">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th style="width:35%;">Message</th>
                    <th>Submitted</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
            <%
                int i = 1;
                for (ContactMessage c : messages) {
            %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getPhone() %></td>
                    <td class="text-start"><%= c.getMessage() %></td>
                    <td><%= c.getSubmittedAt() != null ? sdf.format(c.getSubmittedAt()) : "-" %></td>

                    <td class="d-flex justify-content-center gap-2">
                        <a href="mailto:<%= c.getEmail() %>?subject=Reply%20Regarding%20Your%20Query&body=Hello%20<%= c.getName() %>,%0D%0A%0D%0A"
                           class="btn btn-reply btn-sm">
                            <i class="fa-solid fa-paper-plane"></i> Reply
                        </a>

                        <a href="../ContactDeleteServlet?id=<%= c.getId() %>"
                           class="btn btn-delete btn-sm"
                           onclick="return confirm('Delete this message permanently?');">
                            <i class="fa-solid fa-trash"></i> Delete
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="back-link text-center mt-4">
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
