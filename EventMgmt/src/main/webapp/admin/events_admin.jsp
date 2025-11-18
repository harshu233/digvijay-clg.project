<%@page import="com.eventmgmt.dao.EventDAO,com.eventmgmt.model.Event,java.util.List"%>
<%@ page import="com.eventmgmt.model.User" %>

<%
    User u = (User) session.getAttribute("user");
    if (u==null || !u.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Event> events = EventDAO.getAllEvents();
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Manage Events | Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    :root {
      --blue1: #007bff;
      --blue2: #00bcd4;
      --green1: #28a745;
      --green2: #20c997;
      --red1: #ef4444;
      --red2: #dc2626;
      --teal: #00796b;
    }

    body {
      background: #f9fafb;
      font-family: "Inter", sans-serif;
      padding: 40px 20px;
    }

    .event-container {
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.08);
      padding: 35px;
      max-width: 1200px;
      margin: 0 auto;
      animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    h2 {
      color: var(--teal);
      font-weight: 700;
      margin-bottom: 25px;
      text-align: center;
    }

    .btn-add {
      background: linear-gradient(90deg, var(--blue1), var(--blue2));
      border: none;
      color: #fff !important;
      font-weight: 600;
      border-radius: 8px;
      padding: 10px 18px;
      transition: 0.3s;
    }
    .btn-add:hover { opacity: 0.9; transform: scale(1.05); }

    .table thead {
      background: var(--green1);
      color: #fff;
    }

    .event-img { width: 80px; height: 60px; object-fit: cover; border-radius: 6px; }

    .btn-edit {
      background: linear-gradient(90deg, var(--green1), var(--green2));
      border: none;
      color: #fff; font-weight: 500;
      border-radius: 6px; padding: 6px 12px;
      transition: 0.3s;
    }
    .btn-edit:hover { opacity: 0.9; transform: scale(1.05); }

    .btn-delete {
      background: linear-gradient(90deg, var(--red1), var(--red2));
      border: none;
      color: #fff; font-weight: 500;
      border-radius: 6px; padding: 6px 12px;
      transition: 0.3s;
    }
    .btn-delete:hover { opacity: 0.9; transform: scale(1.05); }

    .back-link { margin-top: 25px; text-align: center; }
    .back-link a {
      color: var(--teal);
      text-decoration: none;
      font-weight: 600;
      transition: 0.3s;
    }
    .back-link a:hover { color: #009688; }
  </style>
</head>

<body>
<div class="event-container">

  <h2><i class="fa-solid fa-calendar-days me-2"></i>Manage Events</h2>

  <div class="text-end mb-3">
    <a href="add_event.jsp" class="btn btn-add"><i class="fa-solid fa-plus me-1"></i> Add Event</a>
  </div>

  <table class="table table-bordered align-middle text-center">
    <thead>
      <tr>
        <th>Image</th>
        <th>Title</th>
        <th>Location</th>
        <th>Start</th>
        <th>End</th>
        <th>Capacity</th>
        <th>Actions</th>
      </tr>
    </thead>

    <tbody>
      <% for(Event e : events){ %>
      <tr>
        <td><img src="../event_images/<%= e.getImageFile() %>" class="event-img"/></td>
        <td><%= e.getTitle() %></td>
        <td><%= e.getLocation() %></td>
        <td><%= e.getStartDate() %></td>
        <td><%= e.getEndDate() %></td>
        <td><%= e.getCapacity() %></td>

        <td class="d-flex justify-content-center gap-2">
        
        <a href="registered_users.jsp?id=<%= e.getId() %>" class="btn btn-info btn-sm">
  <i class="fa-solid fa-users"></i> View Registered Users
</a>
        
          <a href="edit_event.jsp?id=<%= e.getId() %>" class="btn btn-edit btn-sm">
            <i class="fa-solid fa-pen-to-square"></i> Edit
          </a>

          <form action="../DeleteEventServlet" method="post" class="m-0">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="<%= e.getId() %>">
            <button class="btn btn-delete btn-sm"
              onclick="return confirm('Delete this event?')">
              <i class="fa-solid fa-trash"></i> Delete
            </button>
          </form>
        </td>
      </tr>
      <% } %>
    </tbody>
  </table>

  <div class="back-link">
  <a href="admin_dashboard.jsp"><i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard</a>
</div>


</div>

</body>
</html>
