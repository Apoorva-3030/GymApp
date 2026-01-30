package com.gymapp.controller;

import com.gymapp.entity.Admin;
import com.gymapp.repository.AdminRepository;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.TrainerRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(LoginController.class)
public class LoginControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AdminRepository adminRepo;

    @MockBean
    private TrainerRepository trainerRepo;

    @MockBean
    private MemberRepository memberRepo;

    @Test
    void testAdminLoginSuccess() throws Exception {
        Admin admin = new Admin();
        admin.setId(1L);
        admin.setEmail("admin@gmail.com");
        admin.setPassword("admin123");

        when(adminRepo.findByEmailAndPassword("admin@gmail.com", "admin123")).thenReturn(admin);

        mockMvc.perform(post("/login/admin")
                        .param("email", "admin@gmail.com")
                        .param("password", "admin123"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/admin/dashboard"));
    }

    @Test
    void testAdminLoginFailure() throws Exception {
        when(adminRepo.findByEmailAndPassword("wrong@gmail.com", "wrong")).thenReturn(null);

        mockMvc.perform(post("/login/admin")
                        .param("email", "wrong@gmail.com")
                        .param("password", "wrong"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("error"))
                .andExpect(view().name("login"));
    }
}
