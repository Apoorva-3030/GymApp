package com.gymapp.controller;

import com.gymapp.entity.Member;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.TrainerRepository;
import com.gymapp.repository.AdminRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(LoginController.class) // Test only the LoginController
public class MemberLoginTest {

    @Autowired
    private MockMvc mockMvc; // Inject MockMvc to simulate HTTP requests

    @MockBean
    private AdminRepository adminRepo; // Mock AdminRepository

    @MockBean
    private TrainerRepository trainerRepo; // Mock TrainerRepository

    @MockBean
    private MemberRepository memberRepo; // Mock MemberRepository

    @Test
    void testMemberLoginSuccess() throws Exception {
        // Mock Member object for a successful login
        Member member = new Member();
        member.setId(1L);
        member.setEmail("member@example.com");
        member.setPassword("member123");

        // Mock the repository call to return the member
        when(memberRepo.findByEmailAndPassword("member@example.com", "member123")).thenReturn(member);

        // Perform the POST request to /login/member with valid credentials and assert the result
        mockMvc.perform(post("/login/member")
                        .param("email", "member@example.com")
                        .param("password", "member123"))
                .andExpect(status().is3xxRedirection()) // Expect redirection
                .andExpect(redirectedUrl("/member/dashboard")); // Expect to redirect to /member/dashboard
    }

    @Test
    void testMemberLoginFailure() throws Exception {
        // Mock repository to return null for invalid credentials
        when(memberRepo.findByEmailAndPassword("wrong@example.com", "wrongpass")).thenReturn(null);

        // Perform the POST request with incorrect credentials
        mockMvc.perform(post("/login/member")
                        .param("email", "wrong@example.com")
                        .param("password", "wrongpass"))
                .andExpect(status().isOk()) // Expect the status to be OK (200)
                .andExpect(model().attributeExists("error")) // Expect the "error" attribute to be present in the model
                .andExpect(view().name("login")); // Expect the view to be "login"
    }
}
