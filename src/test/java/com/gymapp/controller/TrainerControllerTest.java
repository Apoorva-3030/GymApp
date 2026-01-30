package com.gymapp.controller;



import com.gymapp.controller.TrainerController;
import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Trainer;
import com.gymapp.repository.AdminMessageRepository;
import com.gymapp.repository.MemberRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(TrainerController.class)
public class TrainerControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private MemberRepository memberRepo;

    @MockBean
    private AdminMessageRepository messageRepo;

    @Test
    void testTrainerDashboardWithSession() throws Exception {
        Trainer trainer = new Trainer();
        trainer.setId(1L);
        trainer.setName("Jane Doe");

        MockHttpSession session = new MockHttpSession();
        session.setAttribute("trainer", trainer);

        when(memberRepo.findByTrainer(trainer)).thenReturn(java.util.Collections.emptyList());

        mockMvc.perform(get("/trainer/dashboard").session(session))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("trainer"))
                .andExpect(model().attributeExists("members"))
                .andExpect(view().name("trainer-dashboard"));
    }

    @Test
    void testTrainerDashboardWithoutSession() throws Exception {
        mockMvc.perform(get("/trainer/dashboard"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login/trainer"));
    }

    @Test
    void testTrainerSendMessage() throws Exception {
        Trainer trainer = new Trainer();
        trainer.setId(1L);
        trainer.setName("Jane Doe");

        MockHttpSession session = new MockHttpSession();
        session.setAttribute("trainer", trainer);

        mockMvc.perform(post("/trainer/message/send")
                        .param("message", "Hello Admin")
                        .session(session))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/trainer/dashboard?sent=true"));

        verify(messageRepo, times(1)).save(any(AdminMessage.class));
    }

    @Test
    void testTrainerSendMessageWithoutSession() throws Exception {
        mockMvc.perform(post("/trainer/message/send")
                        .param("message", "Hello Admin"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login/trainer"));

        verify(messageRepo, never()).save(any());
    }
}
