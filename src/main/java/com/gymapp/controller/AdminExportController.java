package com.gymapp.controller;

import com.gymapp.entity.Member;
import com.gymapp.entity.Plan;
import com.gymapp.entity.Trainer;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.PlanRepository;
import com.gymapp.repository.TrainerRepository;

import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.security.access.prepost.PreAuthorize;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.util.List;
import java.awt.Color;

@Controller
@RequestMapping("/admin/export")
public class AdminExportController {

	@Autowired
	private MemberRepository memberRepo;

	@Autowired
	private TrainerRepository trainerRepo;

	@Autowired
	private PlanRepository planRepo; // <-- Plan repository

	private void addTableHeader(PdfPTable table, String... headers) {
		Font headerFont = new Font(Font.HELVETICA, 12, Font.BOLD);
		for (String header : headers) {
			PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
			cell.setBackgroundColor(Color.LIGHT_GRAY);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
		}
	}

	// ---------------- MEMBERS PDF ----------------
	@GetMapping("/members/pdf")
	public void exportMembersPDF(HttpServletResponse response) throws Exception {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=members.pdf");

		List<Member> members = memberRepo.findAll();

		Document document = new Document(PageSize.A4.rotate());
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();

		Font titleFont = new Font(Font.HELVETICA, 16, Font.BOLD);
		document.add(new Paragraph("Gym Members Report", titleFont));
		document.add(new Paragraph(" "));

		PdfPTable table = new PdfPTable(7); // ID, Name, Email, Plan, Start, Expiry, Trainer
		table.setWidthPercentage(100);
		table.setWidths(new float[] { 1, 3, 4, 3, 3, 3, 3 });

		addTableHeader(table, "ID", "Name", "Email", "Plan", "Start Date", "Expiry Date", "Trainer");

		for (Member m : members) {
			table.addCell(String.valueOf(m.getId()));
			table.addCell(m.getName());
			table.addCell(m.getEmail());
			table.addCell(m.getPlan() != null ? m.getPlan().getName() : "");
			table.addCell(m.getPlanStartDate() != null ? m.getPlanStartDate().toString() : "");
			table.addCell(m.getPlanExpiryDate() != null ? m.getPlanExpiryDate().toString() : "");
			table.addCell(m.getTrainer() != null ? m.getTrainer().getName() : "");
		}

		document.add(table);
		document.close();
	}

	// ---------------- MEMBERS EXCEL ----------------
	@GetMapping("/members/excel")
	public void exportMembersExcel(HttpServletResponse response) throws Exception {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=members.xlsx");

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Members");

		String[] columns = { "ID", "Name", "Email", "Plan", "Start Date", "Expiry Date", "Trainer" };
		Row header = sheet.createRow(0);
		for (int i = 0; i < columns.length; i++) {
			Cell cell = header.createCell(i);
			cell.setCellValue(columns[i]);
			CellStyle style = workbook.createCellStyle();
			org.apache.poi.ss.usermodel.Font font = workbook.createFont();
			font.setBold(true);
			style.setFont(font);
			cell.setCellStyle(style);
		}

		List<Member> members = memberRepo.findAll();
		int rowNum = 1;
		for (Member m : members) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(m.getId());
			row.createCell(1).setCellValue(m.getName());
			row.createCell(2).setCellValue(m.getEmail());
			row.createCell(3).setCellValue(m.getPlan() != null ? m.getPlan().getName() : "");
			row.createCell(4).setCellValue(m.getPlanStartDate() != null ? m.getPlanStartDate().toString() : "");
			row.createCell(5).setCellValue(m.getPlanExpiryDate() != null ? m.getPlanExpiryDate().toString() : "");
			row.createCell(6).setCellValue(m.getTrainer() != null ? m.getTrainer().getName() : "");
		}

		for (int i = 0; i < columns.length; i++) {
			sheet.autoSizeColumn(i);
		}

		workbook.write(response.getOutputStream());
		workbook.close();
	}

	// ---------------- TRAINERS PDF ----------------
	@GetMapping("/trainers/pdf")
	public void exportTrainersPDF(HttpServletResponse response) throws Exception {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=trainers.pdf");

		List<Trainer> trainers = trainerRepo.findAll();
		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();

		Font titleFont = new Font(Font.HELVETICA, 16, Font.BOLD);
		document.add(new Paragraph("Gym Trainers Report", titleFont));
		document.add(new Paragraph(" "));

		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);
		table.setWidths(new float[] { 1, 3, 4 });
		addTableHeader(table, "ID", "Name", "Email");

		for (Trainer t : trainers) {
			table.addCell(String.valueOf(t.getId()));
			table.addCell(t.getName());
			table.addCell(t.getEmail());
		}

		document.add(table);
		document.close();
	}

	// ---------------- TRAINERS EXCEL ----------------
	@GetMapping("/trainers/excel")
	public void exportTrainersExcel(HttpServletResponse response) throws Exception {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=trainers.xlsx");

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Trainers");

		String[] columns = { "ID", "Name", "Email" };
		Row header = sheet.createRow(0);
		for (int i = 0; i < columns.length; i++) {
			Cell cell = header.createCell(i);
			cell.setCellValue(columns[i]);
			CellStyle style = workbook.createCellStyle();
			org.apache.poi.ss.usermodel.Font font = workbook.createFont();
			font.setBold(true);
			style.setFont(font);
			cell.setCellStyle(style);
		}

		List<Trainer> trainers = trainerRepo.findAll();
		int rowNum = 1;
		for (Trainer t : trainers) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(t.getId());
			row.createCell(1).setCellValue(t.getName());
			row.createCell(2).setCellValue(t.getEmail());
		}

		for (int i = 0; i < columns.length; i++) {
			sheet.autoSizeColumn(i);
		}

		workbook.write(response.getOutputStream());
		workbook.close();
	}

	// ---------------- PLANS PDF ----------------
	@GetMapping("/plans/pdf")
	public void exportPlansPDF(HttpServletResponse response) throws Exception {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=plans.pdf");

		List<Plan> plans = planRepo.findAll();
		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();

		Font titleFont = new Font(Font.HELVETICA, 16, Font.BOLD);
		document.add(new Paragraph("Gym Plans Report", titleFont));
		document.add(new Paragraph(" "));

		PdfPTable table = new PdfPTable(4); // ID, Name, Duration, Price
		table.setWidthPercentage(100);
		table.setWidths(new float[] { 1, 4, 2, 2 });
		addTableHeader(table, "ID", "Name", "Duration (months)", "Price (Rs)");

		for (Plan p : plans) {
			table.addCell(String.valueOf(p.getId()));
			table.addCell(p.getName());
			table.addCell(String.valueOf(p.getDuration()));
			table.addCell(String.valueOf(p.getPrice()));
		}

		document.add(table);
		document.close();
	}

	// ---------------- PLANS EXCEL ----------------
	@GetMapping("/plans/excel")
	public void exportPlansExcel(HttpServletResponse response) throws Exception {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=plans.xlsx");

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Plans");

		String[] columns = { "ID", "Name", "Duration (months)", "Price (Rs)" };
		Row header = sheet.createRow(0);
		for (int i = 0; i < columns.length; i++) {
			Cell cell = header.createCell(i);
			cell.setCellValue(columns[i]);
			CellStyle style = workbook.createCellStyle();
			org.apache.poi.ss.usermodel.Font font = workbook.createFont();
			font.setBold(true);
			style.setFont(font);
			cell.setCellStyle(style);
		}

		List<Plan> plans = planRepo.findAll();
		int rowNum = 1;
		for (Plan p : plans) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(p.getId());
			row.createCell(1).setCellValue(p.getName());
			row.createCell(2).setCellValue(p.getDuration());
			row.createCell(3).setCellValue(p.getPrice());
		}

		for (int i = 0; i < columns.length; i++) {
			sheet.autoSizeColumn(i);
		}

		workbook.write(response.getOutputStream());
		workbook.close();
	}
}
