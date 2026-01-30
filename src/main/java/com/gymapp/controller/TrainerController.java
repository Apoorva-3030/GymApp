package com.gymapp.controller;

import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Trainer;
import com.gymapp.repository.AdminMessageRepository;
import com.gymapp.repository.MemberRepository;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/trainer")
public class TrainerController {
	@Autowired
	private AdminMessageRepository adminMessageRepository;
	@Autowired
	private MemberRepository memberRepo;

	@GetMapping("/dashboard")
	public String trainerDashboard(HttpSession session, Model model) {
		Trainer trainer = (Trainer) session.getAttribute("trainer");

		if (trainer == null) {
			return "redirect:/login/trainer";
		}

		// Add trainer object to model
		model.addAttribute("trainer", trainer);

		// Add members assigned to this trainer
		model.addAttribute("members", memberRepo.findByTrainer(trainer));

		return "trainer-dashboard"; // JSP page
	}

	@PostMapping("/message/send")
	public String trainerSendMessage(@RequestParam String message, HttpSession session) {
		Trainer trainer = (Trainer) session.getAttribute("trainer");

		if (trainer == null) {
			return "redirect:/login/trainer";
		}

		AdminMessage msg = new AdminMessage();
		msg.setSenderRole("TRAINER");
		msg.setSenderId(trainer.getId());
		msg.setSenderName(trainer.getName());
		msg.setMessage(message);
		msg.setSentAt(LocalDateTime.now());

		adminMessageRepository.save(msg);

		return "redirect:/trainer/dashboard?sent=true";
	}

}
