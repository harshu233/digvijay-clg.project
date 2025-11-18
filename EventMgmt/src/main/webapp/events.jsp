<%@page contentType="text/html;charset=UTF-8" import="com.eventmgmt.dao.EventDAO,com.eventmgmt.model.Event,java.util.List"%>
<%@ page import="com.eventmgmt.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<Event> events = EventDAO.getAllEvents();
    User u = (User) session.getAttribute("user");
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Upcoming Events | The Event Hub Pune</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    :root { --accent:#0f766e; --accent2:#14b8a6; font-family:"Inter",sans-serif; }
    body { background-color:#f9fafb; min-height:100vh; padding:40px 0; }

    .page-title { text-align:center; font-weight:700; color:var(--accent); margin-bottom:40px; }

    .event-card { border:none; border-radius:12px; overflow:hidden; box-shadow:0 4px 15px rgba(0,0,0,0.08); transition:0.3s; background:#fff; text-align:center; }
    .event-card:hover { transform:translateY(-6px); box-shadow:0 8px 25px rgba(0,0,0,0.12); }

    .event-img { height:200px; width:100%; object-fit:cover; }

    .btn-details {
  background:linear-gradient(90deg,var(--accent),var(--accent2));
  border:none;
  color:#fff;
  padding:8px 18px;
  border-radius:8px;
  font-weight:600;
  display:inline-block;
  margin:auto;
}
    
    .back-btn {
  display:inline-block;
  background:linear-gradient(90deg,var(--accent),var(--accent2));
  color:#fff !important;
  text-decoration:none;
  padding:10px 22px;
  border-radius:8px;
  font-weight:600;
  transition:0.3s;
}
.back-btn:hover {
  opacity:0.9;
  transform:translateY(-2px);
}
    
    .search-box {
  width: 100%;
  max-width: 450px;
}

.search-input {
  border-radius: 8px 0 0 8px;
  border: 1px solid #d1d5db;
  padding: 10px 14px;
  font-size: 15px;
}

.search-input:focus {
  border-color: var(--accent2);
  box-shadow: none;
}

.search-btn {
  background: linear-gradient(135deg, #0073FF, #00E3FF);
  border: none;
  color: #fff;
  width: 55px;
  border-radius: 0 8px 8px 0;
  cursor: pointer;
  transition: 0.3s;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
}

.search-btn:hover {
  opacity: 0.9;
  transform: translateY(-1px);
}

    

    .extra-links { text-align:center; margin-top:40px; }
    .extra-links a { color:var(--accent); font-weight:600; text-decoration:none; }
  </style>
</head>

<body>
  <div class="container">
    <h2 class="page-title"><i class="fa-solid fa-calendar-days me-2"></i>Upcoming Events</h2>
    
    <div class="d-flex justify-content-center mb-4">
  <div class="search-box d-flex">
    <input type="text" id="searchInput" class="form-control search-input"
           placeholder="Search events...">
    <button class="search-btn" type="button">
      <i class="fa-solid fa-magnifying-glass"></i>
    </button>
  </div>
</div>

<script>
  const searchInput = document.getElementById("searchInput");
  searchInput.addEventListener("keyup", function() {
    const filter = searchInput.value.toLowerCase();
    const cards = document.querySelectorAll(".event-card");

    cards.forEach(card => {
      const title = card.querySelector("h5").textContent.toLowerCase();
      card.parentElement.style.display = title.includes(filter) ? "" : "none";
    });
  });
</script>

 <%
String newEvent = (String) session.getAttribute("newEventNotification");
if (newEvent != null) {
%>
<div id="newEventToast" class="new-event-alert animate-popup">
    <span class="icon">🎉</span>
    <strong>New Event Added:</strong> <%= newEvent %>
</div>

<style>
.new-event-alert {
    background: linear-gradient(90deg, #3b82f6, #06b6d4);
    color: #fff;
    padding: 12px 20px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 600;

    /* ↓↓↓ Smaller width ↓↓↓ */
    width: fit-content;
    max-width: 420px;

    margin: 0 auto 20px auto; /* centered */
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;

    box-shadow: 0 4px 14px rgba(0,0,0,0.15);
    opacity: 1;
    transition: opacity 1s ease, transform 1s ease;
}


/* Pop-in animation */
.animate-popup {
    animation: fadeSlideIn 0.6s ease forwards;
}

@keyframes fadeSlideIn {
    0% { opacity: 0; transform: translateY(-10px) scale(0.98); }
    100% { opacity: 1; transform: translateY(0) scale(1); }
}

/* Bounce emoji */
.new-event-alert .icon {
    animation: bounce 1.2s infinite;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-4px); }
}

/* Fade out + slide up */
.fade-out {
    opacity: 0 !important;
    transform: translateY(-15px) scale(.97);
}
</style>

<script>
// Auto fade after 20 seconds (20000 ms)
setTimeout(() => {
    const toast = document.getElementById("newEventToast");
    if (toast) toast.classList.add("fade-out");
}, 20000);

// Optional: remove element from DOM after fade finishes
setTimeout(() => {
    const toast = document.getElementById("newEventToast");
    if (toast) toast.remove();
}, 22000);
</script>

<%
session.removeAttribute("newEventNotification");
}
%>



    <div class="row">
      <% if (events != null && !events.isEmpty()) { 
           for (Event e : events) {
      %>

      <div class="col-md-6 col-lg-4 mb-4">
        <div class="event-card">

          <!-- Event Image -->
          <img src="<%= request.getContextPath() %>/event_images/<%= e.getImageFile() %>" 
               alt="Event Image"
               class="event-img">

          <div class="p-3">

            <!-- Centered Title -->
            <h5 class="fw-bold mb-3"><%= e.getTitle() %></h5>

            <!-- Centered View Details Button -->
            <a class="btn-details" href="event_details.jsp?id=<%= e.getId() %>">View Details</a>

          </div>
        </div>
      </div>

      <% } } else { %>
        <div class="col-12 text-center text-muted">No upcoming events found.</div>
      <% } %>
    </div>
  </div>
  
  <div class="extra-links">
  <a href="index.jsp" class="back-btn">
    <i class="fa-solid fa-arrow-left me-1"></i> Back to Home
  </a>
</div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
