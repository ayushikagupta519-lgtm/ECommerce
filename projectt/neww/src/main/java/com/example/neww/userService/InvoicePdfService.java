package com.example.neww.userService;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.neww.user.ProductOrder;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Generates the invoice / report PDFs that the admin dashboard's
 * "Download PDF" buttons fetch. Runs entirely on the server using the
 * OpenPDF library (already declared in pom.xml), so the buttons no
 * longer depend on the html2pdf.js CDN script or client-side rendering.
 */
@Service
public class InvoicePdfService {

    private static final Color BRAND_BLUE = new Color(74, 144, 226);
    private static final Color LIGHT_GREY = new Color(242, 242, 242);
    private static final Color TEXT_GREY = new Color(119, 119, 119);

    private static final Font TITLE_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, BRAND_BLUE);
    private static final Font SUBTITLE_FONT = FontFactory.getFont(FontFactory.HELVETICA, 10, TEXT_GREY);
    private static final Font HEADING_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, Color.DARK_GRAY);
    private static final Font LABEL_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.DARK_GRAY);
    private static final Font BODY_FONT = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.DARK_GRAY);
    private static final Font TABLE_HEADER_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.WHITE);
    private static final Font TOTAL_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 15, BRAND_BLUE);
    private static final Font FOOTER_FONT = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 9, TEXT_GREY);

    /** Single-order invoice, matching every field shown on the admin sales log row. */
    public byte[] generateInvoicePdf(ProductOrder order) {
        Document document = new Document(PageSize.A4, 40, 40, 50, 50);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            String orderId = String.valueOf(order.getOrderId());
            String customerName = safe(order.getCustomerName(), "Customer");
            String customerId = String.valueOf(order.getCustomerId());
            String orderDate = safe(order.getOrderDate(), "N/A");
            String paymentMethod = safe(order.getPaymentMethod(), "N/A");
            String itemSummary = safe(order.getItemSummary(), "N/A");
            String totalAmount = "\u20B9" + safe(order.getTotalAmount(), "0");

            // Header: title/subtitle on the left, order id/date on the right
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);
            headerTable.setWidths(new float[] { 3, 2 });

            PdfPCell titleCell = borderlessCell();
            titleCell.addElement(new Paragraph("E-Shop Invoice", TITLE_FONT));
            titleCell.addElement(new Paragraph("Payment Receipt", SUBTITLE_FONT));
            headerTable.addCell(titleCell);

            PdfPCell orderCell = borderlessCell();
            orderCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Paragraph orderPara = new Paragraph("Order #" + orderId, HEADING_FONT);
            orderPara.setAlignment(Element.ALIGN_RIGHT);
            Paragraph datePara = new Paragraph("Date: " + orderDate, SUBTITLE_FONT);
            datePara.setAlignment(Element.ALIGN_RIGHT);
            orderCell.addElement(orderPara);
            orderCell.addElement(datePara);
            headerTable.addCell(orderCell);

            document.add(headerTable);

            Paragraph rule = new Paragraph(" ");
            rule.setSpacingAfter(6f);
            document.add(rule);

            // Customer details box
            PdfPTable customerBox = new PdfPTable(1);
            customerBox.setWidthPercentage(100);
            customerBox.setSpacingBefore(10f);
            customerBox.setSpacingAfter(16f);
            PdfPCell box = new PdfPCell();
            box.setBackgroundColor(LIGHT_GREY);
            box.setBorderColor(new Color(238, 238, 238));
            box.setPadding(12f);
            box.addElement(new Paragraph("Customer Details", LABEL_FONT));
            box.addElement(new Paragraph("Name: " + customerName, BODY_FONT));
            box.addElement(new Paragraph("Customer ID: #" + customerId, BODY_FONT));
            box.addElement(new Paragraph("Payment Method: " + paymentMethod, BODY_FONT));
            customerBox.addCell(box);
            document.add(customerBox);

            // Items table
            PdfPTable itemsTable = new PdfPTable(2);
            itemsTable.setWidthPercentage(100);
            itemsTable.setWidths(new float[] { 3, 1 });

            PdfPCell itemsHeader = tableHeaderCell("Items Description");
            itemsTable.addCell(itemsHeader);
            PdfPCell amountHeader = tableHeaderCell("Amount");
            amountHeader.setHorizontalAlignment(Element.ALIGN_RIGHT);
            itemsTable.addCell(amountHeader);

            PdfPCell itemsCell = new PdfPCell(new Phrase(itemSummary, BODY_FONT));
            itemsCell.setPadding(8f);
            itemsTable.addCell(itemsCell);

            PdfPCell amountCell = new PdfPCell(new Phrase(totalAmount, LABEL_FONT));
            amountCell.setPadding(8f);
            amountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            itemsTable.addCell(amountCell);

            itemsTable.setSpacingAfter(16f);
            document.add(itemsTable);

            // Total paid
            Paragraph totalPara = new Paragraph("Total Paid: " + totalAmount, TOTAL_FONT);
            totalPara.setAlignment(Element.ALIGN_RIGHT);
            totalPara.setSpacingAfter(30f);
            document.add(totalPara);

            // Footer
            Paragraph footer = new Paragraph("Thank you for shopping with E-Shop Online!", FOOTER_FONT);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (Exception e) {
            throw new RuntimeException("Failed to generate invoice PDF for order " + order.getOrderId(), e);
        }

        return out.toByteArray();
    }

    /** Full (or date-filtered) sales & transaction log report. */
    public byte[] generateReportPdf(List<ProductOrder> orders) {
        Document document = new Document(PageSize.A4.rotate(), 30, 30, 40, 40);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Paragraph title = new Paragraph("Sales & Transaction Log Report", HEADING_FONT);
            document.add(title);
            Paragraph generated = new Paragraph("Generated on: " + new Date(), SUBTITLE_FONT);
            generated.setSpacingAfter(14f);
            document.add(generated);

            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.setWidths(new float[] { 1.5f, 3f, 4f, 2.5f, 2f, 2f });

            String[] headers = { "Order ID", "Customer", "Items Purchased", "Date & Time", "Method", "Total Paid" };
            for (String h : headers) {
                table.addCell(tableHeaderCell(h));
            }

            for (ProductOrder o : orders) {
                String customer = safe(o.getCustomerName(), "Customer") + " (#" + o.getCustomerId() + ")";
                String amount = "\u20B9" + safe(o.getTotalAmount(), "0");

                table.addCell(bodyCell("#" + o.getOrderId(), LABEL_FONT));
                table.addCell(bodyCell(customer, BODY_FONT));
                table.addCell(bodyCell(safe(o.getItemSummary(), "N/A"), BODY_FONT));
                table.addCell(bodyCell(safe(o.getOrderDate(), "N/A"), BODY_FONT));
                table.addCell(bodyCell(safe(o.getPaymentMethod(), "N/A"), BODY_FONT));
                table.addCell(bodyCell(amount, LABEL_FONT));
            }

            document.add(table);
            document.close();
        } catch (Exception e) {
            throw new RuntimeException("Failed to generate sales report PDF", e);
        }

        return out.toByteArray();
    }

    private PdfPCell tableHeaderCell(String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, TABLE_HEADER_FONT));
        cell.setBackgroundColor(BRAND_BLUE);
        cell.setPadding(6f);
        return cell;
    }

    private PdfPCell bodyCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPadding(6f);
        return cell;
    }

    private PdfPCell borderlessCell() {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(0);
        cell.setPadding(0f);
        return cell;
    }

    private String safe(String value, String fallback) {
        return (value == null || value.isBlank()) ? fallback : value;
    }
}
