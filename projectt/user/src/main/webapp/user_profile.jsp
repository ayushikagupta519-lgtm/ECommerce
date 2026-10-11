<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Portal &mdash; E-Shop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#ffffff; --surface:#faf9f7; --ink:#141414; --muted:#6b7280; --muted-2:#9ca3af;
    --border:#ececec; --peach:#fbd7ac; --peach-ink:#7a4a10; --blue:#afcfea; --blue-ink:#1a4971;
    --green:#a9d6b8; --green-ink:#205530; --red:#f0a8a0; --red-ink:#7a241c; --purple:#cdb8ef; --purple-ink:#4a2d7a;
    --radius:18px; --shadow:0 14px 34px rgba(20,20,20,.08);
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{
    font-family:'Inter', sans-serif; color:var(--ink); min-height:100vh; padding:36px 20px;
    background:var(--surface);
  }
  h1,h2,h3,.display{ font-family:'Poppins',sans-serif; }

  .portal-layout{
    display:grid; grid-template-columns:1fr 350px; gap:26px; max-width:1200px; margin:0 auto; width:100%;
  }
  @media (max-width: 850px){ .portal-layout{ grid-template-columns:1fr; } }

  header{
    display:flex; justify-content:space-between; align-items:center; background:var(--bg);
    padding:20px 28px; border-radius:20px; box-shadow:var(--shadow); margin-bottom:14px; grid-column:1/-1;
    border:1px solid var(--border);
  }
  header h2{ font-size:21px; font-weight:800; letter-spacing:-.4px; }
  .logout-btn{ color:var(--red-ink); text-decoration:none; font-weight:700; font-size:13.5px; background:#fdeceb; padding:9px 18px; border-radius:20px; }
  .logout-btn:hover{ opacity:.8; }

  .filter-bar{
    grid-column:1/-1; background:var(--bg); padding:16px 24px; border-radius:20px; box-shadow:var(--shadow);
    display:flex; align-items:center; gap:12px; margin-bottom:22px; flex-wrap:wrap; border:1px solid var(--border);
  }
  .filter-label{ font-size:13px; font-weight:700; color:var(--muted); }
  .category-dropdown{
    padding:10px 18px; border:1.5px solid var(--border); border-radius:20px; background:var(--surface);
    font-size:13.5px; font-weight:700; color:var(--ink); outline:none; cursor:pointer; min-width:200px;
    transition:all .2s;
  }
  .category-dropdown:hover, .category-dropdown:focus{ border-color:var(--ink); background:var(--bg); }

  .category-section{
    margin-bottom:26px; background:var(--bg); padding:22px; border-radius:20px; box-shadow:var(--shadow); border:1px solid var(--border);
  }
  .category-title{
    font-size:19px; font-weight:800; color:var(--ink); margin-bottom:16px; padding-bottom:12px; border-bottom:1px solid var(--border);
  }

  .product-grid{ display:grid; grid-template-columns:repeat(auto-fill,minmax(200px,1fr)); gap:18px; }
  .product-card{
    background:var(--surface); border-radius:16px; overflow:hidden; display:flex; flex-direction:column; transition:transform .2s, box-shadow .2s;
  }
  .product-card:hover{ transform:translateY(-4px); box-shadow:var(--shadow); }

  .product-img-container{
    width:100%; height:130px; background:var(--bg); position:relative;
    display:flex; align-items:center; justify-content:center;
  }
  .product-img{ width:100%; height:100%; object-fit:contain; padding:10px; box-sizing:border-box; }

  .product-info{ padding:12px 14px 14px; }
  .product-id{ font-size:10.5px; color:var(--muted-2); font-family:monospace; margin-bottom:3px; }
  .product-name{ font-size:13.5px; color:var(--ink); font-weight:700; margin-bottom:6px; }
  .product-price{ font-size:16px; color:var(--ink); font-weight:800; margin-bottom:12px; font-family:'Poppins',sans-serif; }

  .add-cart-btn{
    width:100%; background:var(--ink); color:#fff; border:none; padding:9px; font-size:12px;
    font-weight:700; border-radius:18px; cursor:pointer; transition:opacity .2s;
  }
  .add-cart-btn:hover{ opacity:.85; }

  .cart-sidebar{ background:var(--bg); padding:24px; border-radius:20px; box-shadow:var(--shadow); align-self:start; border:1px solid var(--border); }
  .cart-title{ font-size:19px; font-weight:800; margin-bottom:16px; padding-bottom:14px; border-bottom:1px solid var(--border); }

  .cart-list{ list-style:none; max-height:240px; overflow-y:auto; margin-bottom:15px; }
  .cart-item{ display:flex; justify-content:space-between; align-items:center; font-size:13.5px; padding:10px 0; border-bottom:1px solid var(--border); }
  .cart-item-info{ color:var(--ink); font-weight:600; max-width:110px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }

  .quantity-control{ display:flex; align-items:center; gap:6px; background:var(--surface); padding:3px 8px; border-radius:14px; }
  .qty-btn{ background:none; border:none; font-size:14px; font-weight:bold; color:var(--muted); cursor:pointer; width:16px; text-align:center; }
  .qty-btn:hover{ color:var(--ink); }
  .qty-val{ font-size:13px; font-weight:700; min-width:14px; text-align:center; }

  .cart-item-right{ display:flex; align-items:center; gap:8px; }
  .cart-item-price{ font-weight:700; color:var(--ink); }
  .remove-item-btn{ background:none; border:none; color:var(--red-ink); cursor:pointer; font-size:16px; line-height:1; }

  .payment-section{ margin:18px 0; background:var(--surface); padding:16px; border-radius:16px; }
  .payment-title{ font-size:13px; font-weight:700; color:var(--ink); margin-bottom:10px; }
  .payment-options{ display:flex; flex-direction:column; gap:9px; }
  .payment-label{ display:flex; align-items:center; gap:8px; font-size:13px; color:var(--ink); cursor:pointer; }

  .cart-total-box{
    display:flex; justify-content:space-between; align-items:baseline; font-weight:bold; padding-top:12px;
    border-top:1px solid var(--border); margin-bottom:18px;
  }
  .cart-total-box span:first-child{ font-size:13px; color:var(--muted); }
  .cart-total-box span:last-child{ font-family:'Poppins',sans-serif; font-size:24px; font-weight:800; }

  .checkout-btn{
    width:100%; background:var(--green-ink); color:#fff; border:none; padding:13px; font-size:14px;
    font-weight:700; border-radius:24px; cursor:pointer; transition:opacity .15s;
  }
  .checkout-btn:hover{ opacity:.85; }
  .checkout-btn:disabled{ background:#d8d3ca; cursor:not-allowed; }

  .status-msg{ text-align:center; padding:26px; color:var(--muted); font-size:14px; }

  .invoice-title{ font-size:14.5px; font-weight:700; color:var(--ink); margin-bottom:12px; }
  #orderHistoryList li{ border-bottom:1px solid var(--border); }
  .invoice-download-btn{
    padding:5px 12px; font-size:11px; font-weight:700; color:var(--blue-ink); background:var(--blue);
    border:none; border-radius:14px; cursor:pointer;
  }

  /* --- BILL MODAL --- */
  .bill-overlay{
    display:none; position:fixed; inset:0; background:rgba(20,20,20,.5); justify-content:center; align-items:center; z-index:9999;
  }
  .bill-card{
    background:var(--bg); padding:34px; border-radius:22px; width:100%; max-width:440px;
    box-shadow:var(--shadow); position:relative; font-family:'Courier New', Courier, monospace;
  }
</style>
</head>
<body>

<div class="portal-layout">

    <header>
        <h2>Welcome, Customer</h2>
        <a href="login.jsp" class="logout-btn">Log Out</a>
    </header>

    <div class="filter-bar">
        <label class="filter-label" for="categoryFilter">Filter by Category:</label>
        <select id="categoryFilter" class="category-dropdown" onchange="filterProducts()">
            <option value="ALL">All Categories</option>
        </select>
    </div>

    <main id="catalogCategoriesContainer">
        <div class="status-msg">Loading marketplace catalog...</div>
    </main>

    <aside class="cart-sidebar">
        <div class="cart-title">Shopping Cart</div>

        <ul class="cart-list" id="cartList">
            <li class="status-msg" id="emptyCartMsg">Your cart is empty</li>
        </ul>

        <div class="payment-section" id="paymentSection" style="display: none;">
            <div class="payment-title">Select Payment Method</div>
            <div class="payment-options">
                <label class="payment-label"><input type="radio" name="paymentMethod" value="UPI" checked> UPI (GPay, Paytm)</label>
                <label class="payment-label"><input type="radio" name="paymentMethod" value="Card"> Credit / Debit Card</label>
                <label class="payment-label"><input type="radio" name="paymentMethod" value="NetBanking"> Net Banking</label>
                <label class="payment-label"><input type="radio" name="paymentMethod" value="COD"> Cash on Delivery</label>
            </div>
        </div>

        <div class="cart-total-box">
            <span>Total:</span>
            <span id="cartTotal">&#8377;0</span>
        </div>

        <button type="button" class="checkout-btn" id="checkoutBtn" disabled onclick="processCheckout()">
            Proceed to Checkout
        </button>

        <div style="margin-top: 26px; border-top: 1px solid var(--border); padding-top: 18px;">
            <div class="invoice-title">Your Past Invoices</div>
            <ul id="orderHistoryList" style="list-style: none; max-height: 200px; overflow-y: auto;">
             <li style="font-size: 13px; color: var(--muted); text-align: center; padding: 10px;" id="noOrdersMsg">No past transactions found.</li>
            </ul>
        </div>
    </aside>

</div>

<div id="billModal" class="bill-overlay">
    <div class="bill-card">

        <div style="text-align: center; border-bottom: 2px dashed var(--ink); padding-bottom: 15px; margin-bottom: 15px;">
            <h2 style="font-size: 22px; text-transform: uppercase; letter-spacing: 1px;">TAX INVOICE</h2>
            <p style="font-size: 13px; margin-top: 5px; font-weight: bold;">E-SHOP</p>
        </div>

        <div style="font-size: 14px; line-height: 1.6; margin-bottom: 15px;">
            <p><strong>Customer Name:</strong> <span id="billCustomerName"></span></p>
            <p><strong>Customer ID  :</strong> #<span id="billCustomerId"></span></p>
            <p><strong>Date         :</strong> <span id="billDate"></span></p>
            <p><strong>Payment via  :</strong> <span id="billPaymentMethod"></span></p>
        </div>

        <div style="border-top: 1px dashed var(--ink); border-bottom: 1px dashed var(--ink); padding: 8px 0; margin-bottom: 15px; font-weight: bold; font-size: 14px; display: flex; justify-content: space-between;">
            <span style="width: 50%;">ITEM NAME</span>
            <span style="width: 20%; text-align: center;">QTY</span>
            <span style="width: 30%; text-align: right;">PRICE</span>
        </div>

        <div id="billItemsContainer" style="font-size: 14px; max-height: 180px; overflow-y: auto; margin-bottom: 15px; line-height: 1.8;"></div>

        <div style="border-top: 2px dashed var(--ink); padding-top: 15px; display: flex; justify-content: space-between; font-weight: bold; font-size: 18px; margin-bottom: 25px;">
            <span>GRAND TOTAL:</span>
            <span id="billGrandTotal">&#8377;0</span>
        </div>

        <div style="display: flex; gap: 10px;">
            <button type="button" onclick="window.print()" style="flex: 1; padding: 12px; background: var(--blue-ink); color: white; border: none; font-weight: bold; border-radius: 20px; cursor: pointer; font-family: 'Inter', sans-serif;">Print Bill</button>
            <button type="button" onclick="closeBill()" style="flex: 1; padding: 12px; background: var(--red-ink); color: white; border: none; font-weight: bold; border-radius: 20px; cursor: pointer; font-family: 'Inter', sans-serif;">Close</button>
        </div>
    </div>
</div>

<script>
    const GET_URL = "http://localhost:8081/product";
    const mainContainer = document.getElementById("catalogCategoriesContainer");
    const cartList = document.getElementById("cartList");
    const emptyCartMsg = document.getElementById("emptyCartMsg");
    const cartTotal = document.getElementById("cartTotal");
    const checkoutBtn = document.getElementById("checkoutBtn");
    const paymentSection = document.getElementById("paymentSection");
    const orderHistoryList = document.getElementById("orderHistoryList");
    const noOrdersMsg = document.getElementById("noOrdersMsg");

    let currentCart = [];
    let savedOrders = [];
    let allProducts = [];

    window.addEventListener('DOMContentLoaded', () => {
        const savedName = sessionStorage.getItem("userName") || "Customer";
        const savedId = sessionStorage.getItem("userId") || "N/A";
        document.querySelector("header h2").innerText = "Welcome, " + savedName;

        const localData = localStorage.getItem("orders_id_" + savedId);
        if (localData) {
            savedOrders = JSON.parse(localData);
            renderOrderHistory();
        }
    });

    async function loadCatalog() {
        try {
            const response = await fetch(GET_URL);
            if (!response.ok) throw new Error("Failed to load inventory mapping stream.");

            allProducts = await response.json();

            if (allProducts.length === 0) {
                mainContainer.innerHTML = '<div class="status-msg">Marketplace inventory database is currently empty.</div>';
                return;
            }

            const filterSelect = document.getElementById("categoryFilter");
            filterSelect.innerHTML = '<option value="ALL">All Categories</option>';

            const categories = [...new Set(allProducts.map(p => p.category || "General Merchandise"))];
            categories.forEach(cat => {
                const opt = document.createElement("option");
                opt.value = cat;
                opt.innerText = cat;
                filterSelect.appendChild(opt);
            });

            renderCatalog(allProducts);

        } catch (error) {
            console.error("Catalog failure:", error);
            mainContainer.innerHTML = '<div class="status-msg" style="color: var(--red-ink);">Failed to access marketplace catalog. Ensure Spring Boot is running.</div>';
        }
    }

    function filterProducts() {
        const selectedCategory = document.getElementById("categoryFilter").value;
        if (selectedCategory === "ALL") {
            renderCatalog(allProducts);
        } else {
            const filtered = allProducts.filter(p => (p.category || "General Merchandise") === selectedCategory);
            renderCatalog(filtered);
        }
    }

    function renderCatalog(productsToDisplay) {
        mainContainer.innerHTML = "";

        if (productsToDisplay.length === 0) {
            mainContainer.innerHTML = '<div class="status-msg">No products found in this category.</div>';
            return;
        }

        const groupedProducts = {};
        productsToDisplay.forEach(product => {
            const cat = product.category || "General Merchandise";
            if (!groupedProducts[cat]) {
                groupedProducts[cat] = [];
            }
            groupedProducts[cat].push(product);
        });

        for (const categoryName in groupedProducts) {
            const section = document.createElement("div");
            section.className = "category-section";

            const heading = document.createElement("div");
            heading.className = "category-title";
            heading.innerText = categoryName;
            section.appendChild(heading);

            const grid = document.createElement("div");
            grid.className = "product-grid";

            groupedProducts[categoryName].forEach(product => {
                const card = document.createElement("div");
                card.className = "product-card";

                const imgUrl = product.base64Image || "https://placehold.co";

                let cardContent = '<div class="product-img-container">' +
                                  '<img src="' + imgUrl + '" class="product-img" alt="Product Image" onerror="this.src=\'https://placehold.co\'">' +
                                  '</div>' +
                                  '<div class="product-info">' +
                                  '<div class="product-id">#' + product.id + '</div>' +
                                  '<div class="product-name">' + product.name + '</div>' +
                                  '<div class="product-price">&#8377;' + product.price + '</div>' +
                                  '<button type="button" class="add-cart-btn" onclick=\'addToCart(' + JSON.stringify(product) + ')\'>Add to Cart</button>' +
                                  '</div>';

                card.innerHTML = cardContent;
                grid.appendChild(card);
            });

            section.appendChild(grid);
            mainContainer.appendChild(section);
        }
    }

    function addToCart(product) {
        const existingItem = currentCart.find(item => item.id === product.id);
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            currentCart.push({ id: product.id, name: product.name, price: product.price, quantity: 1 });
        }
        updateCartUi();
    }

    function changeQuantity(id, delta) {
        const item = currentCart.find(item => item.id === id);
        if (item) {
            item.quantity += delta;
            if (item.quantity <= 0) { removeFromCart(id); return; }
        }
        updateCartUi();
    }

    function removeFromCart(id) {
        currentCart = currentCart.filter(item => item.id !== id);
        updateCartUi();
    }

    function updateCartUi() {
        cartList.innerHTML = "";
        if (currentCart.length === 0) {
            cartList.appendChild(emptyCartMsg);
            cartTotal.innerText = "\u20B90";
            checkoutBtn.disabled = true;
            paymentSection.style.display = "none";
            return;
        }

        let dynamicSubtotal = 0;
        paymentSection.style.display = "block";

        currentCart.forEach(item => {
            const itemTotalCost = item.price * item.quantity;
            dynamicSubtotal += itemTotalCost;

            const li = document.createElement("li");
            li.className = "cart-item";

            let itemContent = '<div class="cart-item-info">' + item.name + '</div>' +
                              '<div class="quantity-control">' +
                              '<button class="qty-btn" onclick="changeQuantity(' + item.id + ', -1)">-</button>' +
                              '<span class="qty-val">' + item.quantity + '</span>' +
                              '<button class="qty-btn" onclick="changeQuantity(' + item.id + ', 1)">+</button>' +
                              '</div>' +
                              '<div class="cart-item-right">' +
                              '<span class="cart-item-price">\u20B9' + itemTotalCost + '</span>' +
                              '<button class="remove-item-btn" onclick="removeFromCart(' + item.id + ')">&times;</button>' +
                              '</div>';

            li.innerHTML = itemContent;
            cartList.appendChild(li);
        });

        cartTotal.innerText = "\u20B9" + dynamicSubtotal;
        checkoutBtn.disabled = false;
    }

    function processCheckout() {
        const savedName = sessionStorage.getItem("userName") || "Valued Customer";
        const savedId = sessionStorage.getItem("userId") || "0";
        const selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        const dateString = new Date().toLocaleString();

        const itemSummaryText = currentCart.map(item => item.name + ' (x' + item.quantity + ')').join(', ');
        // Strip the currency symbol before sending to the backend so it isn't
        // double-prefixed with ₹ later when displayed in the admin sales log / PDFs.
        const rawTotalAmount = cartTotal.innerText.replace(/[^0-9.]/g, "");

        const orderData = new URLSearchParams();
        orderData.append("customerId", parseInt(savedId));
        orderData.append("customerName", savedName);
        orderData.append("paymentMethod", selectedMethod);
        orderData.append("orderDate", dateString);
        orderData.append("totalAmount", rawTotalAmount);
        orderData.append("itemSummary", itemSummaryText);

        fetch('http://localhost:8081/api/orders', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: orderData
        })
        .then(response => {
            if (!response.ok) throw new Error("Database transaction storage error");
            return response.text();
        })
        .then(msg => {
            const orderRecord = {
                orderId: Date.now(),
                customerName: savedName,
                customerId: savedId,
                paymentMethod: selectedMethod,
                date: dateString,
                items: [...currentCart],
                totalAmount: cartTotal.innerText
            };
            savedOrders.push(orderRecord);
            localStorage.setItem("orders_id_" + savedId, JSON.stringify(savedOrders));

            renderOrderHistory();
            showBillModal(orderRecord);
        })
        .catch(err => {
            console.error(err);
            alert("Transaction sync failed on server.");
        });
    }

    function showBillModal(order) {
        document.getElementById("billCustomerName").innerText = order.customerName;
        document.getElementById("billCustomerId").innerText = order.customerId;
        document.getElementById("billPaymentMethod").innerText = order.paymentMethod;
        document.getElementById("billDate").innerText = order.date;
        document.getElementById("billGrandTotal").innerText = order.totalAmount;

        const itemsContainer = document.getElementById("billItemsContainer");
        itemsContainer.innerHTML = "";

        order.items.forEach(item => {
            const row = document.createElement("div");
            row.style.display = "flex";
            row.style.justifyContent = "space-between";
            row.style.fontSize = "14px";

            row.innerHTML = '<span style="width: 50%; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">' + item.name + '</span>' +
                            '<span style="width: 20%; text-align: center;">' + item.quantity + '</span>' +
                            '<span style="width: 30%; text-align: right;">\u20B9' + (item.price * item.quantity) + '</span>';

            itemsContainer.appendChild(row);
        });

        document.getElementById("billModal").style.display = "flex";
    }

    function renderOrderHistory() {
        orderHistoryList.innerHTML = "";

        if (savedOrders.length === 0) {
            orderHistoryList.appendChild(noOrdersMsg);
            return;
        }

        savedOrders.forEach((order, index) => {
            const li = document.createElement("li");
            li.style.display = "flex";
            li.style.justifyContent = "space-between";
            li.style.alignItems = "center";
            li.style.padding = "10px 0";
            li.style.fontSize = "13px";

            let formattedDate = order.date.split(",");

            let historyContent = '<div>' +
                                 '<div style="font-weight:700; color:var(--ink);">Bill ' + order.totalAmount + '</div>' +
                                 '<small style="color:var(--muted); font-size:11px;">' + formattedDate + '</small>' +
                                 '</div>' +
                                 '<button type="button" class="invoice-download-btn" onclick="reDownloadBill(' + index + ')">Download</button>';

            li.innerHTML = historyContent;
            orderHistoryList.appendChild(li);
        });
    }

    function reDownloadBill(index) {
        showBillModal(savedOrders[index]);
    }

    function closeBill() {
        document.getElementById("billModal").style.display = "none";
        currentCart = [];
        updateCartUi();
    }

    loadCatalog();
</script>
</body>
</html>
