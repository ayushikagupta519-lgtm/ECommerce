<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard &mdash; E-Shop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#ffffff; --surface:#faf9f7; --ink:#141414; --muted:#6b7280; --muted-2:#9ca3af;
    --border:#ececec; --peach:#fbd7ac; --peach-ink:#7a4a10; --blue:#afcfea; --blue-ink:#1a4971;
    --green:#a9d6b8; --green-ink:#205530; --red:#f0a8a0; --red-ink:#7a241c;
    --radius:18px; --shadow:0 14px 34px rgba(20,20,20,.08);
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{
    font-family:'Inter', sans-serif; color:var(--ink); min-height:100vh;
    padding:44px 20px; display:flex; flex-direction:column; align-items:center;
    background:var(--surface);
  }
  h1,h2,h3,.display{ font-family:'Poppins',sans-serif; }

  .dashboard-container{
    background:var(--bg); border-radius:24px; box-shadow:var(--shadow); border:1px solid var(--border);
    padding:34px 36px; width:100%; max-width:940px;
  }

  header{
    display:flex; justify-content:space-between; align-items:center;
    margin-bottom:28px; border-bottom:1px solid var(--border); padding-bottom:20px;
  }
  header h2{ font-size:24px; font-weight:800; letter-spacing:-.5px; }
  .eyebrow{ display:inline-block; background:var(--peach); color:var(--peach-ink); padding:5px 13px; border-radius:14px; font-size:11px; font-weight:700; margin-bottom:8px; }
  .logout-btn{ color:var(--red-ink); text-decoration:none; font-weight:700; font-size:13.5px; background:#fdeceb; padding:9px 18px; border-radius:20px; }
  .logout-btn:hover{ opacity:.8; }

  h3{ margin-bottom:16px; color:var(--ink); font-size:16px; font-weight:800; }

  .product-form{
    display:grid; grid-template-columns:repeat(auto-fit,minmax(150px,1fr)); gap:14px;
    margin-bottom:38px; background:var(--surface); padding:22px; border-radius:var(--radius); border:1px solid var(--border);
  }
  .form-group{ display:flex; flex-direction:column; }
  label{ margin-bottom:6px; color:var(--ink); font-size:11.5px; font-weight:700; }

  input[type="text"], input[type="number"], input[type="file"], input[type="date"], select{
    width:100%; padding:10px 13px; border-radius:12px; border:1.5px solid var(--border);
    background:var(--bg); color:var(--ink); font-family:'Inter',sans-serif; font-size:13.5px; outline:none;
    transition:border-color .2s;
  }
  input[type="file"]{ border-radius:10px; padding:8px 10px; }
  input:focus, select:focus{ border-color:var(--ink); }
  input:disabled{ background-color:#efece6; color:var(--muted-2); cursor:not-allowed; }

  .btn-submit{
    grid-column:1/-1; background:var(--ink); color:#fff; border:none; border-radius:24px;
    padding:12px; font-size:14px; font-weight:700; cursor:pointer; margin-top:4px;
    transition:opacity .15s, background-color .2s;
  }
  .btn-submit:hover{ opacity:.85; }

  .table-container{ width:100%; overflow-x:auto; }
  table{ width:100%; border-collapse:collapse; text-align:left; font-size:13px; }
  th, td{ padding:13px 14px; border-bottom:1px solid var(--border); }
  th{ background:var(--surface); color:var(--muted); font-weight:700; text-transform:uppercase; font-size:10.5px; letter-spacing:.5px; }
  tr:hover td{ background:var(--surface); }

  .action-btn{
    padding:7px 14px; font-size:11.5px; font-weight:700; border-radius:16px; cursor:pointer; border:none; margin-right:5px;
    transition:opacity .15s;
  }
  .action-btn:hover{ opacity:.8; }
  .edit-btn{ background:var(--peach); color:var(--peach-ink); }
  .delete-btn{ background:var(--red); color:var(--red-ink); }
  .pdf-btn{
    background:var(--green); color:var(--green-ink); padding:6px 12px; font-size:10.5px; font-weight:700;
    border:none; border-radius:16px; cursor:pointer; transition:opacity .15s;
  }
  .pdf-btn:hover{ opacity:.8; }

  .prod-thumb{ width:44px; height:44px; object-fit:contain; border-radius:10px; border:1px solid var(--border); background:var(--bg); }

  .category-badge{
    background:var(--blue); color:var(--blue-ink); padding:4px 12px; border-radius:12px; font-size:11px; font-weight:700; display:inline-block;
  }

  .filter-bar{
    display:flex; gap:10px; align-items:flex-end; margin-bottom:16px; background:var(--surface);
    padding:16px; border-radius:var(--radius); border:1px solid var(--border); flex-wrap:wrap;
  }
  .btn-mini{
    padding:9px 16px; font-size:12.5px; font-weight:700; border:none;
    border-radius:16px; cursor:pointer; transition:opacity .15s;
  }
  .btn-mini:hover{ opacity:.85; }
  .btn-apply{ background:var(--blue); color:var(--blue-ink); }
  .btn-clear{ background:#eee; color:var(--muted); }
  .btn-download{ background:var(--ink); color:#fff; margin-left:auto; }
</style>
</head>
<body>

<div class="dashboard-container">
  <header>
    <div>
      <div class="eyebrow">Admin</div>
      <h2>Product Panel</h2>
    </div>
    <a href="login.jsp" class="logout-btn">Log Out</a>
  </header>

  <section>
    <h3 id="form-title">Add New Product</h3>
    <form id="productForm" class="product-form" enctype="multipart/form-data">

        <div class="form-group">
            <label for="prodId">Product ID</label>
            <input type="number" id="prodId" name="id" required placeholder="e.g., 101">
        </div>

        <div class="form-group">
            <label for="prodName">Product Name</label>
            <input type="text" id="prodName" name="name" required placeholder="e.g., Keyboard">
        </div>

        <div class="form-group">
            <label for="prodPrice">Price (&#8377;)</label>
            <input type="number" id="prodPrice" name="price" required placeholder="e.g., 500">
        </div>

        <div class="form-group">
            <label for="prodCategory">Select Category</label>
            <select id="prodCategory" name="category" required>
                <option value="" disabled selected>Choose Category</option>
                <option value="Electronics">Electronics</option>
                <option value="Stationery">Stationery</option>
                <option value="Books">Books</option>
                <option value="Fashion">Fashion</option>
            </select>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
            <label for="prodImage">Product Image</label>
            <input type="file" id="prodImage" name="imageFile" accept="image/*" required>
        </div>

        <button type="submit" id="submitBtn" class="btn-submit">Add Product</button>
    </form>
  </section>

  <section>
    <h3>Current Inventory</h3>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Image</th>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="productTableBody">
            </tbody>
        </table>
    </div>
  </section>

  <section style="margin-top: 38px; border-top: 1px solid var(--border); padding-top: 30px;">
    <h3>Sales &amp; Transaction Log</h3>
    <div class="table-container">
        <div class="filter-bar">
            <div class="form-group" style="margin-bottom: 0;">
                <label for="startDate" style="font-size: 11px;">Start Date</label>
                <input type="date" id="startDate" style="padding: 7px 11px; font-size: 12.5px;">
            </div>
            <div class="form-group" style="margin-bottom: 0;">
                <label for="endDate" style="font-size: 11px;">End Date</label>
                <input type="date" id="endDate" style="padding: 7px 11px; font-size: 12.5px;">
            </div>
            <button type="button" class="btn-mini btn-apply" onclick="applyDateFilter()">Apply Filter</button>
            <button type="button" class="btn-mini btn-clear" onclick="clearDateFilter()">Clear</button>
            <button type="button" class="btn-mini btn-download" onclick="downloadSalesLogPDF()">&#128196; Download PDF Report</button>
        </div>

        <table id="salesLogTable">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer Name (ID)</th>
                    <th>Items Purchased</th>
                    <th>Date &amp; Time</th>
                    <th>Method</th>
                    <th>Total Paid</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="salesTableBody">
                <tr><td colspan="7" style="text-align: center; color: var(--muted); padding: 22px;">Loading live billing log datasets...</td></tr>
            </tbody>
        </table>
    </div>
  </section>

</div>

<script>
    const GET_URL = "http://localhost:8081/product";
    const WRITE_URL = "http://localhost:8081/products";
    const ORDERS_URL = "http://localhost:8081/api/orders";

    const tableBody = document.getElementById("productTableBody");
    const productForm = document.getElementById("productForm");
    const formTitle = document.getElementById("form-title");
    const submitBtn = document.getElementById("submitBtn");

    const prodId = document.getElementById("prodId");
    const prodName = document.getElementById("prodName");
    const prodPrice = document.getElementById("prodPrice");
    const prodImage = document.getElementById("prodImage");

    let isEditing = false;
    let allOrdersCached = [];
    let currentlyDisplayedOrders = [];

    async function loadProducts() {
        try {
            const response = await fetch(GET_URL);
            if (!response.ok) throw new Error("Failed to load inventory dataset.");

            const products = await response.json();
            tableBody.innerHTML = "";

            if (products.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: #999; padding: 20px;">No products found in system database.</td></tr>';
                return;
            }

            products.forEach(product => {
                const row = document.createElement("tr");
                const currentImg = product.base64Image || "https://placehold.co";
                const categoryText = product.category || "Uncategorized";

                let rowContent = '<td><img src="' + currentImg + '" class="prod-thumb" alt="Thumb" onerror="this.src=\'https://placehold.co\'"></td>' +
                                 '<td><code>#' + product.id + '</code></td>' +
                                 '<td><strong>' + product.name + '</strong></td>' +
                                 '<td><span class="category-badge">' + categoryText + '</span></td>' +
                                 '<td>&#8377;' + product.price + '</td>' +
                                 '<td>' +
                                 '<button type="button" class="action-btn edit-btn" onclick=\'prepareEdit(' + JSON.stringify(product) + ')\'>Edit</button>' +
                                 '<button type="button" class="action-btn delete-btn" onclick="deleteProduct(' + product.id + ', \'' + product.name + '\')">Delete</button>' +
                                 '</td>';

                row.innerHTML = rowContent;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error("Data view population error:", error);
            tableBody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: red; padding: 20px;">Failed to connect to backend server. Check if Spring Boot is running.</td></tr>';
        }
    }

    async function loadSalesLog() {
        try {
            const response = await fetch(ORDERS_URL);
            if (!response.ok) throw new Error("Could not pull order log stream data.");

            allOrdersCached = await response.json();
            renderSalesTable(allOrdersCached);
        } catch (error) {
            console.error("Sales log compilation error:", error);
            const salesTableBody = document.getElementById("salesTableBody");
            if (salesTableBody) {
                salesTableBody.innerHTML = '<tr><td colspan="7" style="text-align: center; color: red; padding: 20px;">Failed to secure live billing log connectivity.</td></tr>';
            }
        }
    }

    function renderSalesTable(ordersList) {
        const salesTableBody = document.getElementById("salesTableBody");
        if (!salesTableBody) return;

        currentlyDisplayedOrders = ordersList;
        salesTableBody.innerHTML = "";

        if (ordersList.length === 0) {
            salesTableBody.innerHTML = '<tr><td colspan="7" style="text-align: center; color: #999; padding: 20px;">No matching transactions found for the selected date range.</td></tr>';
            return;
        }

        ordersList.forEach((order, index) => {
            const row = document.createElement("tr");

            let rowContent = '<td><code>#' + order.orderId + '</code></td>' +
                             '<td><strong>' + order.customerName + '</strong> <small style="color:#777;">(#' + order.customerId + ')</small></td>' +
                             '<td style="color:#555; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;" title="' + order.itemSummary + '">' + order.itemSummary + '</td>' +
                             '<td>' + order.orderDate + '</td>' +
                             '<td><span style="background:var(--green); color:var(--green-ink); padding:4px 10px; border-radius:12px; font-size:11px; font-weight:700;">' + order.paymentMethod + '</span></td>' +
                             '<td style="font-weight:700; color:var(--ink);">' + order.totalAmount + '</td>' +
                             '<td><button type="button" class="pdf-btn" onclick="downloadSingleInvoice(' + index + ')">Download PDF</button></td>';

            row.innerHTML = rowContent;
            salesTableBody.appendChild(row);
        });
    }

    function applyDateFilter() {
        const startVal = document.getElementById("startDate").value;
        const endVal = document.getElementById("endDate").value;

        if (!startVal && !endVal) {
            alert("Please pick at least a start or end date to filter.");
            return;
        }

        const startBoundary = startVal ? new Date(startVal + "T00:00:00") : null;
        const endBoundary = endVal ? new Date(endVal + "T23:59:59") : null;

        const filteredList = allOrdersCached.filter(order => {
            if (!order.orderDate) return false;

            const normalizedDateStr = order.orderDate.split(",")[0].trim();
            const dateParts = normalizedDateStr.split("/");

            let transactionDate;
            if (dateParts.length === 3) {
                const day = parseInt(dateParts[0], 10);
                const month = parseInt(dateParts[1], 10) - 1;
                const year = parseInt(dateParts[2], 10);
                transactionDate = new Date(year, month, day);
            } else {
                transactionDate = new Date(order.orderDate);
            }

            if (startBoundary && transactionDate < startBoundary) return false;
            if (endBoundary && transactionDate > endBoundary) return false;

            return true;
        });

        renderSalesTable(filteredList);
    }

    function clearDateFilter() {
        document.getElementById("startDate").value = "";
        document.getElementById("endDate").value = "";
        renderSalesTable(allOrdersCached);
    }

    function triggerPdfDownload(blob, filename) {
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.href = url;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        link.remove();
        window.URL.revokeObjectURL(url);
    }

    async function downloadSalesLogPDF() {
        if (!currentlyDisplayedOrders || currentlyDisplayedOrders.length === 0) {
            alert("No transaction data available to generate PDF.");
            return;
        }

        const orderIds = currentlyDisplayedOrders.map(o => o.orderId);

        try {
            const response = await fetch(ORDERS_URL + "/report/pdf", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(orderIds)
            });

            if (!response.ok) throw new Error("Server returned status " + response.status);

            const blob = await response.blob();
            triggerPdfDownload(blob, "Sales_Transaction_Report.pdf");
        } catch (err) {
            console.error("PDF report generation failed:", err);
            alert("Failed to generate PDF report.");
        }
    }

    async function downloadSingleInvoice(index) {
        const order = currentlyDisplayedOrders[index];
        if (!order) return;

        try {
            const response = await fetch(ORDERS_URL + "/" + order.orderId + "/invoice/pdf");
            if (!response.ok) throw new Error("Server returned status " + response.status);

            const blob = await response.blob();
            triggerPdfDownload(blob, "Invoice_Order_" + order.orderId + ".pdf");
        } catch (err) {
            console.error("Invoice PDF generation failed:", err);
            alert("Failed to generate PDF invoice.");
        }
    }

    productForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        prodId.disabled = false;
        const formData = new FormData(productForm);
        if (isEditing) prodId.disabled = true;

        try {
            let targetUrl = WRITE_URL;
            if (isEditing) {
                targetUrl = WRITE_URL + '/' + prodId.value;
            }

            const response = await fetch(targetUrl, {
                method: 'POST',
                body: formData
            });
            if (response.ok) {
                alert(isEditing ? "Product updated successfully!" : "Product added successfully!");
                resetFormState();
                productForm.reset();
                initializeDashboard();
            } else {
                const errMsg = await response.text();
                alert("Operation Failed: " + errMsg);
            }
        } catch (error) {
            console.error("Submission failed:", error);
            alert("Error sending request to the server.");
        }
    });

    function prepareEdit(product) {
        isEditing = true;
        prodId.value = product.id;
        prodId.disabled = true;
        prodName.value = product.name;
        prodPrice.value = product.price;

        document.getElementById("prodCategory").value = product.category || "";

        prodImage.required = false;
        formTitle.innerText = "Edit Product Details";
        submitBtn.innerText = "Save Changes";
        submitBtn.style.backgroundColor = "var(--peach-ink)";
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    async function deleteProduct(id, name) {
        if (confirm('Are you sure you want to delete "' + name + '"?')) {
            try {
                const response = await fetch(WRITE_URL + '/delete/' + id, {
                    method: 'POST'
                });

                if (response.ok) {
                    alert("Product deleted successfully!");
                    resetFormState();
                    productForm.reset();
                    initializeDashboard();
                } else {
                    const errorResponse = await response.text();
                    alert("Failed to delete entry: " + errorResponse);
                }
            } catch (error) {
                console.error("Deletion network exception:", error);
                alert("Could not reach server to complete item deletion.");
            }
        }
    }

    function resetFormState() {
        isEditing = false;
        prodId.disabled = false;
        prodImage.required = true;
        formTitle.innerText = "Add New Product";
        submitBtn.innerText = "Add Product";
        submitBtn.style.backgroundColor = "var(--ink)";
    }

    function initializeDashboard() {
        loadProducts();
        loadSalesLog();
    }

    initializeDashboard();
</script>

</body>
</html>
