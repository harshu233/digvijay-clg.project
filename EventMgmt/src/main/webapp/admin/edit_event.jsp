<%@page import="com.eventmgmt.dao.EventDAO,com.eventmgmt.model.Event"%>
<%@ page import="com.eventmgmt.model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u==null || !u.isAdmin()) { 
        response.sendRedirect("../login.jsp"); 
        return; 
    }

    int id = Integer.parseInt(request.getParameter("id"));
    EventDAO dao = new EventDAO();
    Event e = dao.getById(id);

    String start = e.getStartDate() != null ? e.getStartDate().replace(" ", "T").substring(0,16) : "";
    String end = e.getEndDate() != null ? e.getEndDate().replace(" ", "T").substring(0,16) : "";
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Edit Event | Admin Panel</title>

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

    .form-container {
      max-width: 900px;
      margin: 0 auto;
      background: #fff;
      border-radius: 12px;
      padding: 35px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.08);
      animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    h2 {
      color: var(--teal);
      font-weight: 700;
      text-align: center;
      margin-bottom: 25px;
    }

    .btn-submit {
      background: linear-gradient(90deg, var(--green1), var(--green2));
      border: none;
      color: #fff;
      font-weight: 600;
      border-radius: 8px;
      padding: 10px;
      transition: 0.3s;
    }
    .btn-submit:hover { transform: scale(1.05); opacity: 0.9; }

    .current-img {
      width: 120px;
      height: 85px;
      object-fit: cover;
      border-radius: 8px;
      margin-top: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .back-link {
      text-align: center;
      margin-top: 20px;
    }
    .back-link a {
      text-decoration: none;
      font-weight: 600;
      color: var(--teal);
      transition: 0.3s;
    }
    .back-link a:hover { color: #009688; }

  </style>
</head>

<body>

<div class="form-container">
  <h2><i class="fa-solid fa-pen-to-square me-2"></i>Edit Event</h2>


  <form action="../UpdateEventServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= e.getId() %>">
    <input type="hidden" name="old_image" value="<%= e.getImageFile() %>">

    <label class="form-label">Title</label>
    <input name="event_name" class="form-control" value="<%= e.getTitle() %>" required>

    <label class="form-label mt-3">Description</label>
    <textarea name="event_desc" class="form-control" rows="3" required><%= e.getDescription() %></textarea>

    <label class="form-label mt-3">Location</label>
    <input name="event_location" class="form-control" value="<%= e.getLocation() %>" required>

    <label class="form-label mt-3">Start Date & Time</label>
    <input type="datetime-local" name="start_date_time" class="form-control" value="<%= start %>" required>

    <label class="form-label mt-3">End Date & Time</label>
    <input type="datetime-local" name="end_date_time" class="form-control" value="<%= end %>" required>

    <label class="form-label mt-3">Capacity</label>
    <input type="number" name="event_capacity" class="form-control" min="1" value="<%= e.getCapacity() %>" required>

    <label class="form-label mt-3">Change Image (optional)</label>
    <input type="file" name="event_image" class="form-control" accept="image/*">
    <div>
      <small class="text-muted">Current Image:</small><br>
      <img src="../event_images/<%= e.getImageFile() %>" class="current-img">
    </div>

    <button class="btn btn-submit w-100 mt-4">Update Event</button>
  </form>

   <div class="back-link">
    <a href="events_admin.jsp">Back to Manage Events</a>
  </div>
  
</div>

</body>
</html>
