package com.gymapp.service;

import java.awt.Color;

import org.springframework.stereotype.Service;

import com.gymapp.entity.Member;
import com.lowagie.text.Chunk;
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

import jakarta.servlet.http.HttpServletResponse;

@Service
public class MemberPdfService {

	public void generateMembershipReceipt(Member member, HttpServletResponse response) throws Exception {
		// Set response type and header
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=membership_receipt_" + member.getId() + ".pdf");

		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());

		document.open();

		// Fonts
		Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, Color.BLUE);
		Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.DARK_GRAY);
		Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Color.BLACK);

		// ===== Title =====
		Paragraph title = new Paragraph("🏋️ Gym Membership Confirmation", titleFont);
		title.setAlignment(Element.ALIGN_CENTER);
		document.add(title);
		document.add(Chunk.NEWLINE);

		// ===== Payment confirmation =====
		Paragraph paymentMsg = new Paragraph("✅ Payment Successful! Your membership has been confirmed.", normalFont);
		paymentMsg.setAlignment(Element.ALIGN_CENTER);
		document.add(paymentMsg);
		document.add(Chunk.NEWLINE);
		document.add(Chunk.NEWLINE);

		// ===== Member Details Table =====
		PdfPTable table = new PdfPTable(2);
		table.setWidthPercentage(90);
		table.setWidths(new float[] { 1, 2 });
		table.setSpacingBefore(10);
		table.setSpacingAfter(20);

		addCell(table, "Member ID:", member.getId(), sectionFont, normalFont);
		addCell(table, "Name:", member.getName(), sectionFont, normalFont);
		addCell(table, "Email:", member.getEmail(), sectionFont, normalFont);

		// ===== Plan Details =====
		addCell(table, "Plan Name:", member.getPlan() != null ? member.getPlan().getName() : "", sectionFont,
				normalFont);
		addCell(table, "Start Date:", member.getPlanStartDate() != null ? member.getPlanStartDate().toString() : "",
				sectionFont, normalFont);
		addCell(table, "Expiry Date:", member.getPlanExpiryDate() != null ? member.getPlanExpiryDate().toString() : "",
				sectionFont, normalFont);
		addCell(table, "Fee Paid:", member.getPlan() != null ? "Rs. " + member.getPlan().getPrice() : "", sectionFont,
				normalFont);

		// ===== Trainer Details =====
		addCell(table, "Trainer:", member.getTrainer() != null ? member.getTrainer().getName() : "", sectionFont,
				normalFont);

		document.add(table);

		// ===== Thank You Message =====
		Paragraph thanks = new Paragraph("Thank you for joining our Gym! 💪", sectionFont);
		thanks.setAlignment(Element.ALIGN_CENTER);
		document.add(thanks);

		document.close();
	}

	private void addCell(PdfPTable table, String key, Object value, Font keyFont, Font valueFont) {
		PdfPCell keyCell = new PdfPCell(new Phrase(key != null ? key.toString() : "", keyFont));
		keyCell.setBackgroundColor(Color.LIGHT_GRAY);
		keyCell.setPadding(5);
		keyCell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(keyCell);

		PdfPCell valueCell = new PdfPCell(new Phrase(value != null ? value.toString() : "", valueFont));
		valueCell.setPadding(5);
		valueCell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(valueCell);
	}
}
