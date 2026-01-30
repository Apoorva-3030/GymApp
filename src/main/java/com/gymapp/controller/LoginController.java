package com.gymapp.controller;

import com.gymapp.entity.Admin;
import com.gymapp.entity.Member;
import com.gymapp.entity.Trainer;
import com.gymapp.repository.AdminRepository;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.TrainerRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	private AdminRepository adminRepo;

	@Autowired
	private TrainerRepository trainerRepo;

	@Autowired
	private MemberRepository memberRepo;

	@GetMapping("/{role}")
	public String loginPage(@PathVariable String role, Model model) {
		model.addAttribute("role", role.substring(0, 1).toUpperCase() + role.substring(1));
		return "login";
	}

	@PostMapping("/admin")
	public String adminLogin(@RequestParam String email, @RequestParam String password, Model model,
			HttpSession session) {
		Admin admin = adminRepo.findByEmailAndPassword(email, password);
		if (admin != null) {
			session.setAttribute("admin", admin);
			return "redirect:/admin/dashboard";
		}
		model.addAttribute("role", "Admin");
		model.addAttribute("error", "Invalid email or password");
		return "login";
	}

	@PostMapping("/trainer")
	public String trainerLogin(@RequestParam String email, @RequestParam String password, Model model,
			HttpSession session) {
		Trainer trainer = trainerRepo.findByEmailAndPassword(email, password);
		if (trainer != null) {
			session.setAttribute("trainer", trainer);
			return "redirect:/trainer/dashboard";
		}
		model.addAttribute("role", "Trainer");
		model.addAttribute("error", "Invalid email or password");
		return "login";
	}

	@PostMapping("/member")
	public String memberLogin(@RequestParam String email, @RequestParam String password, Model model,
			HttpSession session) {
		Member member = memberRepo.findByEmailAndPassword(email, password);
		if (member != null) {
			session.setAttribute("member", member);
			return "redirect:/member/dashboard";
		}
		model.addAttribute("role", "Member");
		model.addAttribute("error", "Invalid email or password");
		return "login";
	}

}
