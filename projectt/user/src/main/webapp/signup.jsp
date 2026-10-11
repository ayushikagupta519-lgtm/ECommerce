<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Account &mdash; E-Shop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#ffffff; --surface:#faf9f7; --ink:#141414; --muted:#6b7280; --muted-2:#9ca3af;
    --border:#ececec; --peach:#fbd7ac; --peach-ink:#7a4a10; --blue:#afcfea; --blue-ink:#1a4971;
    --red:#f0a8a0; --red-ink:#7a241c;
    --radius:20px; --shadow:0 20px 50px rgba(20,20,20,.12);
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{
    font-family:'Inter', sans-serif; color:var(--ink); min-height:100vh;
    display:flex; align-items:center; justify-content:center; padding:24px;
    background:var(--surface); transition:background-color .3s ease;
  }
  body.admin-mode{ background:#fdeceb; }
  h1,h2,.display{ font-family:'Poppins',sans-serif; }

  .card{
    background:var(--bg); border-radius:var(--radius); box-shadow:var(--shadow);
    padding:38px 40px 32px; width:100%; max-width:450px; border:1px solid var(--border); transition:border-color .3s ease;
  }
  .card.admin-border{ border-color:var(--red); }

  a.logo-link{
    display:flex; align-items:center; justify-content:center; gap:9px; text-decoration:none;
    color:var(--ink); font-size:16px; font-weight:800; margin-bottom:20px;
  }
  a.logo-link .hex{
    width:24px;height:24px; background:var(--ink); clip-path:polygon(25% 5%,75% 5%,100% 50%,75% 95%,25% 95%,0% 50%);
    display:flex;align-items:center;justify-content:center;
  }
  a.logo-link .hex span{ width:9px;height:9px;border-radius:50%;background:#fff; }

  h2#form-title{ text-align:center; font-size:24px; font-weight:800; margin-bottom:5px; letter-spacing:-.5px; }
  .subtitle{ text-align:center; font-size:13px; color:var(--muted); margin-bottom:20px; transition:color .3s; }

  .role-selector{
    display:flex; gap:8px; margin-bottom:22px; justify-content:center; flex-wrap:wrap;
  }
  .role-btn{
    padding:9px 18px; border-radius:20px; border:1.5px solid var(--border); background:var(--surface);
    font-size:12.5px; font-weight:700; color:var(--ink); cursor:pointer; transition:all .15s; user-select:none;
  }
  .role-btn:hover{ background:#f0eeea; }
  .role-btn.active[data-role="USER"]{ background:var(--blue); border-color:var(--blue); color:var(--blue-ink); }
  .role-btn.active[data-role="ADMIN"]{ background:var(--red); border-color:var(--red); color:var(--red-ink); }

  .form-group{ margin-bottom:14px; }
  .secret-field-box{ display:none; margin-bottom:14px; }
  .secret-field-box.show{ display:block; }

  label{ display:block; margin-bottom:5px; color:var(--ink); font-size:12px; font-weight:700; }

  input[type="number"], input[type="text"], input[type="email"], input[type="password"]{
    width:100%; padding:10px 14px; border-radius:12px; border:1.5px solid var(--border);
    background:var(--surface); color:var(--ink); font-family:'Inter',sans-serif; font-size:13.5px; outline:none;
    transition:border-color .2s;
  }
  input:focus{ border-color:var(--ink); background:var(--bg); }
  .card.admin-border input:focus{ border-color:var(--red); }

  .btn-submit{
    width:100%; background:var(--ink); color:#fff; border:none; border-radius:26px;
    padding:13px; font-size:14.5px; font-weight:700; cursor:pointer; margin-top:6px; margin-bottom:16px;
    transition:opacity .15s, background-color .2s;
  }
  .btn-submit:hover{ opacity:.85; }
  .card.admin-border .btn-submit{ background:var(--red-ink); }

  .login-link{ text-align:center; font-size:13.5px; color:var(--muted); }
  .login-link a{ color:var(--ink); text-decoration:none; font-weight:700; }
  .login-link a:hover{ text-decoration:underline; }
</style>
</head>
<body>

<div class="card" id="container">
  <a href="index.jsp" class="logo-link"><span class="hex"><span></span></span>E-Shop</a>
  <h2 id="form-title">Create Account</h2>
  <div class="subtitle" id="form-subtitle">Join as a standard user</div>

  <div class="role-selector">
    <div class="role-btn active" data-role="USER">Standard User</div>
    <div class="role-btn" data-role="ADMIN">System Admin</div>
  </div>

  <form action="http://localhost:8081/user" method="post">

    <input type="hidden" id="roleInput" name="role" value="USER">

    <div class="form-group">
      <label for="id">Enter Id</label>
      <input type="number" id="id" name="id" required>
    </div>

    <div class="form-group">
      <label for="firstName">Enter First Name</label>
      <input type="text" id="firstName" name="firstName" required>
    </div>

    <div class="form-group">
      <label for="lastName">Enter Last Name</label>
      <input type="text" id="lastName" name="lastName" required>
    </div>

    <div class="form-group">
      <label for="email">Enter Email Address</label>
      <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group secret-field-box" id="secretBox">
      <label for="adminSecretKey" style="color: var(--red-ink);">Admin Verification Key</label>
      <input type="password" id="adminSecretKey" name="adminSecretKey" placeholder="Enter registration security token">
    </div>

    <div class="form-group">
      <label for="password">Enter Password</label>
      <input type="password" id="password" name="password" required>
    </div>

    <div class="form-group">
      <label for="confirmPassword">Confirm Password</label>
      <input type="password" id="confirmPassword" name="confirmPassword" required>
    </div>

    <input type="submit" id="submitBtn" class="btn-submit" value="Sign Up">

    <div class="login-link">
      Already registered? <a href="login.jsp">Login here</a>
    </div>

  </form>
</div>

<script>
    document.querySelectorAll('.role-btn').forEach(button => {
        button.addEventListener('click', function() {
            const role = this.getAttribute('data-role');

            const container = document.getElementById("container");
            const roleInput = document.getElementById("roleInput");
            const formTitle = document.getElementById("form-title");
            const formSubtitle = document.getElementById("form-subtitle");
            const submitBtn = document.getElementById("submitBtn");
            const secretBox = document.getElementById("secretBox");
            const secretInput = document.getElementById("adminSecretKey");

            document.querySelectorAll('.role-btn').forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            roleInput.value = role;

            if (role === 'ADMIN') {
                document.body.classList.add('admin-mode');
                container.classList.add('admin-border');
                formTitle.innerText = "Admin Registration";
                formSubtitle.innerText = "Authorized personnel only";
                formSubtitle.style.color = "var(--red-ink)";
                submitBtn.value = "Register System Admin";

                secretBox.classList.add('show');
                secretInput.required = true;
            } else {
                document.body.classList.remove('admin-mode');
                container.classList.remove('admin-border');
                formTitle.innerText = "Create Account";
                formSubtitle.innerText = "Join as a standard user";
                formSubtitle.style.color = "var(--muted)";
                submitBtn.value = "Sign Up";

                secretBox.classList.remove('show');
                secretInput.required = false;
                secretInput.value = "";
            }
        });
    });
</script>

</body>
</html>
