<%@page contentType="text/html;charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Login | The Event Hub Pune</title>
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
      font-family: "Inter", sans-serif;
    }

    body {
      background: #f9fafb;
      color: #0f172a;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      font-family: "Inter", sans-serif;
    }

    .login-box {
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.08);
      padding: 40px;
      width: 100%;
      max-width: 420px;
    }

    .login-box h2 {
      text-align: center;
      font-weight: 700;
      margin-bottom: 25px;
      color: var(--accent);
    }

    label {
      font-weight: 600;
      color: var(--muted);
    }

    .form-control {
      border-radius: 8px;
      border: 1px solid #d1d5db;
      padding: 10px;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--accent2);
      box-shadow: 0 0 0 3px rgba(20,184,166,0.25);
    }

    /* Animated Gradient Button */
    .btn-login {
      background: linear-gradient(90deg, var(--accent), var(--accent2));
      border: none;
      color: #fff;
      font-weight: 600;
      width: 100%;
      padding: 10px;
      border-radius: 8px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .btn-login::before {
      content: "";
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, var(--accent2), var(--accent));
      transition: left 0.4s ease;
      border-radius: 8px;
    }

    .btn-login:hover::before {
      left: 0;
    }

    .btn-login span {
      position: relative;
      z-index: 1;
    }

    .extra-links {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
    }

    .extra-links a {
      color: var(--accent);
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .extra-links a:hover {
      color: var(--accent2);
    }
  </style>
</head>

<body>
  <div class="login-box">
    <h2><i class="fa-solid fa-right-to-bracket me-2"></i>Login</h2>

    <form method="post" action="LoginServlet">
      <div class="mb-3">
        <label>Email</label>
        <input class="form-control" name="email" type="email" placeholder="Enter your email" required>
      </div>

      <div class="mb-3">
        <label>Password</label>
        <input class="form-control" name="password" type="password" placeholder="Enter your password" required>
      </div>

      <button class="btn-login mt-3"><span>Login</span></button>

      <div class="extra-links">
        <p class="mt-3 mb-1">Don’t have an account? <a href="register.jsp">Register</a></p>
        <p><a href="index.jsp">← Back to Home</a></p>
      </div>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
