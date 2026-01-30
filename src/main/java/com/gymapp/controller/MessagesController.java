package com.gymapp.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Member;
import com.gymapp.entity.Trainer;
import com.gymapp.repository.AdminMessageRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/messages")
public class MessagesController {

	@Autowired
	private AdminMessageRepository messageRepo;

	// Display messages for logged-in member
	@GetMapping("/member")
	public String memberMessages(HttpSession session, Model model) {
		Member member = (Member) session.getAttribute("member");
		if (member != null) {
			model.addAttribute("messages", messageRepo.findBySenderIdAndSenderRole(member.getId(), "Member"));
		}
		return "member-messages";
	}

	// Display messages for logged-in trainer
	@GetMapping("/trainer")
	public String trainerMessages(HttpSession session, Model model) {
		Trainer trainer = (Trainer) session.getAttribute("trainer");
		if (trainer != null) {
			model.addAttribute("messages", messageRepo.findBySenderIdAndSenderRole(trainer.getId(), "Trainer"));
		}
		return "trainer-messages";
	}

	// Send message to admin
	@PostMapping("/send")
	public String sendMessage(@RequestParam String message, HttpSession session) {
		Object user = session.getAttribute("member");
		String role = "Member";
		Long userId = null;
		String userName = "";

		if (user == null) {
			user = session.getAttribute("trainer");
			role = "Trainer";
		}

		if (user != null) {
			if (role.equals("Member")) {
				Member m = (Member) user;
				userId = m.getId();
				userName = m.getName();
			} else {
				Trainer t = (Trainer) user;
				userId = t.getId();
				userName = t.getName();
			}

			AdminMessage msg = new AdminMessage();
			msg.setSenderId(userId);
			msg.setSenderName(userName);
			msg.setSenderRole(role);
			msg.setMessage(message);
			msg.setSentAt(LocalDateTime.now());
			messageRepo.save(msg);
		}

		return "redirect:/messages/" + role.toLowerCase();
	}
}
