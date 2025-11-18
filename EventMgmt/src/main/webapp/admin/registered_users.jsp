<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.eventmgmt.dao.DBConnection, com.eventmgmt.dao.EventDAO, com.eventmgmt.model.Event" %>

<%
String eventIdParam = request.getParameter("id");
if (eventIdParam == null) {
    response.sendRedirect("events_admin.jsp");
    return;
}
int eventId = Integer.parseInt(eventIdParam);

Event event = EventDAO.getById(eventId);

Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT r.id AS reg_id, u.name, u.email, e.title, r.registered_at AS reg_date " +
    "FROM registrations r " +
    "JOIN users u ON r.user_id = u.id " +
    "JOIN events e ON r.event_id = e.id " +
    "WHERE r.event_id = ?"
);
ps.setInt(1, eventId);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Registered Users | Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        :root {
            --teal: #00796b;
            --teal2: #05998a;
            --table-header: #0f766e;
        }

        body { 
            background:#f9fafb; 
            font-family:"Inter",sans-serif; 
            padding:40px; 
        }

        /* Card-like content container */
        .content-box {
            background:#fff;
            border-radius:14px;
            padding:30px;
            max-width:1100px;
            margin:auto;
            box-shadow:0 10px 30px rgba(0,0,0,0.08);
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity:0; transform:translateY(10px); }
            to { opacity:1; transform:translateY(0); }
        }

        h2 { 
            color:var(--teal); 
            font-weight:700; 
            text-align:center; 
            margin-bottom:25px; 
        }

        table { 
            background:#fff; 
            border-radius:10px; 
            overflow:hidden;
        }

 th {
    background:#e9ecef;   /* Light Bootstrap Gray */
    color:#000;
    font-weight:600;
}
     

        /* Row Hover */
        tbody tr:hover {
            background:#eafaf8;
            transition:0.3s;
        }

        /* Back Button */
        .btn-back { 
            display:block; 
            width:fit-content; 
            margin:35px auto 0 auto; 
            padding:10px 30px;
            border-radius:8px;
            background:linear-gradient(90deg,var(--teal),var(--teal2));
            color:#fff !important;
            font-weight:600;
            text-decoration:none;
            transition:0.3s;
        }

        .btn-back:hover { 
            opacity:0.9; 
            transform:scale(1.05); 
        }
    </style>
</head>

<body>

<div class="content-box">

<h2><i class="fa-solid fa-users me-2"></i>Registered Users of <%= event.getTitle() %></h2>

<div class="table-responsive mt-4">
<table class="table table-hover text-center align-middle">
    <thead>
        <tr>
            <th>Reg. ID</th>
            <th>User Name</th>
            <th>Email</th>
            <th>Registered Event</th>
            <th>Registration Date</th>
        </tr>
    </thead>

    <tbody>
<%
boolean hasData = false;
while (rs.next()) {
    hasData = true;
%>
<tr>
    <td><%= rs.getInt("reg_id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getString("reg_date") %></td>
</tr>
<%
}
if (!hasData) {
%>
<tr><td colspan="5" class="text-muted">No users have registered for this event.</td></tr>
<%
}
%>
    </tbody>
</table>
</div>

<a href="events_admin.jsp" class="btn-back"><i class="fa-solid fa-arrow-left me-1"></i> Back to Manage Events</a>

</div>

</body>
</html>
