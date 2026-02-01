package com.gymapp.controller;

import com.gymapp.repository.AdminMessageRepository;
import com.gymapp.repository.DeletedMemberRepository;

import com.gymapp.entity.Trainer;
import com.gymapp.dto.DeletedMemberDTO;
import com.gymapp.entity.Admin;
import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.DeletedMember;
import com.gymapp.entity.Member;
import com.gymapp.entity.Plan;
import com.gymapp.repository.TrainerRepository;
import com.gymapp.service.MemberPdfService;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.PlanRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private TrainerRepository trainerRepo;

	@Autowired
	private MemberRepository memberRepo;
	@Autowired
	private AdminMessageRepository adminMessageRepository;
	@Autowired
	private DeletedMemberRepository deletedMemberRepository;
	@Autowired
	private PlanRepository planRepo;
	@Autowired
	private MemberPdfService pdfService;

	@GetMapping("/messages")
	public String adminMessages(Model model) {
		model.addAttribute("messages", adminMessageRepository.findAll());
		return "admin-messages";
	}

	@PostMapping("/messages/reply")
	public String adminReply(@RequestParam Long messageId, @RequestParam String reply, HttpSession session) {
		Admin admin = (Admin) session.getAttribute("admin");

		if (admin == null) {
			return "redirect:/login/admin";
		}

		AdminMessage msg = adminMessageRepository.findById(messageId).orElse(null);
		if (msg != null) {
			msg.setAdminReply(reply);
			msg.setRepliedAt(LocalDateTime.now());
			adminMessageRepository.save(msg);
		}

		return "redirect:/admin/dashboard";
	}

	@GetMapping("/dashboard")
	public String adminDashboard(HttpSession session, Model model) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/login/admin";
		}

		// Dynamic stats
		long totalMembers = memberRepo.count();
		long totalTrainers = trainerRepo.count();
		long totalPlans = planRepo.count();

		model.addAttribute("totalMembers", totalMembers);
		model.addAttribute("totalTrainers", totalTrainers);
		model.addAttribute("totalPlans", totalPlans);

		return "admin-dashboard";
	}

	// ------------------ TRAINER CRUD ------------------

	// List Trainers
	@GetMapping("/trainers")
	public String listTrainers(Model model) {
		List<Trainer> trainers = trainerRepo.findAll();
		model.addAttribute("trainers", trainers);
		return "trainer-list";
	}

	// Add Trainer Form
	@GetMapping("/trainers/add")
	public String addTrainerForm(Model model) {
		model.addAttribute("trainer", new Trainer());
		return "trainer-form";
	}

	// Save Trainer
	@PostMapping("/trainers/save")
	public String saveTrainer(@ModelAttribute Trainer trainer) {
		trainerRepo.save(trainer);
		return "redirect:/admin/trainers";
	}

	// Edit Trainer Form
	@GetMapping("/trainers/edit/{id}")
	public String editTrainerForm(@PathVariable Long id, Model model) {
		Optional<Trainer> t = trainerRepo.findById(id);
		if (t.isPresent()) {
			model.addAttribute("trainer", t.get());
			return "trainer-form";
		}
		return "redirect:/admin/trainers";
	}

	// Delete Trainer
	@GetMapping("/trainers/delete/{id}")
	public String deleteTrainer(@PathVariable Long id) {
		trainerRepo.deleteById(id);
		return "redirect:/admin/trainers";
	}

	// ------------------ MEMBER CRUD ------------------

	@GetMapping("/members")
	public String membersList(Model model) {
		model.addAttribute("today", java.time.LocalDate.now());
		List<Member> members = memberRepo.findAll();
		List<DeletedMember> deletedMembers = deletedMemberRepository.findAll();

		model.addAttribute("members", members);
		model.addAttribute("deletedMembers", deletedMembers);

		return "member-list";
	}

	@GetMapping("/members/add")
	public String addMemberForm(Model model) {
		model.addAttribute("member", new Member());
		model.addAttribute("trainers", trainerRepo.findAll());
		model.addAttribute("plans", planRepo.findAll());
		return "member-form";
	}

	@GetMapping("/members/receipt")
	public void downloadReceipt(@RequestParam Long id, HttpServletResponse response) throws Exception {
		Member member = memberRepo.findById(id).orElseThrow(() -> new RuntimeException("Member not found"));
		pdfService.generateMembershipReceipt(member, response);
	}

	@GetMapping("/members/receipt/{id}")
	public void downloadMemberReceipt(@PathVariable Long id, HttpServletResponse response) throws Exception {
		Member member = memberRepo.findById(id).orElseThrow(() -> new RuntimeException("Member not found"));

		pdfService.generateMembershipReceipt(member, response);
	}

	@PostMapping("/members/save")
	public String saveMember(@ModelAttribute Member member) {

		// Check if this is an existing member
		if (member.getId() != null) {
			// Fetch existing member from DB
			Member existingMember = memberRepo.findById(member.getId())
					.orElseThrow(() -> new IllegalArgumentException("Invalid member ID"));

			// Preserve start and expiry dates unless plan is changed
			if (member.getPlan() != null && !member.getPlan().getId().equals(existingMember.getPlan().getId())) {
				// Plan changed -> update dates based on new plan
				Plan plan = planRepo.findById(member.getPlan().getId()).orElse(null);
				if (plan != null) {
					LocalDate startDate = LocalDate.now();
					LocalDate expiryDate = startDate.plusMonths(plan.getDuration());
					member.setPlan(plan);
					member.setPlanStartDate(startDate);
					member.setPlanExpiryDate(expiryDate);
				}
			} else {
				// Plan not changed -> preserve existing dates
				member.setPlan(existingMember.getPlan());
				member.setPlanStartDate(existingMember.getPlanStartDate());
				member.setPlanExpiryDate(existingMember.getPlanExpiryDate());
			}

		} else {
			// New member -> set plan dates based on selected plan
			if (member.getPlan() != null && member.getPlan().getId() != null) {
				Plan plan = planRepo.findById(member.getPlan().getId()).orElse(null);
				if (plan != null) {
					LocalDate startDate = LocalDate.now();
					LocalDate expiryDate = startDate.plusMonths(plan.getDuration());
					member.setPlan(plan);
					member.setPlanStartDate(startDate);
					member.setPlanExpiryDate(expiryDate);
				}
			}
		}

		// Save member
		Member savedMember = memberRepo.save(member);

		// Redirect with parameters to trigger PDF download
		return "redirect:/admin/members?showReceipt=true&memberId=" + savedMember.getId();
	}

	// Edit Member Form
	@GetMapping("/members/edit/{id}")
	public String editMemberForm(@PathVariable Long id, Model model) {
		Optional<Member> m = memberRepo.findById(id);
		if (m.isPresent()) {
			model.addAttribute("member", m.get());
			model.addAttribute("trainers", trainerRepo.findAll());
			model.addAttribute("plans", planRepo.findAll());
			return "member-form";
		}
		return "redirect:/admin/members";
	}

	@GetMapping("/members/delete/{id}")
	public String deleteMember(@PathVariable Long id) {
		Member member = memberRepo.findById(id)
				.orElseThrow(() -> new IllegalArgumentException("Member not found: " + id));

		// Copy to DeletedMember
		DeletedMember deleted = new DeletedMember();
		deleted.setId(member.getId());
		deleted.setName(member.getName());
		deleted.setEmail(member.getEmail());
		deleted.setPlan(member.getPlan());
		deleted.setTrainer(member.getTrainer());
		deleted.setPlanStartDate(member.getPlanStartDate());
		deleted.setPlanExpiryDate(member.getPlanExpiryDate());
		deleted.setDeletedAt(java.time.LocalDateTime.now());

		deletedMemberRepository.save(deleted);

		// Delete original member
		memberRepo.deleteById(id);
		return "redirect:/admin/members";
	}

	@GetMapping("/admin/members/deleted")
	@ResponseBody
	public List<DeletedMemberDTO> getDeletedMembers() {
		List<DeletedMember> deletedMembers = deletedMemberRepository.findAll();
		return deletedMembers.stream().map(dm -> new DeletedMemberDTO(dm)).toList();
	}

	@GetMapping("/admin/members/restore/{id}")
	public String restoreMember(@PathVariable Long id) {
		DeletedMember deleted = deletedMemberRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Deleted member not found"));

		Member member = new Member();
		member.setId(deleted.getId());
		member.setName(deleted.getName());
		member.setEmail(deleted.getEmail());

		member.setPlanStartDate(deleted.getPlanStartDate());
		member.setPlanExpiryDate(deleted.getPlanExpiryDate());

		memberRepo.save(member);
		deletedMemberRepository.delete(deleted);

		return "redirect:/admin/members";
	}
	// ------------------ PLAN CRUD ------------------

	// List Plans
	@GetMapping("/plans")
	public String listPlans(Model model) {
		List<Plan> plans = planRepo.findAll();
		model.addAttribute("plans", plans);
		return "plan-list";
	}

	// Add Plan Form
	@GetMapping("/plans/add")
	public String addPlanForm(Model model) {
		model.addAttribute("plan", new Plan());
		return "plan-form";
	}

	// Save Plan
	@PostMapping("/plans/save")
	public String savePlan(@ModelAttribute Plan plan) {
		planRepo.save(plan);
		return "redirect:/admin/plans";
	}

	// Edit Plan Form
	@GetMapping("/plans/edit/{id}")
	public String editPlanForm(@PathVariable Long id, Model model) {
		Optional<Plan> p = planRepo.findById(id);
		if (p.isPresent()) {
			model.addAttribute("plan", p.get());
			return "plan-form";
		}
		return "redirect:/admin/plans";
	}

	// Delete Plan
	@GetMapping("/plans/delete/{id}")
	public String deletePlan(@PathVariable Long id) {
		planRepo.deleteById(id);
		return "redirect:/admin/plans";
	}
}
