package com.gymapp.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // destroys the session
		return "redirect:/"; // redirect to home page
	}
}
