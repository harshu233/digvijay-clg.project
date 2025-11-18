<%@page contentType="text/html;charset=UTF-8" import="com.eventmgmt.dao.EventDAO,com.eventmgmt.dao.RegistrationDAO,com.eventmgmt.model.Event"%>
<%@ page import="com.eventmgmt.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Event e = EventDAO.getById(id);
    RegistrationDAO rdao = new RegistrationDAO();
    int regCount = rdao.getCountForEvent(id);
    User u = (User) session.getAttribute("user");

    boolean isRegistered = false;
    if (u != null) {
        isRegistered = rdao.isUserRegistered(u.getId(), id);
    }

    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy • hh:mm a");
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title><%= e != null ? e.getTitle() : "Event not found" %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background:#f9fafb; display:flex; justify-content:center; padding:40px; }
    .event-card { background:#fff; border-radius:12px; box-shadow:0 8px 25px rgba(0,0,0,0.08); padding:35px; max-width:700px; width:100%; }
    .btn-register { background:linear-gradient(90deg,#0f766e,#14b8a6); border:none; color:#fff; padding:10px; width:100%; border-radius:8px; font-weight:600; }
  </style>
</head>

<body>
  <div class="event-card">

    <% if (e == null) { %>
      <h3 class="text-danger text-center">Event not found</h3>
    <% } else { 

        String formattedStart = outputFormat.format(inputFormat.parse(e.getStartDate()));
        String formattedEnd = outputFormat.format(inputFormat.parse(e.getEndDate()));
    %>

      <h2 class="text-success fw-bold text-center mb-3" style="letter-spacing:0.5px;">
    <%= e.getTitle() %>
</h2>



      <!-- Corrected Image Path -->
      <img src="<%= request.getContextPath() %>/event_images/<%= e.getImageFile() %>"
           class="img-fluid rounded mb-3"
           alt="Event Image"
           style="max-height:300px; object-fit:cover; width:100%;">

      <p><%= e.getDescription() %></p>
      <p><strong>📍 Location:</strong> <%= e.getLocation() %></p>
      <p><strong>🕓 Duration:</strong> <%= formattedStart %> → <%= formattedEnd %></p>
      <p><strong>👥 Capacity:</strong> <%= e.getCapacity() %> &nbsp; | &nbsp; <strong>Registered:</strong> <%= regCount %></p>

      <% if (u == null) { %>

        <button class="btn-register" type="button" onclick="location.href='login.jsp'">Login to Register</button>

      <% } else if (isRegistered) { %>

        <form method="post" action="UnregisterEventServlet" class="mt-3">
            <input type="hidden" name="eventId" value="<%= e.getId() %>">
            <button class="btn btn-danger w-100 fw-bold">Unregister</button>
        </form>

      <% } else { %>

        <form method="post" action="RegisterEventServlet" class="mt-3">
            <input type="hidden" name="eventId" value="<%= e.getId() %>">
            <button class="btn-register">Register</button>
        </form>

      <% } %>

      <p class="mt-3 text-center"><a href="events.jsp" class="text-success fw-bold">← Back to Events</a></p>

    <% } %>
  </div>
</body>
</html>
