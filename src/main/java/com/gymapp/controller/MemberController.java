package com.gymapp.controller;

import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Member;
import com.gymapp.repository.AdminMessageRepository;
import com.gymapp.repository.MemberRepository;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberRepository memberRepo;
	@Autowired
	private AdminMessageRepository adminMessageRepository;

	@GetMapping("/dashboard")
	public String memberDashboard(HttpSession session, Model model) {
		Member member = (Member) session.getAttribute("member");

		if (member == null) {
			return "redirect:/login/member";
		}
		model.addAttribute("member", member);
		model.addAttribute("messages", adminMessageRepository.findAll());

		return "member-dashboard";
	}

	@PostMapping("/message/send")
	public String memberSendMessage(@RequestParam String message, HttpSession session) {
		Member member = (Member) session.getAttribute("member");

		if (member == null) {
			return "redirect:/login/member";
		}

		AdminMessage msg = new AdminMessage();
		msg.setSenderRole("MEMBER");
		msg.setSenderId(member.getId());
		msg.setSenderName(member.getName());
		msg.setMessage(message);
		msg.setSentAt(LocalDateTime.now());

		adminMessageRepository.save(msg);

		return "redirect:/member/dashboard?sent=true";
	}

}
