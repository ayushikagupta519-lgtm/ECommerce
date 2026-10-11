<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Log In &mdash; E-Shop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#ffffff; --surface:#faf9f7; --ink:#141414; --muted:#6b7280; --muted-2:#9ca3af;
    --border:#ececec; --peach:#fbd7ac; --peach-ink:#7a4a10;
    --radius:20px; --shadow:0 20px 50px rgba(20,20,20,.12);
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{
    font-family:'Inter', sans-serif; color:var(--ink); min-height:100vh;
    display:flex; align-items:center; justify-content:center; padding:24px;
    background:var(--surface);
  }
  h1,h2,.display{ font-family:'Poppins',sans-serif; }

  .card{
    background:var(--bg); border-radius:var(--radius); box-shadow:var(--shadow);
    padding:44px 40px 36px; width:100%; max-width:410px; border:1px solid var(--border);
  }

  a.logo-link{
    display:flex; align-items:center; justify-content:center; gap:9px; text-decoration:none;
    color:var(--ink); font-size:16px; font-weight:800; margin-bottom:26px;
  }
  a.logo-link .hex{
    width:24px;height:24px; background:var(--ink); clip-path:polygon(25% 5%,75% 5%,100% 50%,75% 95%,25% 95%,0% 50%);
    display:flex;align-items:center;justify-content:center;
  }
  a.logo-link .hex span{ width:9px;height:9px;border-radius:50%;background:#fff; }

  .eyebrow-badge{
    display:inline-block; background:var(--peach); color:var(--peach-ink); padding:6px 14px;
    border-radius:16px; font-size:11.5px; font-weight:700; margin-bottom:14px;
  }
  h2.title{ text-align:center; font-size:26px; font-weight:800; margin-bottom:6px; letter-spacing:-.5px; }
  .subtitle{ text-align:center; font-size:13.5px; color:var(--muted); margin-bottom:26px; }
  .center-wrap{ text-align:center; }

  .form-group{ margin-bottom:16px; }
  label{ display:block; margin-bottom:6px; color:var(--ink); font-size:12.5px; font-weight:700; }

  input[type="number"], input[type="password"]{
    width:100%; padding:12px 16px; border-radius:14px; border:1.5px solid var(--border);
    background:var(--surface); color:var(--ink); font-family:'Inter',sans-serif; font-size:14px; outline:none;
    transition:border-color .2s;
  }
  input::placeholder{ color:var(--muted-2); }
  input:focus{ border-color:var(--ink); background:var(--bg); }

  .btn-submit{
    width:100%; background:var(--ink); color:#fff; border:none; border-radius:26px;
    padding:13px; font-size:14.5px; font-weight:700; cursor:pointer; margin-top:8px; margin-bottom:18px;
    transition:opacity .15s;
  }
  .btn-submit:hover{ opacity:.85; }

  .signup-link{ text-align:center; font-size:13.5px; color:var(--muted); }
  .signup-link a{ color:var(--ink); text-decoration:none; font-weight:700; }
  .signup-link a:hover{ text-decoration:underline; }
</style>
</head>
<body>

<div class="card">
  <a href="index.jsp" class="logo-link"><span class="hex"><span></span></span>E-Shop</a>
  <div class="center-wrap"><span class="eyebrow-badge">Welcome back</span></div>
  <h2 class="title">Log in to your account</h2>
  <p class="subtitle">Enter your details to continue shopping</p>

  <form action="http://localhost:8081/login" method="POST">

    <div class="form-group">
      <label for="id">User ID</label>
      <input type="number" id="id" name="id" required placeholder="e.g., 101">
    </div>

    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required placeholder="Enter Password">
    </div>

    <input type="submit" class="btn-submit" value="Log In">

    <div class="signup-link">
      New here? <a href="signup.jsp">Create an account</a>
    </div>

  </form>
</div>

<script>
document.querySelector('form').addEventListener('submit', async (e) => {
    e.preventDefault();

    const formData = new URLSearchParams(new FormData(e.target));

    try {
        const response = await fetch('http://localhost:8081/login', {
            method: 'POST',
            body: formData
        });

        const message = await response.text();

        if (response.ok) {
            const parts = message.split(":");
            const roleMarker = parts[0];
            const firstName = parts[1] || "Valued Customer";

            sessionStorage.setItem("userName", firstName);
            sessionStorage.setItem("userId", document.getElementById("id").value);

            if (roleMarker.includes("ADMIN_PANEL")) {
                window.location.href = "admin.jsp";
            } else if (roleMarker.includes("USER_DASHBOARD")) {
                window.location.href = "user_profile.jsp";
            }
        } else {
            alert(message);
        }
    } catch (error) {
        console.error("Auth routing failure:", error);
        alert("Failed to communicate with authentication server. Check if Spring Boot is active.");
    }
});
</script>

</body>
</html>
