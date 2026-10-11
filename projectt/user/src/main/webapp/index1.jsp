<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>E-Shop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#ffffff; --surface:#faf9f7; --ink:#141414; --muted:#6b7280; --muted-2:#9ca3af;
    --border:#ececec; --peach:#fbd7ac; --peach-ink:#7a4a10; --blue:#afcfea; --blue-ink:#1a4971;
    --green:#a9d6b8; --green-ink:#205530; --red:#f0a8a0; --red-ink:#7a241c; --purple:#cdb8ef; --purple-ink:#4a2d7a;
    --radius:18px; --shadow:0 14px 34px rgba(20,20,20,.08); --shadow-sm:0 6px 16px rgba(20,20,20,.06);
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{ font-family:'Inter',sans-serif; color:var(--ink); background:var(--bg); min-height:100vh; display:flex; flex-direction:column; }
  a{ color:inherit; text-decoration:none; }
  h1,h2,h3,.display{ font-family:'Poppins',sans-serif; }

  /* ============ NAVBAR ============ */
  .navbar{ background:var(--bg); border-bottom:1px solid var(--border); position:sticky; top:0; z-index:200; }
  .nav-container{ max-width:1240px;margin:0 auto;padding:20px 32px; display:flex;justify-content:space-between;align-items:center;gap:20px; }
  .logo{ font-size:22px; font-weight:800; display:flex;align-items:center;gap:9px; white-space:nowrap; }
  .logo .hex{
    width:26px;height:26px; background:var(--ink); clip-path:polygon(25% 5%,75% 5%,100% 50%,75% 95%,25% 95%,0% 50%);
    display:flex;align-items:center;justify-content:center;
  }
  .logo .hex span{ width:10px;height:10px;border-radius:50%;background:#fff; }

  .nav-links{ display:flex; gap:30px; align-items:center; }
  .nav-links a{ font-size:14.5px; font-weight:500; color:var(--ink); position:relative; }
  .nav-links a.active{ color:var(--ink); font-weight:700; }

  .search-wrap{ position:relative; }
  .search-wrap input{
    width:220px; padding:10px 14px 10px 36px; border-radius:24px; border:1px solid var(--border);
    background:var(--surface); color:var(--ink); font-family:'Inter',sans-serif; font-size:13.5px; outline:none;
    transition:border-color .2s, width .2s;
  }
  .search-wrap input:focus{ border-color:var(--ink); width:260px; }
  .search-wrap svg{ position:absolute; left:13px; top:50%; transform:translateY(-50%); width:14px; height:14px; stroke:var(--muted-2); }

  .nav-actions{ display:flex; align-items:center; gap:16px; flex-shrink:0; }
  .cart-btn{
    position:relative; background:var(--surface); border:1px solid var(--border);
    width:40px;height:40px;border-radius:50%; display:flex; align-items:center; justify-content:center;
    cursor:pointer; transition:background .15s;
  }
  .cart-btn:hover{ background:#f0eeea; }
  .cart-btn svg{ width:17px;height:17px; stroke:var(--ink); }
  .cart-badge{
    position:absolute; top:-5px; right:-5px; background:var(--ink); color:#fff;
    font-size:10px; font-weight:700; min-width:18px; height:18px; border-radius:50%;
    display:flex; align-items:center; justify-content:center; padding:0 3px; border:2px solid var(--bg);
  }
  .nav-link{ font-size:14px; font-weight:600; color:var(--ink); }
  .btn-pill{
    background:var(--ink); color:#fff; padding:11px 24px; border-radius:24px;
    font-size:13.5px; font-weight:700; border:none; cursor:pointer; transition:transform .15s, opacity .15s;
  }
  .btn-pill:hover{ opacity:.85; transform:translateY(-1px); }

  /* ============ HERO ============ */
  .hero{
    max-width:1240px; margin:0 auto; padding:64px 32px 40px;
    display:grid; grid-template-columns:1fr 1fr; gap:50px; align-items:center;
  }
  .hero-eyebrow{
    display:inline-flex; align-items:center; gap:8px; background:var(--peach); color:var(--peach-ink);
    padding:7px 16px; border-radius:20px; font-size:12.5px; font-weight:700; margin-bottom:18px;
  }
  .hero h1{ font-size:clamp(34px,4.6vw,54px); line-height:1.08; font-weight:800; margin-bottom:18px; letter-spacing:-1px; }
  .hero p{ color:var(--muted); font-size:16px; line-height:1.65; max-width:460px; margin-bottom:26px; }
  .hero-actions{ display:flex; gap:14px; flex-wrap:wrap; }
  .btn-outline{
    padding:13px 26px; border-radius:26px; font-weight:700; font-size:14px; border:1.5px solid var(--ink); cursor:pointer; background:none;
  }
  .btn-outline:hover{ background:var(--surface); }

  .hero-visual{ position:relative; height:340px; }
  .hero-card{
    position:absolute; background:var(--surface); border-radius:20px; box-shadow:var(--shadow); padding:20px; text-align:center;
  }
  .hc-1{ top:0; left:8%; width:180px; transform:rotate(-4deg); background:var(--blue); }
  .hc-2{ top:90px; left:38%; width:200px; transform:rotate(2deg); background:var(--peach); z-index:2; }
  .hc-3{ top:20px; left:64%; width:170px; transform:rotate(-2deg); background:var(--green); }
  .hero-card .cat{ font-family:'Poppins',sans-serif; font-weight:700; font-size:17px; }

  /* ============ TRUST STRIP ============ */
  .features-section{
    max-width:1240px; margin:10px auto 50px; padding:0 32px;
    display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px;
  }
  .feature-card{
    background:var(--surface); border-radius:var(--radius); padding:22px 22px; display:flex; align-items:center; gap:14px;
  }
  .feature-icon{
    width:44px;height:44px;border-radius:12px; display:flex;align-items:center;justify-content:center; font-size:19px; flex-shrink:0;
  }
  .feature-text h4{ font-size:14.5px; margin-bottom:3px; }
  .feature-text p{ font-size:12px; color:var(--muted); }

  /* ============ CATALOG ============ */
  .main-container{ max-width:1240px; margin:10px auto 60px; padding:0 32px; flex:1; width:100%; }

  .toolbar{
    display:flex; flex-wrap:wrap; gap:18px; justify-content:space-between; align-items:flex-end;
    margin-bottom:30px; padding-bottom:20px; border-bottom:1px solid var(--border);
  }
  .toolbar h2{ font-size:28px; font-weight:800; letter-spacing:-.5px; }
  .toolbar .eyebrow{ font-size:13px; color:var(--muted); font-weight:600; margin-bottom:4px; text-transform:uppercase; letter-spacing:.6px; }
  .toolbar-controls{ display:flex; gap:10px; flex-wrap:wrap; align-items:center; }

  .chip-row{ display:flex; gap:8px; flex-wrap:wrap; }
  .chip{
    display:flex; align-items:center; gap:6px;
    padding:8px 16px; border-radius:20px; border:1px solid var(--border); background:var(--bg);
    font-size:12.5px; font-weight:600; color:var(--ink); cursor:pointer; transition:all .15s;
  }
  .chip:hover{ background:var(--surface); }
  .chip.active{ background:var(--ink); color:#fff; border-color:var(--ink); }

  select#sortSelect{
    padding:9px 14px; border-radius:20px; border:1px solid var(--border); background:var(--bg);
    font-size:12.5px; font-weight:600; color:var(--ink); cursor:pointer; outline:none;
  }

  .product-grid{ display:grid; grid-template-columns:repeat(auto-fill,minmax(240px,1fr)); gap:26px; padding-top:6px; }

  .product-card{
    background:var(--surface); border-radius:var(--radius); overflow:hidden; position:relative;
    transition: transform .2s ease, box-shadow .2s ease; box-shadow:var(--shadow-sm);
    opacity:0; animation: cardIn .35s ease forwards; display:flex; flex-direction:column;
  }
  @keyframes cardIn{ from{opacity:0; transform:translateY(10px);} to{opacity:1; transform:none;} }
  .product-card:hover{ transform:translateY(-6px); box-shadow:var(--shadow); }

  .img-wrapper{
    position:relative; width:100%; height:170px; display:flex; align-items:center; justify-content:center;
    background:#fff; padding:14px;
  }
  .product-img{ max-width:100%; max-height:100%; object-fit:contain; }

  .cat-badge{
    position:absolute; top:12px; left:12px; padding:5px 12px; border-radius:14px; font-size:11px; font-weight:700;
  }

  .product-body{ padding:14px 16px 18px; display:flex; flex-direction:column; flex:1; }
  .product-title{ font-size:15px; color:var(--ink); font-weight:700; line-height:1.3; margin-bottom:8px; min-height:38px; }
  .product-price{ font-family:'Poppins',sans-serif; font-weight:700; font-size:18px; margin-bottom:12px; }

  .btn-add-cart{
    width:100%; background:var(--ink); color:#fff; border:none;
    padding:11px; font-size:12.5px; font-weight:700; letter-spacing:.2px;
    border-radius:22px; cursor:pointer; transition:opacity .2s, transform .1s; margin-top:auto;
  }
  .btn-add-cart:hover{ opacity:.85; }
  .btn-add-cart:active{ transform:scale(.96); }

  /* skeletons */
  .skeleton-card{ background:var(--surface); border-radius:var(--radius); padding:0 0 16px; overflow:hidden; }
  .skeleton{ background:linear-gradient(90deg,#efece6 25%,#f8f6f1 37%,#efece6 63%); background-size:400% 100%; animation:sk 1.4s ease infinite; }
  @keyframes sk{ 0%{background-position:100% 50%;} 100%{background-position:0 50%;} }
  .sk-img{ width:100%; height:170px; }
  .sk-line{ height:11px; margin:14px 16px 10px; border-radius:6px; }
  .sk-line.short{ width:55%; }
  .sk-btn{ height:38px; margin:8px 16px 0; border-radius:20px; }

  .empty-state,.error-state{
    grid-column:1/-1; text-align:center; padding:60px 20px; color:var(--muted);
    background:var(--surface); border-radius:var(--radius);
  }
  .empty-state .emoji,.error-state .emoji{ font-size:32px; display:block; margin-bottom:14px; }
  .error-state{ background:#fdeceb; color:var(--red-ink); }

  /* ============ FOOTER ============ */
  footer{ background:var(--ink); padding:50px 32px 22px; color:#cfcac2; margin-top:24px; }
  .footer-container{
    max-width:1240px; margin:0 auto; display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:32px;
    padding-bottom:26px; border-bottom:1px solid rgba(255,255,255,.12);
  }
  .footer-col h4{ color:#fff; font-size:15px; font-weight:700; margin-bottom:12px; }
  .footer-col p,.footer-col a{ font-size:13px; color:#cfcac2; text-decoration:none; display:block; margin-bottom:9px; }
  .footer-col a:hover{ color:#fff; }
  .footer-bottom{
    max-width:1240px; margin:18px auto 0; display:flex; justify-content:space-between;
    font-size:11.5px; color:#918c85; flex-wrap:wrap; gap:10px;
  }

  /* ============ CART DRAWER ============ */
  .overlay{ position:fixed; inset:0; background:rgba(20,20,20,.45); z-index:400; opacity:0; pointer-events:none; transition:opacity .3s; }
  .overlay.open{ opacity:1; pointer-events:auto; }
  .cart-drawer{
    position:fixed; top:0; right:0; height:100%; width:min(400px,92vw);
    background:var(--bg); color:var(--ink); z-index:500;
    box-shadow:-16px 0 40px rgba(0,0,0,.15); transform:translateX(100%);
    transition:transform .35s cubic-bezier(.4,0,.2,1); display:flex; flex-direction:column;
  }
  .cart-drawer.open{ transform:translateX(0); }
  .cart-header{ padding:26px 24px 18px; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; }
  .cart-header h3{ font-size:20px; font-weight:800; }
  .cart-header p{ font-size:11.5px; color:var(--muted); margin-top:2px; }
  .cart-close{ background:var(--surface); border:none; width:34px;height:34px;border-radius:50%; font-size:18px; cursor:pointer; color:var(--muted); }
  .cart-close:hover{ background:#efece6; }
  .cart-items{ flex:1; overflow-y:auto; padding:16px 24px; }
  .cart-item{ display:flex; gap:14px; padding:15px 0; border-bottom:1px solid var(--border); align-items:center; }
  .cart-item img{ width:52px;height:52px; object-fit:contain; background:var(--surface); border-radius:12px; padding:6px; }
  .cart-item-info{ flex:1; }
  .cart-item-info h5{ font-size:13.5px; font-weight:700; margin-bottom:3px; }
  .cart-item-info span{ font-size:11.5px; color:var(--muted); }
  .cart-remove{ background:none; border:none; color:var(--red-ink); cursor:pointer; font-size:11px; font-weight:700; }
  .cart-remove:hover{ text-decoration:underline; }
  .cart-footer{ padding:18px 24px 26px; }
  .cart-total{ display:flex; justify-content:space-between; align-items:baseline; margin:8px 0 18px; }
  .cart-total span:first-child{ font-size:13.5px; color:var(--muted); font-weight:600; }
  .cart-total span:last-child{ font-family:'Poppins',sans-serif; font-size:26px; font-weight:800; }
  .cart-checkout{
    width:100%; padding:14px; border:none; border-radius:26px; background:var(--ink); color:#fff;
    font-weight:700; cursor:pointer; transition:opacity .15s; font-size:14px;
  }
  .cart-checkout:hover{ opacity:.85; }
  .cart-empty{ text-align:center; color:var(--muted); padding:50px 10px; font-size:13px; }

  /* ============ TOASTS ============ */
  #toastRoot{ position:fixed; bottom:22px; right:22px; z-index:600; display:flex; flex-direction:column; gap:10px; }
  .toast{
    background:var(--ink); color:#fff; padding:13px 20px; border-radius:14px; font-size:13px;
    box-shadow:var(--shadow); position:relative; max-width:280px; font-weight:600;
    animation:toastIn .3s ease forwards;
  }
  .toast.success{ background:var(--green-ink); }
  @keyframes toastIn{ from{opacity:0; transform:translateY(10px);} to{opacity:1; transform:none;} }
  .toast.hide{ animation:toastOut .3s ease forwards; }
  @keyframes toastOut{ to{opacity:0; transform:translateX(30px);} }

  @media (max-width:860px){
    .hero{ grid-template-columns:1fr; }
    .hero-visual{ height:220px; }
  }
  @media (max-width:720px){
    .search-wrap{ display:none; }
    .nav-links{ display:none; }
  }
</style>
</head>
<body>

  <div class="navbar">
    <div class="nav-container">
      <a href="index.jsp" class="logo"><span class="hex"><span></span></span>E-Shop</a>
      <div class="nav-links">
        <a href="index.jsp" class="active">Home</a>
        <a href="#catalog">Shop</a>
        <a href="login.jsp">Login</a>
      </div>
      <div class="nav-actions">
        <div class="search-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
          <input type="text" id="searchInput" placeholder="Search products...">
        </div>
        <button class="cart-btn" id="cartBtn" title="View cart">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
          <span class="cart-badge" id="cartBadge">0</span>
        </button>
        <a href="signup.jsp" class="btn-pill">Register</a>
      </div>
    </div>
  </div>

  <section class="hero">
    <div>
      <div class="hero-eyebrow">&#10024; New arrivals every week</div>
      <h1>Everything worth<br>having, shopped simply.</h1>
      <p>Electronics, books, apparel, and stationery &mdash; one clean catalog, honest prices, and checkout in a couple of clicks.</p>
      <div class="hero-actions">
        <a href="#catalog" class="btn-pill">Browse the Shop</a>
        <a href="signup.jsp" class="btn-outline">Create an Account</a>
      </div>
    </div>
    <div class="hero-visual">
      <div class="hero-card hc-1"><div class="cat">Electronics</div></div>
      <div class="hero-card hc-2"><div class="cat">Books</div></div>
      <div class="hero-card hc-3"><div class="cat">Apparel</div></div>
    </div>
  </section>

  <div class="features-section">
    <div class="feature-card"><div class="feature-icon" style="background:var(--peach);">&#128666;</div><div class="feature-text"><h4>Fast Delivery</h4><p>Ships within 24 hours</p></div></div>
    <div class="feature-card"><div class="feature-icon" style="background:var(--blue);">&#128737;&#65039;</div><div class="feature-text"><h4>Secure Payments</h4><p>100% encrypted transactions</p></div></div>
    <div class="feature-card"><div class="feature-icon" style="background:var(--green);">&#127911;</div><div class="feature-text"><h4>24/7 Support</h4><p>Dedicated customer service</p></div></div>
  </div>

  <main class="main-container" id="catalog">
    <div class="toolbar">
      <div>
        <div class="eyebrow">What's new</div>
        <h2>Featured Inventory</h2>
      </div>
      <div class="toolbar-controls">
        <div class="chip-row" id="categoryChips">
          <button class="chip active" data-cat="all">All</button>
        </div>
        <select id="sortSelect">
          <option value="default">Sort: Featured</option>
          <option value="price-asc">Price: Low to High</option>
          <option value="price-desc">Price: High to Low</option>
          <option value="name-asc">Name: A-Z</option>
        </select>
      </div>
    </div>

    <div class="product-grid" id="catalogGrid">
      <div class="skeleton-card"><div class="skeleton sk-img"></div><div class="skeleton sk-line"></div><div class="skeleton sk-line short"></div><div class="skeleton sk-btn"></div></div>
      <div class="skeleton-card"><div class="skeleton sk-img"></div><div class="skeleton sk-line"></div><div class="skeleton sk-line short"></div><div class="skeleton sk-btn"></div></div>
      <div class="skeleton-card"><div class="skeleton sk-img"></div><div class="skeleton sk-line"></div><div class="skeleton sk-line short"></div><div class="skeleton sk-btn"></div></div>
      <div class="skeleton-card"><div class="skeleton sk-img"></div><div class="skeleton sk-line"></div><div class="skeleton sk-line short"></div><div class="skeleton sk-btn"></div></div>
    </div>
  </main>

  <footer>
    <div class="footer-container">
      <div class="footer-col">
        <h4>E-Shop</h4>
        <p>Your one-stop destination for quality items delivered right to your door.</p>
      </div>
      <div class="footer-col">
        <h4>Quick Links</h4>
        <a href="index.jsp">Home Catalog</a>
        <a href="login.jsp">Customer Login</a>
        <a href="signup.jsp">Create Account</a>
      </div>
      <div class="footer-col">
        <h4>Categories</h4>
        <a href="#catalog">Electronics</a>
        <a href="#catalog">Stationery</a>
        <a href="#catalog">Books &amp; Apparel</a>
      </div>
      <div class="footer-col">
        <h4>Admin Access</h4>
        <p>Authorized personnel only.</p>
        <a href="login.jsp" style="color:#fff;font-weight:700;">Go to Admin Panel &rarr;</a>
      </div>
    </div>
    <div class="footer-bottom">
      <span>&copy; 2026 E-Shop Systems. All rights reserved.</span>
      <span>Accepted Payments: UPI &bull; Cards &bull; NetBanking</span>
    </div>
  </footer>

  <div class="overlay" id="overlay"></div>
  <aside class="cart-drawer" id="cartDrawer">
    <div class="cart-header">
      <div>
        <h3>Your Cart</h3>
        <p>not yet charged</p>
      </div>
      <button class="cart-close" id="cartClose">&times;</button>
    </div>
    <div class="cart-items" id="cartItems"></div>
    <div class="cart-footer">
      <div class="cart-total"><span>Total</span><span id="cartTotal">&#8377;0</span></div>
      <button class="cart-checkout" id="checkoutBtn">Proceed to Checkout</button>
    </div>
  </aside>

  <div id="toastRoot"></div>

  <script>
    const GET_URL = "http://localhost:8081/product";
    const catalogGrid = document.getElementById("catalogGrid");
    const categoryChips = document.getElementById("categoryChips");
    const sortSelect = document.getElementById("sortSelect");
    const searchInput = document.getElementById("searchInput");

    let allProducts = [];
    let activeCategory = "all";
    let cart = JSON.parse(localStorage.getItem("eshop_cart") || "[]");

    const BADGE_STYLES = [
      { bg: "var(--peach)", ink: "var(--peach-ink)" },
      { bg: "var(--blue)", ink: "var(--blue-ink)" },
      { bg: "var(--green)", ink: "var(--green-ink)" },
      { bg: "var(--red)", ink: "var(--red-ink)" },
      { bg: "var(--purple)", ink: "var(--purple-ink)" },
    ];
    function badgeFor(name) {
      let hash = 0;
      for (let i = 0; i < name.length; i++) hash = name.charCodeAt(i) + ((hash << 5) - hash);
      return BADGE_STYLES[Math.abs(hash) % BADGE_STYLES.length];
    }

    function showToast(message, type) {
      type = type || "info";
      const root = document.getElementById("toastRoot");
      const el = document.createElement("div");
      el.className = "toast " + type;
      el.textContent = message;
      root.appendChild(el);
      setTimeout(function () {
        el.classList.add("hide");
        setTimeout(function () { el.remove(); }, 300);
      }, 2600);
    }

    function saveCart() {
      localStorage.setItem("eshop_cart", JSON.stringify(cart));
      renderCartBadge();
      renderCartDrawer();
    }

    function renderCartBadge() {
      const count = cart.reduce(function (sum, item) { return sum + item.qty; }, 0);
      document.getElementById("cartBadge").textContent = count;
    }

    function renderCartDrawer() {
      const wrap = document.getElementById("cartItems");
      if (cart.length === 0) {
        wrap.innerHTML = '<div class="cart-empty">Your cart is empty.<br>Add something from the shop.</div>';
        document.getElementById("cartTotal").textContent = "\u20B90";
        return;
      }
      let total = 0;
      wrap.innerHTML = cart.map(function (item, idx) {
        total += item.price * item.qty;
        return '<div class="cart-item">' +
                 '<img src="' + (item.img || "https://placehold.co/80") + '" alt="' + item.name + '">' +
                 '<div class="cart-item-info"><h5>' + item.name + '</h5><span>Qty ' + item.qty + ' &times; \u20B9' + item.price + '</span></div>' +
                 '<button class="cart-remove" data-idx="' + idx + '">Remove</button>' +
               '</div>';
      }).join("");
      document.getElementById("cartTotal").textContent = "\u20B9" + total;

      wrap.querySelectorAll(".cart-remove").forEach(function (btn) {
        btn.addEventListener("click", function () {
          const idx = parseInt(btn.getAttribute("data-idx"), 10);
          cart.splice(idx, 1);
          saveCart();
        });
      });
    }

    function addToCart(product) {
      const existing = cart.find(function (i) { return i.id === product.id; });
      if (existing) { existing.qty += 1; }
      else { cart.push({ id: product.id, name: product.name, price: product.price, img: product.base64Image, qty: 1 }); }
      saveCart();
      showToast('Added "' + product.name + '" to your cart', "success");
      openCart();
    }

    function openCart() {
      document.getElementById("cartDrawer").classList.add("open");
      document.getElementById("overlay").classList.add("open");
    }
    function closeCart() {
      document.getElementById("cartDrawer").classList.remove("open");
      document.getElementById("overlay").classList.remove("open");
    }

    document.getElementById("cartBtn").addEventListener("click", openCart);
    document.getElementById("cartClose").addEventListener("click", closeCart);
    document.getElementById("overlay").addEventListener("click", closeCart);
    document.getElementById("checkoutBtn").addEventListener("click", function () {
      if (cart.length === 0) { showToast("Your cart is empty.", "info"); return; }
      showToast("Log in to complete checkout.", "info");
      setTimeout(function () { window.location.href = "login.jsp"; }, 900);
    });

    function escapeHtml(str) {
      return String(str).replace(/[&<>"']/g, function (c) {
        return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c];
      });
    }

    function renderCategoryChips(products) {
      const cats = Array.from(new Set(products.map(function (p) { return p.category || "General"; })));
      categoryChips.innerHTML = '<button class="chip active" data-cat="all">All</button>' +
        cats.map(function (c) {
          return '<button class="chip" data-cat="' + escapeHtml(c) + '">' + escapeHtml(c) + '</button>';
        }).join("");

      categoryChips.querySelectorAll(".chip").forEach(function (chip) {
        chip.addEventListener("click", function () {
          categoryChips.querySelectorAll(".chip").forEach(function (c) { c.classList.remove("active"); });
          chip.classList.add("active");
          activeCategory = chip.getAttribute("data-cat");
          applyFiltersAndRender();
        });
      });
    }

    function getFilteredProducts() {
      let list = allProducts.slice();
      if (activeCategory !== "all") {
        list = list.filter(function (p) { return (p.category || "General") === activeCategory; });
      }
      const q = searchInput.value.trim().toLowerCase();
      if (q) {
        list = list.filter(function (p) {
          return (p.name || "").toLowerCase().indexOf(q) !== -1 ||
                 (p.category || "").toLowerCase().indexOf(q) !== -1;
        });
      }
      const sortVal = sortSelect.value;
      if (sortVal === "price-asc") list.sort(function (a, b) { return a.price - b.price; });
      else if (sortVal === "price-desc") list.sort(function (a, b) { return b.price - a.price; });
      else if (sortVal === "name-asc") list.sort(function (a, b) { return (a.name || "").localeCompare(b.name || ""); });
      return list;
    }

    function renderGrid(products) {
      if (products.length === 0) {
        catalogGrid.innerHTML = '<div class="empty-state"><span class="emoji">&#128269;</span>Nothing matches your search right now.</div>';
        return;
      }

      catalogGrid.innerHTML = products.map(function (product, i) {
        const imgSrc = product.base64Image || "https://placehold.co/220";
        const categoryName = escapeHtml(product.category || "General");
        const prodName = escapeHtml(product.name || "Unnamed Item");
        const prodPrice = product.price || 0;
        const badge = badgeFor(product.category || "General");

        return '<div class="product-card" style="animation-delay:' + (Math.min(i, 10) * 0.04) + 's">' +
                 '<div class="img-wrapper">' +
                   '<span class="cat-badge" style="background:' + badge.bg + ';color:' + badge.ink + ';">' + categoryName + '</span>' +
                   '<img src="' + imgSrc + '" class="product-img" alt="' + prodName + '" onerror="this.src=\'https://placehold.co/220\'">' +
                 '</div>' +
                 '<div class="product-body">' +
                   '<h3 class="product-title">' + prodName + '</h3>' +
                   '<div class="product-price">\u20B9' + prodPrice + '</div>' +
                   '<button class="btn-add-cart" data-id="' + product.id + '">Add to Cart</button>' +
                 '</div>' +
               '</div>';
      }).join("");

      catalogGrid.querySelectorAll(".btn-add-cart").forEach(function (btn) {
        btn.addEventListener("click", function () {
          const id = parseInt(btn.getAttribute("data-id"), 10);
          const product = allProducts.find(function (p) { return p.id === id; });
          if (product) addToCart(product);
        });
      });
    }

    function applyFiltersAndRender() { renderGrid(getFilteredProducts()); }

    async function loadCatalog() {
      try {
        const response = await fetch(GET_URL);
        if (!response.ok) throw new Error("Failed to pull inventory dataset.");
        const products = await response.json();
        allProducts = products || [];

        if (allProducts.length === 0) {
          catalogGrid.innerHTML = '<div class="empty-state"><span class="emoji">&#128230;</span>No products currently in the shop.</div>';
          return;
        }
        renderCategoryChips(allProducts);
        applyFiltersAndRender();
      } catch (error) {
        console.error("Storefront error:", error);
        catalogGrid.innerHTML = '<div class="error-state"><span class="emoji">!</span>Couldn\'t reach the warehouse system. Check that the backend is running.</div>';
      }
    }

    searchInput.addEventListener("input", applyFiltersAndRender);
    sortSelect.addEventListener("change", applyFiltersAndRender);

    renderCartBadge();
    renderCartDrawer();
    loadCatalog();
  </script>
</body>
</html>
