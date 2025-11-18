<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.eventmgmt.model.User" %>
<%
    User u = (User) session.getAttribute("user");
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>The Event Hub Pune</title>

  <!-- Google Fonts + Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root {
      --accent: #0f766e;
      --bg: #f9fafb;
      --muted: #9ca3af;
      font-family: "Inter", sans-serif;
    }

    body {
      background: var(--bg);
      color: #0f172a;
      margin: 0;
      line-height: 1.45;
    }

    /* Transparent Black Navbar */
    header {
      background: rgba(0, 0, 0, 0.6);
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1000;
      padding: 10px 20px;
      backdrop-filter: blur(6px);
      transition: all 0.3s ease;
    }

    .container {
      max-width: 1150px;
      margin: 0 auto;
    }

    .topbar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      font-weight: 700;
      color: white;
    }

    .brand img {
      height: 44px;
      width: 44px;
      border-radius: 6px;
      object-fit: cover;
    }

    /* Navbar Styling */
    nav ul {
      list-style: none;
      margin: 0;
      padding: 0;
      display: flex;
      gap: 18px;
      align-items: center;
      transition: all 0.4s ease;
    }

    nav a,
    .btn-nav,
    .dropdown-toggle {
      color: #fff;
      text-decoration: none;
      font-weight: 600;
      padding: 8px 16px;
      border-radius: 8px;
      position: relative;
      overflow: hidden;
      transition: all 0.3s ease;
      background: transparent;
    }
    
    nav a.nav-link {
      color: #fff !important;
    }

    /* Hover Gradient Animation */
    nav a::before,
    .btn-nav::before,
    .dropdown-toggle::before {
      content: "";
      position: absolute;
      left: 0;
      top: 0;
      width: 0%;
      height: 100%;
      background: linear-gradient(90deg, var(--accent), #14b8a6);
      z-index: -1;
      transition: width 0.3s ease;
      border-radius: 8px;
    }

    nav a:hover::before,
    .btn-nav:hover::before,
    .dropdown-toggle:hover::before {
      width: 100%;
    }

    nav a:hover,
    .btn-nav:hover,
    .dropdown-toggle:hover {
      color: #fff;
      transform: translateY(-2px);
    }

    /* Dropdown Menu */
    .dropdown-menu {
      border: none;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      animation: slideDown 0.25s ease;
    }

    @keyframes slideDown {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .dropdown-item:hover {
      background-color: rgba(15, 118, 110, 0.1);
      color: var(--accent) !important;
    }

    /* Toggle Button */
    .nav-toggle {
      display: none;
      background: var(--accent);
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      font-size: 20px;
      transition: all 0.3s ease;
    }

    .nav-toggle:hover {
      background: #14b8a6;
    }

    @media (max-width: 768px) {
      nav ul {
        flex-direction: column;
        background: rgba(0, 0, 0, 0.85);
        position: absolute;
        right: 18px;
        top: 70px;
        width: 220px;
        border-radius: 10px;
        padding: 15px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        opacity: 0;
        pointer-events: none;
        transform: translateY(-20px);
      }

      nav ul.show {
        opacity: 1;
        pointer-events: auto;
        transform: translateY(0);
        animation: slideIn 0.4s ease forwards;
      }

      @keyframes slideIn {
        from { opacity: 0; transform: translateY(-15px); }
        to { opacity: 1; transform: translateY(0); }
      }

      .nav-toggle {
        display: block;
      }
    }

    /* Hero Section Fullscreen */
    .hero {
      position: relative;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      overflow: hidden;
      margin-top: 0;
    }

    .hero .carousel {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -2;
    }

    .hero .carousel-item img {
      object-fit: cover;
      height: 100%;
      width: 100%;
      transform: scale(1);
      transition: transform 8s ease-in-out;
    }

    .hero .carousel-item.active img {
      transform: scale(1.1);
    }

    .hero-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.55);
      z-index: -1;
    }

    /* Card Hover Animation */
    .card {
      border: none;
      border-radius: 12px;
      overflow: hidden;
      transition: transform 0.4s ease, box-shadow 0.4s ease;
    }

    .card:hover {
      transform: translateY(-8px) scale(1.02);
      box-shadow: 0 12px 25px rgba(0,0,0,0.15);
    }

    .card img {
      transition: transform 0.6s ease;
    }

    .card:hover img {
      transform: scale(1.08);
    }

    footer {
      background: #0f172a;
      color: #eee;
      padding: 1rem 0;
      text-align: center;
    }

    html { scroll-behavior: smooth; }
    section { scroll-margin-top: 90px; }
    
    #contact {
      background: url('https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170') center/cover no-repeat;
      color: #fff;
      padding: 60px 20px;
      border-radius: 10px;
    }

    @media (max-width: 576px) {
      .hero h1 {
        font-size: 1.8rem;
      }
      .hero p {
        font-size: 1rem;
      }
      .card-body h5 {
        font-size: 1.1rem;
      }
    }
    
    #contact .btn-primary {
  display: inline-block;
  margin: 0 auto;
  padding: 10px 28px;
  font-weight: 600;
  border-radius: 8px;
  border: none;
  transition: all 0.3s ease;
}

#contact .btn-primary:hover {
  transform: translateY(-2px);
}

/* POP + FADE Animation */
.hero-content * {
  opacity: 0;
  animation: popFade 0.9s ease-out forwards;
}

/* Stagger timing for smooth reveal */
.hero-content h5 { animation-delay: 0.1s; }
.hero-content h1 { animation-delay: 0.35s; }
.hero-content p  { animation-delay: 0.6s; }
.hero-content .btn { animation-delay: 0.9s; }

@keyframes popFade {
  0% {
    opacity: 0;
    transform: scale(0.85);
  }
  60% {
    opacity: 1;
    transform: scale(1.03);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}

.card-body h5 {
  font-size: 1.50rem;   /* smaller title */
  font-weight: 600;
  margin-bottom: 6px;
}

.card-body p {
  font-size: 0.95rem;   /* smaller description */
  color: #555;
  line-height: 1.35;
  margin: 0;
}

    
  </style>
</head>

<body>
  <!-- Transparent Navbar -->
  <header>
    <div class="container topbar">
      <div class="brand">
        <img src="images/logo.png" alt="Event Hub Logo">
        <div>
          <div style="font-size:14px;color:var(--muted)">Pune's Trusted Event Company</div>
          <div style="font-size:18px;font-weight:800">The Event Hub Pune</div>
        </div>
      </div>

      <nav class="navbar navbar-expand-lg">
        <ul class="navbar-nav ms-auto">
          <li><a class="nav-link" href="events.jsp">Events</a></li>
          <li><a class="nav-link" href="#services">Our Services</a></li>
          <li><a class="nav-link" href="#contact">Contact Us</a></li>

          <% if (u == null) { %>
            <li class="dropdown">
              <a class="dropdown-toggle" href="#" id="loginDropdown" data-bs-toggle="dropdown">Login</a>
              <ul class="dropdown-menu" aria-labelledby="loginDropdown">
                <li><a class="dropdown-item" href="login.jsp">User</a></li>
                <li><a class="dropdown-item" href="login.jsp">Admin</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" href="#" id="registerDropdown" data-bs-toggle="dropdown">Register</a>
              <ul class="dropdown-menu" aria-labelledby="registerDropdown">
                <li><a class="dropdown-item" href="register.jsp">User</a></li>
                <li><a class="dropdown-item" href="register.jsp">Admin</a></li>
              </ul>
            </li>
          <% } else { %>
            <% if (u.isAdmin()) { %>
              <li><a class="nav-link" href="admin/admin_dashboard.jsp">Admin</a></li>
            <% } %>
            <li><a class="nav-link" href="LogoutServlet">Logout</a></li>
          <% } %>
        </ul>
      </nav>

      <button class="nav-toggle" onclick="toggleNav()">☰</button>
    </div>
  </header>

  <!-- Fullscreen Hero Section -->
  <section class="hero">
    <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="6000">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="https://plus.unsplash.com/premium_photo-1674235766088-80d8410f9523?auto=format&fit=crop&q=80&w=2069" class="d-block w-100" alt="Wedding Event">
        </div>
        <div class="carousel-item">
          <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&q=80&w=2070" class="d-block w-100" alt="Corporate Event">
        </div>
        <div class="carousel-item">
          <img src="https://images.unsplash.com/photo-1604668915840-580c30026e5f?auto=format&fit=crop&q=80&w=1348" class="d-block w-100" alt="Birthday Party">
        </div>
      </div>
    </div>
    <div class="hero-overlay"></div>
    <div class="container text-center px-3 hero-content">
      <h5 class="text-light">Pune's #1 Exclusive Event Company</h5>
      <h1 class="display-4 fw-bold">
        Partner with <span style="color:#22c55e;">The Event Hub Pune</span>
        to plan unforgettable events
      </h1>
      <p class="lead text-light">
        Premium destination weddings, corporate events, and private celebrations — 
        crafted with Maharashtra’s rich tradition and modern touches.
        We manage venues, décor, vendors and logistics so you can enjoy every moment.
      </p>
      <a href="events.jsp" class="btn btn-success btn-lg mt-3">Explore Upcoming Events</a>
    </div>
  </section>

  <!-- Our Services -->
  <section class="container my-5" id="services">
    <h2 class="fw-bold mb-4">Our Services</h2>
    <div class="row g-4">
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80" class="card-img-top" alt="Wedding">
          <div class="card-body">
            <h5>Wedding Planning</h5>
            <p>Make your special day unforgettable with thoughtful décor, personalized themes, venue styling, and complete event coordination led by our expert planning team.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&q=80&w=2069" class="card-img-top" alt="Corporate Event">
          <div class="card-body">
            <h5>Corporate Events</h5>
            <p>From conferences to award nights, we design and manage professional events that reflect your brand identity and deliver a seamless experience for your guests.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://images.unsplash.com/photo-1562967005-a3c85514d3e9?auto=format&fit=crop&q=80&w=1170" class="card-img-top" alt="Birthday">
          <div class="card-body">
            <h5>Birthday Parties</h5>
            <p>From kids’ cartoon themes to elegant milestone celebrations, we create fun, colorful and beautifully decorated birthday parties tailored to every age and style.</p>
          </div>
        </div>
      </div>
    </div>
  </section>
  

  <!-- Latest Blogs -->
  <section class="container my-5" id="blogs">
    <div class="row g-4">
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://images.unsplash.com/photo-1760669345407-fb66be533f6a?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2070" class="card-img-top" alt="Blog 1">
          <div class="card-body">
            <h5>Engagement & Pre-Wedding</h5>
            <p>Celebrate every moment leading up to the big day with beautifully themed Haldi, Mehendi, Sangeet, and Engagement events curated with décor, music, and seamless coordination.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://plus.unsplash.com/premium_photo-1683127810190-054b7e9eeba5?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170" class="card-img-top" alt="Blog 2">
          <div class="card-body">
            <h5>Live Entertainment</h5>
            <p>Book DJs, singers, dancers, anchors, live bands, celebrity performers, and entertainers to bring vibrance, energy, and unforgettable excitement to your event.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4 col-sm-6">
        <div class="card shadow-sm">
          <img src="https://plus.unsplash.com/premium_photo-1726873405579-e5affcbd91a6?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1153" class="card-img-top" alt="Blog 3">
          <div class="card-body">
            <h5>Baby Shower & Naming </h5>
            <p>Warm and joyful celebrations with soft décor, floral arrangements, balloon styling, and thoughtful details designed to create memories for your family.</p>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Testimonials Section -->
<section class="container my-5">
  <h2 class="fw-bold mb-1">What Our Clients Say</h2>
  <p>
  
   </p>
  <div class="row g-4">

    <!-- Wedding Testimonial -->
    <div class="col-md-6">
      <div class="card border-0 shadow-sm p-4" style="border-radius: 12px;">
        <div class="mb-2" style="color: #FFD700; font-size: 1.2rem;">
          ★★★★★
        </div>
        <p style="font-style: italic; font-size: 1.05rem;">
          "The Event Hub Pune turned our wedding into a fairy tale. Beautiful décor, smooth coordination,
          and zero stress. Truly memorable!"
        </p>
        <strong style="color: #444;">- Gauri & Raj </strong>
      </div>
    </div>

    <!-- Birthday Testimonial -->
    <div class="col-md-6">
      <div class="card border-0 shadow-sm p-4" style="border-radius: 12px;">
        <div class="mb-2" style="color: #FFD700; font-size: 1.2rem;">
          ★★★★★
        </div>
        <p style="font-style: italic; font-size: 1.05rem;">
          "They planned my son's birthday exactly how we imagined. Fun theme, lovely decorations and very friendly team!"
        </p>
        <strong style="color: #444;">- Deshmukh Family</strong>
      </div>
    </div>

  </div>
</section>


  <!-- Contact Section -->
<section class="container my-5" id="contact">
  <h2 class="fw-bold mb-4">Contact Us</h2>
  <p>Need help planning your next event? Get in touch with The Event Hub Pune share your requirements, and we’ll make it unforgettable</p>

  <% 
    String contactStatus = (String) request.getAttribute("contactStatus");
    if ("success".equals(contactStatus)) { 
  %>
    <div class="alert alert-success">✅ Your message has been sent successfully!</div>
  <% } else if ("error".equals(contactStatus)) { %>
    <div class="alert alert-danger">❌ Something went wrong. Please try again later.</div>
  <% } %>

  <form class="row g-3" action="ContactServlet" method="post">
    <div class="col-md-12">
      <input type="text" name="name" class="form-control" placeholder="Enter Your Name" required>
    </div>
    <div class="col-md-6">
      <input type="email" name="email" class="form-control" placeholder="Enter Your Email ID" required>
    </div>
    <div class="col-md-6">
      <input type="text" name="phone" class="form-control" placeholder="Enter Your Phone Number" required>
    </div>
    <div class="col-12">
      <textarea name="message" class="form-control" rows="4" placeholder="Message" required></textarea>
    </div>
    <div class="col-12 text-center">
      <button type="submit" class="btn btn-primary">SUBMIT</button>
    </div>
  </form>
</section>
<script>
  // Smoothly scroll to #contact if there's a contact status alert
  window.addEventListener("load", function() {
    const alertBox = document.querySelector(".alert");
    if (alertBox) {
      document.getElementById("contact").scrollIntoView({ behavior: "smooth" });
      setTimeout(() => alertBox.style.display = "none", 4000);
    }
  });
</script>

  <footer>
    &copy; <%= java.time.Year.now() %> The Event Hub Pune — All Rights Reserved
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function toggleNav() {
      const navList = document.querySelector('nav ul');
      navList.classList.toggle('show');
    }
  </script>
</body>
</html>
