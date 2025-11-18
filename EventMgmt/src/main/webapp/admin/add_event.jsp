<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.eventmgmt.model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || !u.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Add Event | Admin Panel</title>

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
      max-width: 850px;
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

    #imagePreview {
      width: 100%;
      max-height: 260px;
      object-fit: cover;
      margin-top: 12px;
      display: none;
      border-radius: 10px;
      box-shadow: 0 4px 14px rgba(0,0,0,0.15);
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
  <h2><i class="fa-solid fa-calendar-plus me-2"></i>Add Event</h2>


  <form action="../AddEventServlet" method="post" enctype="multipart/form-data">

    <div class="mb-3">
      <label class="form-label">Event Title</label>
      <input type="text" name="event_name" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Description</label>
      <textarea name="event_desc" class="form-control" rows="3" required></textarea>
    </div>

    <div class="mb-3">
      <label class="form-label">Location</label>
      <input type="text" name="event_location" class="form-control" required>
    </div>

    <div class="row">
      <div class="col-md-6 mb-3">
        <label class="form-label">Start Date</label>
        <input type="date" name="start_date" class="form-control" required>
      </div>
      <div class="col-md-6 mb-3">
        <label class="form-label">Start Time</label>
        <input type="time" name="start_time" class="form-control" required>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6 mb-3">
        <label class="form-label">End Date</label>
        <input type="date" name="end_date" class="form-control" required>
      </div>
      <div class="col-md-6 mb-3">
        <label class="form-label">End Time</label>
        <input type="time" name="end_time" class="form-control" required>
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label">Capacity</label>
      <input type="number" name="event_capacity" class="form-control" min="1" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Upload Event Image</label>
      <input type="file" name="event_image" class="form-control" accept="image/*" onchange="previewImage(event)" required>
      <img id="imagePreview"/>
    </div>

    <button type="submit" class="btn btn-submit w-100">Add Event</button>
  </form>

  <div class="back-link">
    <a href="events_admin.jsp">← Back to Events</a>
  </div>
</div>

<script>
function previewImage(event) {
  const img = document.getElementById('imagePreview');
  img.src = URL.createObjectURL(event.target.files[0]);
  img.style.display = 'block';
}
</script>

</body>
</html>
