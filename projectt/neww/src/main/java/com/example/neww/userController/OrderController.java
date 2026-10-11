package com.example.neww.userController;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.neww.user.ProductOrder;
import com.example.neww.userService.InvoicePdfService;
import com.example.neww.userService.OrderService;

@RestController
@CrossOrigin(origins = "http://localhost:8080")
public class OrderController {

    private final OrderService orderService;
    private final InvoicePdfService invoicePdfService;

    public OrderController(OrderService orderService, InvoicePdfService invoicePdfService) {
        this.orderService = orderService;
        this.invoicePdfService = invoicePdfService;
    }

    @PostMapping("/api/orders")
    public ResponseEntity<String> createOrder(@ModelAttribute ProductOrder order) {
        orderService.saveOrder(order);
        return ResponseEntity.ok("Order saved securely in database!");
    }

    @GetMapping("/api/orders")
    public List<ProductOrder> getAllOrders() {
        return orderService.getAllOrders();
    }

    // Powers the per-row "Download PDF" button on the admin Sales & Transaction Log.
    // Generates the invoice server-side (OpenPDF) so it always has the full,
    // authoritative order details instead of relying on client-side rendering.
    @GetMapping(value = "/api/orders/{id}/invoice/pdf", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> downloadInvoice(@PathVariable int id) {
        return orderService.getOrderById(id)
                .map(order -> {
                    byte[] pdf = invoicePdfService.generateInvoicePdf(order);
                    return ResponseEntity.ok()
                            .header(HttpHeaders.CONTENT_DISPOSITION,
                                    "attachment; filename=Invoice_Order_" + id + ".pdf")
                            .contentType(MediaType.APPLICATION_PDF)
                            .body(pdf);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // Powers the "Download PDF Report" button. Accepts the order IDs currently
    // displayed on the dashboard (after any date filter is applied) so the
    // report always matches what the admin sees on screen; an empty/missing
    // body falls back to the full order log.
    @PostMapping(value = "/api/orders/report/pdf", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> downloadSalesReport(@RequestBody(required = false) List<Integer> orderIds) {
        List<ProductOrder> allOrders = orderService.getAllOrders();
        List<ProductOrder> selected = (orderIds == null || orderIds.isEmpty())
                ? allOrders
                : allOrders.stream()
                        .filter(o -> orderIds.contains(o.getOrderId()))
                        .collect(Collectors.toList());

        if (selected.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        byte[] pdf = invoicePdfService.generateReportPdf(selected);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Sales_Transaction_Report.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }
}
