package com.gymapp.controller;

import com.gymapp.entity.Trainer;
import com.gymapp.repository.TrainerRepository;
import com.gymapp.repository.AdminRepository;
import com.gymapp.repository.MemberRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(LoginController.class) // Test only the LoginController
public class TrainerLoginTest {

    @Autowired
    private MockMvc mockMvc; // Inject MockMvc to simulate HTTP requests

    @MockBean
    private AdminRepository adminRepo; // Mock AdminRepository

    @MockBean
    private TrainerRepository trainerRepo; // Mock TrainerRepository

    @MockBean
    private MemberRepository memberRepo; // Mock MemberRepository

    @Test
    void testTrainerLoginSuccess() throws Exception {
        // Mock Trainer object for a successful login
        Trainer trainer = new Trainer();
        trainer.setId(1L);
        trainer.setEmail("trainer@example.com");
        trainer.setPassword("trainer123");

        // Mock the repository call to return the trainer
        when(trainerRepo.findByEmailAndPassword("trainer@example.com", "trainer123")).thenReturn(trainer);

        // Perform the POST request to /login/trainer with valid credentials and assert the result
        mockMvc.perform(post("/login/trainer")
                        .param("email", "trainer@example.com")
                        .param("password", "trainer123"))
                .andExpect(status().is3xxRedirection()) // Expect redirection
                .andExpect(redirectedUrl("/trainer/dashboard")); // Expect to redirect to /trainer/dashboard
    }

    @Test
    void testTrainerLoginFailure() throws Exception {
        // Mock repository to return null for invalid credentials
        when(trainerRepo.findByEmailAndPassword("wrong@example.com", "wrongpass")).thenReturn(null);

        // Perform the POST request with incorrect credentials
        mockMvc.perform(post("/login/trainer")
                        .param("email", "wrong@example.com")
                        .param("password", "wrongpass"))
                .andExpect(status().isOk()) // Expect the status to be OK (200)
                .andExpect(model().attributeExists("error")) // Expect the "error" attribute to be present in the model
                .andExpect(view().name("login")); // Expect the view to be "login"
    }
}

