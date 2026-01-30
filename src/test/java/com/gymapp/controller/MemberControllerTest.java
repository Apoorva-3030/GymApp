package com.gymapp.controller;

import com.gymapp.controller.MemberController;
import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Member;
import com.gymapp.repository.AdminMessageRepository;
import com.gymapp.repository.MemberRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(MemberController.class)
public class MemberControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private MemberRepository memberRepo;

    @MockBean
    private AdminMessageRepository messageRepo;

    @Test
    void testMemberDashboardWithSession() throws Exception {
        Member member = new Member();
        member.setId(1L);
        member.setName("John Doe");

        MockHttpSession session = new MockHttpSession();
        session.setAttribute("member", member);

        when(messageRepo.findAll()).thenReturn(java.util.Collections.emptyList());

        mockMvc.perform(get("/member/dashboard").session(session))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("member"))
                .andExpect(model().attributeExists("messages"))
                .andExpect(view().name("member-dashboard"));
    }

    @Test
    void testMemberDashboardWithoutSession() throws Exception {
        mockMvc.perform(get("/member/dashboard"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login/member"));
    }

    @Test
    void testMemberSendMessage() throws Exception {
        Member member = new Member();
        member.setId(1L);
        member.setName("John Doe");

        MockHttpSession session = new MockHttpSession();
        session.setAttribute("member", member);

        mockMvc.perform(post("/member/message/send")
                        .param("message", "Hello Admin")
                        .session(session))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/member/dashboard?sent=true"));

        verify(messageRepo, times(1)).save(any(AdminMessage.class));
    }

    @Test
    void testMemberSendMessageWithoutSession() throws Exception {
        mockMvc.perform(post("/member/message/send")
                        .param("message", "Hello Admin"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login/member"));

        verify(messageRepo, never()).save(any());
    }
}
