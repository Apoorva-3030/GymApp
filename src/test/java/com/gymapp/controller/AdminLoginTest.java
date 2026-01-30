package com.gymapp.controller;

import com.gymapp.repository.AdminRepository;
import com.gymapp.repository.TrainerRepository;
import com.gymapp.repository.MemberRepository;
import com.gymapp.entity.Admin;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(LoginController.class) // Test only the LoginController
public class AdminLoginTest {

	@Autowired
	private MockMvc mockMvc; // Inject MockMvc to simulate HTTP requests

	@MockBean
	private AdminRepository adminRepo; // Mock AdminRepository

	@MockBean
	private TrainerRepository trainerRepo; // Mock TrainerRepository

	@MockBean
	private MemberRepository memberRepo; // Mock MemberRepository

	@Test
	void testAdminLoginSuccess() throws Exception {
		// Mock Admin object for a successful login
		Admin admin = new Admin();
		admin.setId(1L);
		admin.setEmail("admin@example.com");
		admin.setPassword("admin123");

		// Mock the repository call to return the admin
		when(adminRepo.findByEmailAndPassword("admin@example.com", "admin123")).thenReturn(admin);

		// Perform the POST request to /login/admin with valid credentials and assert
		// the result
		mockMvc.perform(post("/login/admin").param("email", "admin@example.com").param("password", "admin123"))
				.andExpect(status().is3xxRedirection()) // Expect redirection
				.andExpect(redirectedUrl("/admin/dashboard")); // Expect to redirect to /admin/dashboard
	}

	@Test
	void testAdminLoginFailure() throws Exception {
		// Mock repository to return null for invalid credentials
		when(adminRepo.findByEmailAndPassword("wrong@example.com", "wrongpass")).thenReturn(null);

		// Perform the POST request with incorrect credentials
		mockMvc.perform(post("/login/admin").param("email", "wrong@example.com").param("password", "wrongpass"))
				.andExpect(status().isOk()) // Expect the status to be OK (200)
				.andExpect(model().attributeExists("error")) // Expect the "error" attribute to be present in the model
				.andExpect(view().name("login")); // Expect the view to be "login"
	}
}
