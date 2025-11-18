<%@ page import="com.eventmgmt.model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || !u.isAdmin()) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    
    
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Admin Dashboard | The Event Hub Pune</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Google Fonts + Bootstrap + Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    :root {
      --accent: #0f766e;
      --accent2: #14b8a6;
      --muted: #64748b;
    }

    body {
      background: #f9fafb;
      font-family: "Inter", sans-serif;
      padding: 40px;
    }

    h2 {
      color: var(--accent);
      font-weight: 700;
      text-align: center;
      margin-bottom: 10px;
    }

    .admin-info {
      text-align: center;
      font-size: 15px;
      color: var(--muted);
      margin-bottom: 35px;
    }

    .dash-grid {
  display: flex;
  flex-direction: column;
  gap: 20px;
  max-width: 300px; /* make smaller width */
  margin: 0 auto; /* center */
}


    .dash-card {
      background: #fff;
      padding: 25px;
      border-radius: 15px;
      text-align: center;
      box-shadow: 0 8px 18px rgba(0,0,0,0.08);
      cursor: pointer;
      transition: transform .25s ease, box-shadow .25s ease;
      border: 1px solid #e5e7eb;
    }

    .dash-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 24px rgba(0,0,0,0.12);
    }

    .dash-icon {
      font-size: 35px;
      background: linear-gradient(90deg, var(--accent), var(--accent2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 12px;
    }

    .dash-card-title {
      font-size: 18px;
      font-weight: 600;
      color: var(--accent);
    }

    /* NEW Bottom Button */
    .btn-home {
      display: block;
      margin: 40px auto 0 auto;
      background: linear-gradient(90deg, var(--accent), var(--accent2));
      color: #fff;
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      font-weight: 600;
      transition: .3s;
      text-decoration: none;
      width: fit-content;
    }
    .btn-home:hover {
      transform: scale(1.04);
      opacity: .9;
      color: #fff;
    }

  </style>
</head>

<body>

  <h2><i class="fa-solid fa-user-shield me-2"></i>Admin Dashboard</h2>

  <div class="admin-info">
    Welcome, <strong><%= u.getName() %></strong>
  </div>

  <div class="dash-grid">

    <div class="dash-card" onclick="location.href='events_admin.jsp'">
      <i class="fa-solid fa-calendar-days dash-icon"></i>
      <div class="dash-card-title">Manage Events</div>
    </div>

    <div class="dash-card" onclick="location.href='view_contacts.jsp'">
      <i class="fa-solid fa-envelope-open-text dash-icon"></i>
      <div class="dash-card-title">View Contact Messages</div>
    </div>

    <div class="dash-card" onclick="location.href='../LogoutServlet'">
      <i class="fa-solid fa-right-from-bracket dash-icon"></i>
      <div class="dash-card-title">Logout</div>
    </div>

  </div>

  <!-- ✅ Centered Bottom "Back to Home Page" Button -->
  <a href="../index.jsp" class="btn-home">
    <i class="fa-solid fa-house me-2"></i>Back to Home Page
  </a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
